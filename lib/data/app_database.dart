import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../models/pedido.dart';

part 'app_database.g.dart';

class PedidosTable extends Table {
  IntColumn get id => integer()();
  TextColumn get nombre => text()();
  TextColumn get cantidad => text()();
  TextColumn get direccion => text()();
  TextColumn get descripcion => text()();
  RealColumn get precio => real()();
  BoolColumn get pendingSync => boolean().withDefault(const Constant(true))();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

class PendingDeletes extends Table {
  IntColumn get id => integer()();
  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DriftDatabase(tables: [PedidosTable, PendingDeletes])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'rappi_pedidos_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }

  Pedido _mapPedido(PedidosTableData row) {
    return Pedido.fromSqlite({
      'id': row.id,
      'nombre': row.nombre,
      'cantidad': row.cantidad,
      'direccion': row.direccion,
      'descripcion': row.descripcion,
      'precio': row.precio,
      'pending_sync': row.pendingSync ? 1 : 0,
      'updated_at_ms': row.updatedAtMs,
    });
  }

  Stream<List<Pedido>> watchPedidos() {
    final query = select(pedidosTable)
      ..orderBy([(table) => OrderingTerm.desc(table.updatedAtMs)]);

    return query.watch().map((rows) => rows.map(_mapPedido).toList());
  }

  Future<void> insertPedido(Pedido pedido) async {
    final data = pedido.toSqlite();

    await into(pedidosTable).insertOnConflictUpdate(
      PedidosTableCompanion(
        id: Value(data['id'] as int),
        nombre: Value(data['nombre'] as String),
        cantidad: Value(data['cantidad'] as String),
        direccion: Value(data['direccion'] as String),
        descripcion: Value(data['descripcion'] as String),
        precio: Value(data['precio'] as double),
        pendingSync: Value(((data['pending_sync'] as int?) ?? 0) == 1),
        updatedAtMs: Value(data['updated_at_ms'] as int),
      ),
    );
  }

  Future<void> updatePedido(Pedido pedido) async {
    await insertPedido(pedido);
  }

  Future<void> deletePedidoLocal(int id) async {
    await (delete(pedidosTable)..where((table) => table.id.equals(id))).go();
  }

  Future<List<Pedido>> getPendingPedidos() async {
    final rows = await (select(
      pedidosTable,
    )..where((table) => table.pendingSync.equals(true))).get();

    return rows.map(_mapPedido).toList();
  }

  Future<void> markAsSynced(int id) async {
    await (update(pedidosTable)..where((table) => table.id.equals(id))).write(
      const PedidosTableCompanion(pendingSync: Value(false)),
    );
  }

  Future<void> upsertFromRemote(Pedido pedido) async {
    await into(pedidosTable).insertOnConflictUpdate(
      PedidosTableCompanion(
        id: Value(pedido.id),
        nombre: Value(pedido.nombre),
        cantidad: Value(pedido.cantidad),
        direccion: Value(pedido.direccion),
        descripcion: Value(pedido.descripcion),
        precio: Value(pedido.precio),
        pendingSync: const Value(false),
        updatedAtMs: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<void> savePendingDelete(int id) async {
    await into(pendingDeletes).insertOnConflictUpdate(
      PendingDeletesCompanion(
        id: Value(id),
        updatedAtMs: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );
  }

  Future<List<int>> getPendingDeleteIds() async {
    final rows = await select(pendingDeletes).get();
    return rows.map((row) => row.id).toList();
  }

  Future<void> clearPendingDelete(int id) async {
    await (delete(pendingDeletes)..where((table) => table.id.equals(id))).go();
  }
}
