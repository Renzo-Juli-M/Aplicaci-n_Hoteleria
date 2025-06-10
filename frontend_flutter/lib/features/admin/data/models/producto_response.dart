import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_color_response.dart';

class ProductoResponse {
  final int? idProducto;
  final String? nombre;
  final String? descripcion;
  final String? tallas;
  final String? material;
  final double? precio;
  final int? stock;
  final String? imagenUrl;
  final CategoriaResponse? categoria;
  final List<ProductoColorResponse>? productoColores;
  final String? fechaCreacionProducto;
  final String? fechaModificacionProducto;

  ProductoResponse({
    this.idProducto,
    this.nombre,
    this.descripcion,
    this.tallas,
    this.material,
    this.precio,
    this.stock,
    this.imagenUrl,
    this.categoria,
    this.productoColores,
    this.fechaCreacionProducto,
    this.fechaModificacionProducto,
  });

  factory ProductoResponse.fromJson(Map<String, dynamic> json) {
    return ProductoResponse(
      idProducto: json['idProducto'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      tallas: json['tallas'],
      material: json['material'],
      precio: (json['precio'] != null) ? json['precio'].toDouble() : null,
      stock: json['stock'],
      imagenUrl: json['imagenUrl'],
      categoria: json['categoria'] != null
          ? CategoriaResponse.fromJson(json['categoria'])
          : null,
      productoColores: json['productoColores'] != null
          ? List<ProductoColorResponse>.from(
          json['productoColores'].map((x) => ProductoColorResponse.fromJson(x)))
          : [],
      fechaCreacionProducto: json['fechaCreacionProducto'],
      fechaModificacionProducto: json['fechaModificacionProducto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idProducto': idProducto,
      'nombre': nombre,
      'descripcion': descripcion,
      'tallas': tallas,
      'material': material,
      'precio': precio,
      'stock': stock,
      'imagenUrl': imagenUrl,
      'categoria': categoria?.toJson(),
      'productoColores': productoColores?.map((x) => x.toJson()).toList(),
      'fechaCreacionProducto': fechaCreacionProducto,
      'fechaModificacionProducto': fechaModificacionProducto,
    };
  }
}