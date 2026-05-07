import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/pedido.dart';
import 'app_logger.dart';

enum QaRemoteFailure {
  none,
  permissionDenied,
  network,
  unexpected,
}

class PedidoRemoteService {
  final bool firebaseEnabled;

  PedidoRemoteService({required this.firebaseEnabled});

  CollectionReference<Map<String, dynamic>> get _pedidosRef =>
      FirebaseFirestore.instance.collection('pedidos');

  Future<void> upsertPedido(Pedido pedido) async {
    _ensureEnabled();

    AppLogger.debug('Intentando guardar pedido en Firebase');

    try {
      await _pedidosRef.doc(pedido.id.toString()).set(pedido.toFirestore());

      AppLogger.info('Pedido sincronizado en Firebase: ${pedido.id}');
    } on FirebaseException catch (error, stackTrace) {
      AppLogger.error(
        'FirebaseException guardando pedido remoto',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } on SocketException catch (error, stackTrace) {
      AppLogger.error(
        'Error de red guardando pedido remoto',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (error, stackTrace) {
      AppLogger.error(
        'Error inesperado guardando pedido remot',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> deletePedido(int pedidoId) async {
    _ensureEnabled();

    AppLogger.debug('Intentando eliminar pedido remoto');

    try {
      await _pedidosRef.doc(pedidoId.toString()).delete();

      AppLogger.info('Pedido eliminado de Firebase');
    } on FirebaseException catch (error, stackTrace) {
      AppLogger.error(
        'FirebaseException eliminando pedido remoto',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } on SocketException catch (error, stackTrace) {
      AppLogger.error(
        'Error de red eliminando pedido remoto',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (error, stackTrace) {
      AppLogger.error(
        'Error inesperado eliminando pedido remoto',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<List<Pedido>> fetchPedidos() async {
    _ensureEnabled();

    AppLogger.debug('Consultando pedidos desde Firebase');

    try {
      final snapshot = await _pedidosRef.get();

      AppLogger.info(
        'Pedidos obtenidos desde Firebase: ${snapshot.docs.length}',
      );

      return snapshot.docs
          .map(
            (doc) => Pedido.fromFirestore(
              doc.data(),
              fallbackId: doc.id,
              pendingSyncOverride: false,
            ),
          )
          .toList();
    } on FirebaseException catch (error, stackTrace) {
      AppLogger.error(
        'FirebaseException consultando pedidos remotos',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } on SocketException catch (error, stackTrace) {
      AppLogger.error(
        'Error de red consultando pedidos remotos',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    } catch (error, stackTrace) {
      AppLogger.error(
        'Error inesperado consultando pedidos remotos',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  void _ensureEnabled() {
    if (!firebaseEnabled) {
      throw StateError('Firebase no está configurado para esta ejecución.');
    }
  }
}
