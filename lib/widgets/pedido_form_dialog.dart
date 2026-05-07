import 'package:flutter/material.dart';

class PedidoFormResult {
  final String nombre;
  final String cantidad;
  final String direccion;
  final String descripcion;
  final double precio;

  const PedidoFormResult({
    required this.nombre,
    required this.cantidad,
    required this.direccion,
    required this.descripcion,
    required this.precio,
  });
}

class PedidoFormDialog extends StatefulWidget {
  final PedidoFormResult? initialValue;

  const PedidoFormDialog({super.key, this.initialValue});

  @override
  State<PedidoFormDialog> createState() => _PedidoFormDialogState();
}

class _PedidoFormDialogState extends State<PedidoFormDialog> {
  late final TextEditingController _nombreController;
  late final TextEditingController _cantidadController;
  late final TextEditingController _direccionController;
  late final TextEditingController _descripcionController;
  late final TextEditingController _precioController;

  String? _nombreError;
  String? _direccionError;
  String? _precioError;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(
      text: widget.initialValue?.nombre ?? '',
    );
    _cantidadController = TextEditingController(
      text: widget.initialValue?.cantidad ?? '',
    );
    _direccionController = TextEditingController(
      text: widget.initialValue?.direccion ?? '',
    );
    _descripcionController = TextEditingController(
      text: widget.initialValue?.descripcion ?? '',
    );
    _precioController = TextEditingController(
      text: widget.initialValue?.precio.toStringAsFixed(0) ?? '',
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _cantidadController.dispose();
    _direccionController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  void _save() {
    final nombre = _nombreController.text.trim();
    final cantidad = _cantidadController.text.trim();
    final direccion = _direccionController.text.trim();
    final descripcion = _descripcionController.text.trim();
    final precio = double.tryParse(
      _precioController.text.trim().replaceAll(',', '.'),
    );

    setState(() {
      _nombreError = nombre.isEmpty ? 'Ingresa el nombre del pedido.' : null;
      _direccionError = direccion.isEmpty
          ? 'Ingresa la dirección de entrega.'
          : null;
      _precioError = precio == null || precio <= 0
          ? 'Ingresa un precio válido.'
          : null;
    });

    if (_nombreError != null ||
        _direccionError != null ||
        _precioError != null) {
      return;
    }

    Navigator.of(context).pop(
      PedidoFormResult(
        nombre: nombre,
        cantidad: cantidad.isEmpty ? cantidad : cantidad,
        direccion: direccion,
        descripcion: descripcion,
        precio: precio!,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialValue != null;

    return AlertDialog(
      title: Text(isEditing ? 'Editar pedido' : 'Nuevo pedido'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre del pedido',
                errorText: _nombreError,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _cantidadController,
              decoration: const InputDecoration(
                labelText: 'Cantidad',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _direccionController,
              decoration: InputDecoration(
                labelText: 'Dirección',
                errorText: _direccionError,
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _precioController,
              decoration: InputDecoration(
                labelText: 'Precio',
                prefixText: '\$ ',
                errorText: _precioError,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _save,
          child: Text(isEditing ? 'Actualizar' : 'Guardar'),
        ),
      ],
    );
  }
}
