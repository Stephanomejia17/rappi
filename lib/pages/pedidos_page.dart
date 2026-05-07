import 'package:flutter/foundation.dart';
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

    _showMessage('Pedido guardado correctamente');
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

    _showMessage('Pedido actualizado');
  }

  Future<void> _deletePedido(Pedido pedido) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Eliminar pedido'),
            content: Text('Se eliminará el pedido "${pedido.nombre}"'),
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
    _showMessage('Pedido eliminado localmente');
  }

  Future<void> _manualSync() async {
    await widget.repository.syncPendingPedidos();
    await widget.repository.refreshFromRemote();

    _showMessage('Sincronización ejecutada');
  }

  Future<void> _runQaAction(
    String successMessage,
    Future<void> Function() action,
  ) async {
    try {
      await action();
      _showMessage(successMessage);
    } catch (_) {
      _showMessage('La acción QA generó un error revisa los logs');
    }
  }

  Widget _buildQaMenu() {
    if (!kDebugMode) {
      return const SizedBox.shrink();
    }

    return PopupMenuButton<String>(
      tooltip: 'Herramientas QA',
      icon: const Icon(Icons.bug_report_outlined),
      onSelected: (value) {

        if (value == 'Cantidad Libre') {
          _runQaAction(
            'QA: pedido con cantidad string y descripción larga creado',
            widget.repository.qaCreatePedidoWithStringCantidad,
          );
        }

        if (value == 'Descripcion larga') {
          _runQaAction(
            'QA: pedido con cantidad string y descripción larga creado',
            widget.repository.qaCreatePedidoWithLongDescription,
          );
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: 'Cantidad Libre',
          child: Text(' Cantidad String'),
        ),
        PopupMenuItem(
          value: 'Descripcion larga',
          child: Text('Descripcion larga'),
        ),
      ],
    );
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
        title: const Text('Rappi'),
        actions: [
          _buildQaMenu(),
          IconButton(
            onPressed: _manualSync,
            icon: const Icon(Icons.sync),
            tooltip: 'Sincronizar',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateDialog,
        label: const Text('Nuevo pedido'),
      ),
      body: StreamBuilder<List<Pedido>>(
        stream: widget.repository.watchPedidos(),
        builder: (context, snapshot) {
          if (_loadingInitialData) {
            return const Center(child: CircularProgressIndicator());
          }

          final pedidos = snapshot.data ?? const <Pedido>[];

          return RefreshIndicator(
            onRefresh: () async {
              await widget.repository.refreshFromRemote();
              await widget.repository.syncPendingPedidos();
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
              children: [
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
