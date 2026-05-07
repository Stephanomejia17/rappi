import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rappi/models/pedido.dart';
import 'package:rappi/widgets/pedido_card.dart';

void main() {
  testWidgets('PedidoCard muestra la información principal', (
    WidgetTester tester,
  ) async {
    const pedido = Pedido(
      id: 1,
      nombre: 'Hamburguesa combo',
      cantidad: '2 unidades',
      direccion: 'Calle 10 # 20-30',
      descripcion: 'Sin cebolla y con bebida zero',
      precio: 28000,
      pendingSync: true,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PedidoCard(pedido: pedido, onTap: () {}),
        ),
      ),
    );

    expect(find.text('Hamburguesa combo'), findsOneWidget);
    expect(find.text('2 unidades'), findsOneWidget);
    expect(find.text('Calle 10 # 20-30'), findsOneWidget);
    expect(find.text('Sin cebolla y con bebida zero'), findsOneWidget);
    expect(find.text('\$28000'), findsOneWidget);
    expect(find.text('Pendiente'), findsOneWidget);
  });
}
