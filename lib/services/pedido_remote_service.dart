import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/pedido.dart';
import 'app_logger.dart';

class PedidoRemoteService {
  final bool firebaseEnabled;

  const PedidoRemoteService({required this.firebaseEnabled});

  CollectionReference<Map<String, dynamic>> get _pedidosRef =>
      FirebaseFirestore.instance.collection('pedidos');

  Future<void> upsertPedido(Pedido pedido) async {
    _ensureEnabled();

    await _pedidosRef.doc(pedido.id.toString()).set(pedido.toFirestore());

    AppLogger.info('Pedido sincronizado en Firebase: ${pedido.id}');
  }

  Future<void> deletePedido(int pedidoId) async {
    _ensureEnabled();

    await _pedidosRef.doc(pedidoId.toString()).delete();

    AppLogger.info('Pedido eliminado de Firebase: $pedidoId');
  }

  Future<List<Pedido>> fetchPedidos() async {
    _ensureEnabled();

    final snapshot = await _pedidosRef.get();

    return snapshot.docs
        .map(
          (doc) => Pedido.fromFirestore(
            doc.data(),
            fallbackId: doc.id,
            pendingSyncOverride: false,
          ),
        )
        .toList();
  }

  void _ensureEnabled() {
    if (!firebaseEnabled) {
      throw StateError('Firebase no está configurado para esta ejecución.');
    }
  }
}
