// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PedidosTableTable extends PedidosTable
    with TableInfo<$PedidosTableTable, PedidosTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PedidosTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<String> cantidad = GeneratedColumn<String>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
    'precio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    cantidad,
    direccion,
    descripcion,
    precio,
    pendingSync,
    updatedAtMs,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pedidos_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PedidosTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    } else if (isInserting) {
      context.missing(_direccionMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(
        _precioMeta,
        precio.isAcceptableOrUnknown(data['precio']!, _precioMeta),
      );
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PedidosTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PedidosTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cantidad'],
      )!,
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      precio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $PedidosTableTable createAlias(String alias) {
    return $PedidosTableTable(attachedDatabase, alias);
  }
}

class PedidosTableData extends DataClass
    implements Insertable<PedidosTableData> {
  final int id;
  final String nombre;
  final String cantidad;
  final String direccion;
  final String descripcion;
  final double precio;
  final bool pendingSync;
  final int updatedAtMs;
  const PedidosTableData({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.direccion,
    required this.descripcion,
    required this.precio,
    required this.pendingSync,
    required this.updatedAtMs,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['cantidad'] = Variable<String>(cantidad);
    map['direccion'] = Variable<String>(direccion);
    map['descripcion'] = Variable<String>(descripcion);
    map['precio'] = Variable<double>(precio);
    map['pending_sync'] = Variable<bool>(pendingSync);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  PedidosTableCompanion toCompanion(bool nullToAbsent) {
    return PedidosTableCompanion(
      id: Value(id),
      nombre: Value(nombre),
      cantidad: Value(cantidad),
      direccion: Value(direccion),
      descripcion: Value(descripcion),
      precio: Value(precio),
      pendingSync: Value(pendingSync),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory PedidosTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PedidosTableData(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      cantidad: serializer.fromJson<String>(json['cantidad']),
      direccion: serializer.fromJson<String>(json['direccion']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      precio: serializer.fromJson<double>(json['precio']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'cantidad': serializer.toJson<String>(cantidad),
      'direccion': serializer.toJson<String>(direccion),
      'descripcion': serializer.toJson<String>(descripcion),
      'precio': serializer.toJson<double>(precio),
      'pendingSync': serializer.toJson<bool>(pendingSync),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  PedidosTableData copyWith({
    int? id,
    String? nombre,
    String? cantidad,
    String? direccion,
    String? descripcion,
    double? precio,
    bool? pendingSync,
    int? updatedAtMs,
  }) => PedidosTableData(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    cantidad: cantidad ?? this.cantidad,
    direccion: direccion ?? this.direccion,
    descripcion: descripcion ?? this.descripcion,
    precio: precio ?? this.precio,
    pendingSync: pendingSync ?? this.pendingSync,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  PedidosTableData copyWithCompanion(PedidosTableCompanion data) {
    return PedidosTableData(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      precio: data.precio.present ? data.precio.value : this.precio,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PedidosTableData(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('cantidad: $cantidad, ')
          ..write('direccion: $direccion, ')
          ..write('descripcion: $descripcion, ')
          ..write('precio: $precio, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    cantidad,
    direccion,
    descripcion,
    precio,
    pendingSync,
    updatedAtMs,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PedidosTableData &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.cantidad == this.cantidad &&
          other.direccion == this.direccion &&
          other.descripcion == this.descripcion &&
          other.precio == this.precio &&
          other.pendingSync == this.pendingSync &&
          other.updatedAtMs == this.updatedAtMs);
}

class PedidosTableCompanion extends UpdateCompanion<PedidosTableData> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> cantidad;
  final Value<String> direccion;
  final Value<String> descripcion;
  final Value<double> precio;
  final Value<bool> pendingSync;
  final Value<int> updatedAtMs;
  const PedidosTableCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.direccion = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.precio = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
  });
  PedidosTableCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String cantidad,
    required String direccion,
    required String descripcion,
    required double precio,
    this.pendingSync = const Value.absent(),
    required int updatedAtMs,
  }) : nombre = Value(nombre),
       cantidad = Value(cantidad),
       direccion = Value(direccion),
       descripcion = Value(descripcion),
       precio = Value(precio),
       updatedAtMs = Value(updatedAtMs);
  static Insertable<PedidosTableData> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? cantidad,
    Expression<String>? direccion,
    Expression<String>? descripcion,
    Expression<double>? precio,
    Expression<bool>? pendingSync,
    Expression<int>? updatedAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (cantidad != null) 'cantidad': cantidad,
      if (direccion != null) 'direccion': direccion,
      if (descripcion != null) 'descripcion': descripcion,
      if (precio != null) 'precio': precio,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
    });
  }

  PedidosTableCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? cantidad,
    Value<String>? direccion,
    Value<String>? descripcion,
    Value<double>? precio,
    Value<bool>? pendingSync,
    Value<int>? updatedAtMs,
  }) {
    return PedidosTableCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      direccion: direccion ?? this.direccion,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      pendingSync: pendingSync ?? this.pendingSync,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<String>(cantidad.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PedidosTableCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('cantidad: $cantidad, ')
          ..write('direccion: $direccion, ')
          ..write('descripcion: $descripcion, ')
          ..write('precio: $precio, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }
}

class $PendingDeletesTable extends PendingDeletes
    with TableInfo<$PendingDeletesTable, PendingDelete> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingDeletesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMsMeta = const VerificationMeta(
    'updatedAtMs',
  );
  @override
  late final GeneratedColumn<int> updatedAtMs = GeneratedColumn<int>(
    'updated_at_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, updatedAtMs];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_deletes';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingDelete> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('updated_at_ms')) {
      context.handle(
        _updatedAtMsMeta,
        updatedAtMs.isAcceptableOrUnknown(
          data['updated_at_ms']!,
          _updatedAtMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingDelete map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingDelete(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      updatedAtMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}updated_at_ms'],
      )!,
    );
  }

  @override
  $PendingDeletesTable createAlias(String alias) {
    return $PendingDeletesTable(attachedDatabase, alias);
  }
}

class PendingDelete extends DataClass implements Insertable<PendingDelete> {
  final int id;
  final int updatedAtMs;
  const PendingDelete({required this.id, required this.updatedAtMs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['updated_at_ms'] = Variable<int>(updatedAtMs);
    return map;
  }

  PendingDeletesCompanion toCompanion(bool nullToAbsent) {
    return PendingDeletesCompanion(
      id: Value(id),
      updatedAtMs: Value(updatedAtMs),
    );
  }

  factory PendingDelete.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingDelete(
      id: serializer.fromJson<int>(json['id']),
      updatedAtMs: serializer.fromJson<int>(json['updatedAtMs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'updatedAtMs': serializer.toJson<int>(updatedAtMs),
    };
  }

  PendingDelete copyWith({int? id, int? updatedAtMs}) => PendingDelete(
    id: id ?? this.id,
    updatedAtMs: updatedAtMs ?? this.updatedAtMs,
  );
  PendingDelete copyWithCompanion(PendingDeletesCompanion data) {
    return PendingDelete(
      id: data.id.present ? data.id.value : this.id,
      updatedAtMs: data.updatedAtMs.present
          ? data.updatedAtMs.value
          : this.updatedAtMs,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingDelete(')
          ..write('id: $id, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, updatedAtMs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingDelete &&
          other.id == this.id &&
          other.updatedAtMs == this.updatedAtMs);
}

class PendingDeletesCompanion extends UpdateCompanion<PendingDelete> {
  final Value<int> id;
  final Value<int> updatedAtMs;
  const PendingDeletesCompanion({
    this.id = const Value.absent(),
    this.updatedAtMs = const Value.absent(),
  });
  PendingDeletesCompanion.insert({
    this.id = const Value.absent(),
    required int updatedAtMs,
  }) : updatedAtMs = Value(updatedAtMs);
  static Insertable<PendingDelete> custom({
    Expression<int>? id,
    Expression<int>? updatedAtMs,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (updatedAtMs != null) 'updated_at_ms': updatedAtMs,
    });
  }

  PendingDeletesCompanion copyWith({Value<int>? id, Value<int>? updatedAtMs}) {
    return PendingDeletesCompanion(
      id: id ?? this.id,
      updatedAtMs: updatedAtMs ?? this.updatedAtMs,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (updatedAtMs.present) {
      map['updated_at_ms'] = Variable<int>(updatedAtMs.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingDeletesCompanion(')
          ..write('id: $id, ')
          ..write('updatedAtMs: $updatedAtMs')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PedidosTableTable pedidosTable = $PedidosTableTable(this);
  late final $PendingDeletesTable pendingDeletes = $PendingDeletesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pedidosTable,
    pendingDeletes,
  ];
}

typedef $$PedidosTableTableCreateCompanionBuilder =
    PedidosTableCompanion Function({
      Value<int> id,
      required String nombre,
      required String cantidad,
      required String direccion,
      required String descripcion,
      required double precio,
      Value<bool> pendingSync,
      required int updatedAtMs,
    });
typedef $$PedidosTableTableUpdateCompanionBuilder =
    PedidosTableCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> cantidad,
      Value<String> direccion,
      Value<String> descripcion,
      Value<double> precio,
      Value<bool> pendingSync,
      Value<int> updatedAtMs,
    });

class $$PedidosTableTableFilterComposer
    extends Composer<_$AppDatabase, $PedidosTableTable> {
  $$PedidosTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PedidosTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PedidosTableTable> {
  $$PedidosTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PedidosTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PedidosTableTable> {
  $$PedidosTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$PedidosTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PedidosTableTable,
          PedidosTableData,
          $$PedidosTableTableFilterComposer,
          $$PedidosTableTableOrderingComposer,
          $$PedidosTableTableAnnotationComposer,
          $$PedidosTableTableCreateCompanionBuilder,
          $$PedidosTableTableUpdateCompanionBuilder,
          (
            PedidosTableData,
            BaseReferences<_$AppDatabase, $PedidosTableTable, PedidosTableData>,
          ),
          PedidosTableData,
          PrefetchHooks Function()
        > {
  $$PedidosTableTableTableManager(_$AppDatabase db, $PedidosTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PedidosTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PedidosTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PedidosTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> cantidad = const Value.absent(),
                Value<String> direccion = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<double> precio = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
              }) => PedidosTableCompanion(
                id: id,
                nombre: nombre,
                cantidad: cantidad,
                direccion: direccion,
                descripcion: descripcion,
                precio: precio,
                pendingSync: pendingSync,
                updatedAtMs: updatedAtMs,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String cantidad,
                required String direccion,
                required String descripcion,
                required double precio,
                Value<bool> pendingSync = const Value.absent(),
                required int updatedAtMs,
              }) => PedidosTableCompanion.insert(
                id: id,
                nombre: nombre,
                cantidad: cantidad,
                direccion: direccion,
                descripcion: descripcion,
                precio: precio,
                pendingSync: pendingSync,
                updatedAtMs: updatedAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PedidosTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PedidosTableTable,
      PedidosTableData,
      $$PedidosTableTableFilterComposer,
      $$PedidosTableTableOrderingComposer,
      $$PedidosTableTableAnnotationComposer,
      $$PedidosTableTableCreateCompanionBuilder,
      $$PedidosTableTableUpdateCompanionBuilder,
      (
        PedidosTableData,
        BaseReferences<_$AppDatabase, $PedidosTableTable, PedidosTableData>,
      ),
      PedidosTableData,
      PrefetchHooks Function()
    >;
typedef $$PendingDeletesTableCreateCompanionBuilder =
    PendingDeletesCompanion Function({Value<int> id, required int updatedAtMs});
typedef $$PendingDeletesTableUpdateCompanionBuilder =
    PendingDeletesCompanion Function({Value<int> id, Value<int> updatedAtMs});

class $$PendingDeletesTableFilterComposer
    extends Composer<_$AppDatabase, $PendingDeletesTable> {
  $$PendingDeletesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingDeletesTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingDeletesTable> {
  $$PendingDeletesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingDeletesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingDeletesTable> {
  $$PendingDeletesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get updatedAtMs => $composableBuilder(
    column: $table.updatedAtMs,
    builder: (column) => column,
  );
}

class $$PendingDeletesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingDeletesTable,
          PendingDelete,
          $$PendingDeletesTableFilterComposer,
          $$PendingDeletesTableOrderingComposer,
          $$PendingDeletesTableAnnotationComposer,
          $$PendingDeletesTableCreateCompanionBuilder,
          $$PendingDeletesTableUpdateCompanionBuilder,
          (
            PendingDelete,
            BaseReferences<_$AppDatabase, $PendingDeletesTable, PendingDelete>,
          ),
          PendingDelete,
          PrefetchHooks Function()
        > {
  $$PendingDeletesTableTableManager(
    _$AppDatabase db,
    $PendingDeletesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingDeletesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PendingDeletesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PendingDeletesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> updatedAtMs = const Value.absent(),
              }) => PendingDeletesCompanion(id: id, updatedAtMs: updatedAtMs),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int updatedAtMs,
              }) => PendingDeletesCompanion.insert(
                id: id,
                updatedAtMs: updatedAtMs,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingDeletesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingDeletesTable,
      PendingDelete,
      $$PendingDeletesTableFilterComposer,
      $$PendingDeletesTableOrderingComposer,
      $$PendingDeletesTableAnnotationComposer,
      $$PendingDeletesTableCreateCompanionBuilder,
      $$PendingDeletesTableUpdateCompanionBuilder,
      (
        PendingDelete,
        BaseReferences<_$AppDatabase, $PendingDeletesTable, PendingDelete>,
      ),
      PendingDelete,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PedidosTableTableTableManager get pedidosTable =>
      $$PedidosTableTableTableManager(_db, _db.pedidosTable);
  $$PendingDeletesTableTableManager get pendingDeletes =>
      $$PendingDeletesTableTableManager(_db, _db.pendingDeletes);
}
