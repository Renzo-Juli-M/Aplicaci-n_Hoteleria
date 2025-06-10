class DashboardAdminDto {
  final int totalCategorias;
  final int totalProductos;
  final int totalColores;
  final int totalUsuarios;
  final Map<String, int> productosPorCategoria;
  final Map<String, int> usuariosPorRol;

  DashboardAdminDto({
    required this.totalCategorias,
    required this.totalProductos,
    required this.totalColores,
    required this.totalUsuarios,
    required this.productosPorCategoria,
    required this.usuariosPorRol,
  });

  factory DashboardAdminDto.fromJson(Map<String, dynamic> json) {
    return DashboardAdminDto(
      totalCategorias: json['totalCategorias'] ?? 0,
      totalProductos: json['totalProductos'] ?? 0,
      totalColores: json['totalColores'] ?? 0,
      totalUsuarios: json['totalUsuarios'] ?? 0,
      productosPorCategoria: Map<String, int>.from(
        (json['productosPorCategoria'] ?? {}).map(
              (key, value) => MapEntry(key, value as int),
        ),
      ),
      usuariosPorRol: Map<String, int>.from(
        (json['usuariosPorRol'] ?? {}).map(
              (key, value) => MapEntry(key, value as int),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCategorias': totalCategorias,
      'totalProductos': totalProductos,
      'totalColores': totalColores,
      'totalUsuarios': totalUsuarios,
      'productosPorCategoria': productosPorCategoria,
      'usuariosPorRol': usuariosPorRol,
    };
  }
}