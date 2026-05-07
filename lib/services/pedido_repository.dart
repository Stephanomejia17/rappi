import '../data/app_database.dart';
import '../models/pedido.dart';
import 'app_logger.dart';
import 'pedido_remote_service.dart';

class PedidoRepository {
  final AppDatabase localDb;
  final PedidoRemoteService remoteService;

  PedidoRepository({required this.localDb, required this.remoteService});

  Stream<List<Pedido>> watchPedidos() {
    return localDb.watchPedidos();
  }

  Future<void> loadInitialData() async {
    await refreshFromRemote();
    await syncPendingPedidos();
  }

  Future<void> addPedido({
    required String nombre,
    required String cantidad,
    required String direccion,
    required String descripcion,
    required double precio,
  }) async {
    final pedido = Pedido(
      id: DateTime.now().millisecondsSinceEpoch,
      nombre: nombre,
      cantidad: cantidad,
      direccion: direccion,
      descripcion: descripcion,
      precio: precio,
      pendingSync: true,
    );

    await localDb.insertPedido(pedido);

    try {
      await remoteService.upsertPedido(pedido);
      await localDb.markAsSynced(pedido.id);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'El pedido quedó guardado localmente y pendiente de sincronización.',
      );
      AppLogger.error(
        'Error sincronizando pedido nuevo',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updatePedido(Pedido pedido) async {
    final updatedPedido = pedido.copyWith(pendingSync: true);

    await localDb.updatePedido(updatedPedido);

    try {
      await remoteService.upsertPedido(updatedPedido);
      await localDb.markAsSynced(updatedPedido.id);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'El cambio quedó localmente y pendiente de sincronización.',
      );
      AppLogger.error(
        'Error sincronizando actualización de pedido',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> deletePedido(Pedido pedido) async {
    await localDb.deletePedidoLocal(pedido.id);
    await localDb.savePendingDelete(pedido.id);

    try {
      await remoteService.deletePedido(pedido.id);
      await localDb.clearPendingDelete(pedido.id);
    } catch (error, stackTrace) {
      AppLogger.warning(
        'El pedido se eliminó localmente y la eliminación quedó pendiente de sincronización.',
      );
      AppLogger.error(
        'Error sincronizando eliminación de pedido',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> refreshFromRemote() async {
    try {
      final pendingDeleteIds = (await localDb.getPendingDeleteIds()).toSet();
      final remotePedidos = await remoteService.fetchPedidos();

      for (final pedido in remotePedidos) {
        if (pendingDeleteIds.contains(pedido.id)) {
          continue;
        }

        await localDb.upsertFromRemote(pedido);
      }
    } catch (error, stackTrace) {
      AppLogger.error(
        'Error refrescando pedidos desde Firebase',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> syncPendingPedidos() async {
    final pendingPedidos = await localDb.getPendingPedidos();
    final pendingDeleteIds = await localDb.getPendingDeleteIds();

    for (final pedido in pendingPedidos) {
      try {
        await remoteService.upsertPedido(pedido);
        await localDb.markAsSynced(pedido.id);
      } catch (error, stackTrace) {
        AppLogger.error(
          'Error sincronizando pedido pendiente ${pedido.id}',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    for (final pedidoId in pendingDeleteIds) {
      try {
        await remoteService.deletePedido(pedidoId);
        await localDb.clearPendingDelete(pedidoId);
      } catch (error, stackTrace) {
        AppLogger.error(
          'Error sincronizando eliminación pendiente $pedidoId',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }
  }
}
