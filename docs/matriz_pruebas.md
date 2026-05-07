# Matriz de Pruebas



| ID | Módulo | Escenario probado | Resultado esperado | Estado | Evidencia/nota |
|---|---|---|---|---|---|
| MP-01 | Inicio | La app inicia y carga la pantalla principal de pedidos | Se muestra la pantalla "Rappi"| Aprobada | Ejecutado en simulador iPhone 17 Pro |
|
| MP-02 | Crear | Crear un pedido | Se muestra la pantalla para crear el pedido y se ve la pantalla inical con el pedido| Aprobada | Ejecutado en simulador iPhone 17 Pro |
|
| MP-03 | Actualizar | Actualizar | Actualizar pedido | Aprobada | Ejecutado en simulador iPhone 17 Pro |
|
| MP-04 | Eliminar | Eliminar | Eliminar pedido| Aprobada | Ejecutado en simulador iPhone 17 Pro |
|
| MP-05 | Validación | Intentar guardar un pedido sin nombre, dirección o con precio inválido | El formulario muestra mensajes de error y no permite guardar | Aprobada | Validado con mensajes "Ingresa el nombre del pedido.", "Ingresa la dirección de entrega." e "Ingresa un precio válido." |
|
| MP-06 | Estado vacío | Abrir la app sin pedidos registrados | Se muestra el mensaje de estado vacío "Todavía no hay solicitudes" | Aprobada | Ejecutado en simulador iPhone 17 Pro |
|
| MP-07 | Sincronización | Pulsar el botón de sincronizar desde la pantalla principal | Se ejecuta la sincronización y se muestra el mensaje "Sincronización ejecutada" | Aprobada | Ejecutado desde el ícono de sincronización en AppBar |
|
| MP-08 | Pendientes | Crear o editar un pedido con sincronización pendiente | El pedido se visualiza con la etiqueta "Pendiente" en la tarjeta | Aprobada | Verificado en tarjeta de pedido cuando pendingSync es verdadero |
|
