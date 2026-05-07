import 'package:flutter/material.dart';

import '../models/pedido.dart';
import '../services/pedido_repository.dart';
import '../widgets/pedido_card.dart';
import '../widgets/pedido_form_dialog.dart';

class PedidosPage extends StatefulWidget {
  final PedidoRepository repository;

  const PedidosPage({super.key, required this.repository});

  @override
  State<PedidosPage> createState() => _PedidosPageState();
}

class _PedidosPageState extends State<PedidosPage> {
  bool _loadingInitialData = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await widget.repository.loadInitialData();

    if (!mounted) {
      return;
    }

    setState(() {
      _loadingInitialData = false;
    });
  }

  Future<void> _openCreateDialog() async {
    final result = await showDialog<PedidoFormResult>(
      context: context,
      builder: (_) => const PedidoFormDialog(),
    );

    if (result == null) {
      return;
    }

    await widget.repository.addPedido(
      nombre: result.nombre,
      cantidad: result.cantidad,
      direccion: result.direccion,
      descripcion: result.descripcion,
      precio: result.precio,
    );

    _showMessage('Pedido guardado correctamente.');
  }

  Future<void> _openEditDialog(Pedido pedido) async {
    final result = await showDialog<PedidoFormResult>(
      context: context,
      builder: (_) => PedidoFormDialog(
        initialValue: PedidoFormResult(
          nombre: pedido.nombre,
          cantidad: pedido.cantidad,
          direccion: pedido.direccion,
          descripcion: pedido.descripcion,
          precio: pedido.precio,
        ),
      ),
    );

    if (result == null) {
      return;
    }

    await widget.repository.updatePedido(
      pedido.copyWith(
        nombre: result.nombre,
        cantidad: result.cantidad,
        direccion: result.direccion,
        descripcion: result.descripcion,
        precio: result.precio,
      ),
    );

    _showMessage('Pedido actualizado.');
  }

  Future<void> _deletePedido(Pedido pedido) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Eliminar pedido'),
            content: Text('Se eliminará el pedido "${pedido.nombre}".'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Eliminar'),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    await widget.repository.deletePedido(pedido);
    _showMessage('Pedido eliminado localmente.');
  }

  Future<void> _manualSync() async {
    await widget.repository.syncPendingPedidos();
    await widget.repository.refreshFromRemote();

    _showMessage('Sincronización ejecutada.');
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes de domicilio'),
        actions: [
          IconButton(
            onPressed: _manualSync,
            icon: const Icon(Icons.sync),
            tooltip: 'Sincronizar',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateDialog,
        icon: const Icon(Icons.add_home_work_outlined),
        label: const Text('Nuevo pedido'),
      ),
      body: StreamBuilder<List<Pedido>>(
        stream: widget.repository.watchPedidos(),
        builder: (context, snapshot) {
          if (_loadingInitialData) {
            return const Center(child: CircularProgressIndicator());
          }

          final pedidos = snapshot.data ?? const <Pedido>[];
          final total = pedidos.fold<double>(
            0,
            (sum, pedido) => sum + pedido.precio,
          );
          final pending = pedidos.where((pedido) => pedido.pendingSync).length;

          return RefreshIndicator(
            onRefresh: () async {
              await widget.repository.refreshFromRemote();
              await widget.repository.syncPendingPedidos();
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              children: [
                _DashboardHeader(
                  totalPedidos: pedidos.length,
                  pendientes: pending,
                  totalValor: total,
                ),
                const SizedBox(height: 20),
                if (pedidos.isEmpty)
                  const _EmptyState()
                else
                  for (final pedido in pedidos)
                    PedidoCard(
                      pedido: pedido,
                      onTap: () => _openEditDialog(pedido),
                      onDelete: () => _deletePedido(pedido),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  final int totalPedidos;
  final int pendientes;
  final double totalValor;

  const _DashboardHeader({
    required this.totalPedidos,
    required this.pendientes,
    required this.totalValor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A00), Color(0xFFFFB74D)],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Control de domicilios',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Registra, actualiza y sincroniza pedidos incluso cuando la red falla.',
            style: TextStyle(color: Colors.white, height: 1.4),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _MetricCard(label: 'Pedidos', value: '$totalPedidos'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(label: 'Pendientes', value: '$pendientes'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _MetricCard(
                  label: 'Total',
                  value: '\$${totalValor.toStringAsFixed(0)}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;

  const _MetricCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.local_shipping_outlined,
            size: 56,
            color: Color(0xFFFF8A00),
          ),
          SizedBox(height: 16),
          Text(
            'Todavía no hay solicitudes',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Crea tu primer pedido para empezar a gestionar domicilios y ver su sincronización.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
