class Pedido {
  final int id;
  final String nombre;
  final String cantidad;
  final String direccion;
  final String descripcion;
  final double precio;
  final bool pendingSync;

  const Pedido({
    required this.id,
    required this.nombre,
    required this.cantidad,
    required this.direccion,
    required this.descripcion,
    required this.precio,
    required this.pendingSync,
  });

  Pedido copyWith({
    int? id,
    String? nombre,
    String? cantidad,
    String? direccion,
    String? descripcion,
    double? precio,
    bool? pendingSync,
  }) {
    return Pedido(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      direccion: direccion ?? this.direccion,
      descripcion: descripcion ?? this.descripcion,
      precio: precio ?? this.precio,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'nombre': nombre,
      'cantidad': cantidad,
      'direccion': direccion,
      'descripcion': descripcion,
      'precio': precio,
      'pendingSync': pendingSync,
    };
  }

  Map<String, Object?> toSqlite() {
    return {
      'id': id,
      'nombre': nombre,
      'cantidad': cantidad,
      'direccion': direccion,
      'descripcion': descripcion,
      'precio': precio,
      'pending_sync': pendingSync ? 1 : 0,
      'updated_at_ms': DateTime.now().millisecondsSinceEpoch,
    };
  }

  factory Pedido.fromSqlite(Map<String, Object?> data) {
    return Pedido(
      id: data['id'] as int,
      nombre: (data['nombre'] as String?) ?? '',
      cantidad: (data['cantidad'] as String?) ?? '',
      direccion: (data['direccion'] as String?) ?? '',
      descripcion: (data['descripcion'] as String?) ?? '',
      precio: ((data['precio'] as num?) ?? 0).toDouble(),
      pendingSync: ((data['pending_sync'] as int?) ?? 0) == 1,
    );
  }

  factory Pedido.fromFirestore(
    Map<String, dynamic> data, {
    required String fallbackId,
    bool? pendingSyncOverride,
  }) {
    final rawId = data['id'];
    final resolvedId = rawId is int
        ? rawId
        : int.tryParse(rawId?.toString() ?? '') ??
              int.tryParse(fallbackId) ??
              DateTime.now().millisecondsSinceEpoch;

    return Pedido(
      id: resolvedId,
      nombre: data['nombre'] ?? '',
      cantidad: data['cantidad'] ?? '',
      direccion: data['direccion'] ?? '',
      descripcion: data['descripcion'] ?? '',
      precio: (data['precio'] as num?)?.toDouble() ?? 0.0,
      pendingSync: pendingSyncOverride ?? (data['pendingSync'] ?? false),
    );
  }
}
