class ProductoDto {
  final String? nombre;
  final String? descripcion;
  final String? tallas;
  final String? material;
  final double? precio;
  final int? stock;
  final String? nombreCategoria;
  final List<String>? nombresColores;

  ProductoDto({
    this.nombre,
    this.descripcion,
    this.tallas,
    this.material,
    this.precio,
    this.stock,
    this.nombreCategoria,
    this.nombresColores,
  });

  factory ProductoDto.fromJson(Map<String, dynamic> json) {
    return ProductoDto(
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      tallas: json['tallas'],
      material: json['material'],
      precio: json['precio']?.toDouble(),
      stock: json['stock'],
      nombreCategoria: json['nombreCategoria'],
      nombresColores: json['nombresColores'] != null
          ? List<String>.from(json['nombresColores'])
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'tallas': tallas,
      'material': material,
      'precio': precio,
      'stock': stock,
      'nombreCategoria': nombreCategoria,
      'nombresColores': nombresColores,
    };
  }
}