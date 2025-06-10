import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';

class CategoriaResponse {
  final int? idCategoria;
  final String? nombre;
  final String? descripcion;
  final String? iconoUrl;
  final List<ProductoResponse>? productos;
  final String? fechaCreacionCategoria;
  final String? fechaModificacionCategoria;

  CategoriaResponse({
    this.idCategoria,
    this.nombre,
    this.descripcion,
    this.iconoUrl,
    this.productos,
    this.fechaCreacionCategoria,
    this.fechaModificacionCategoria,
  });

  factory CategoriaResponse.fromJson(Map<String, dynamic> json) {
    return CategoriaResponse(
      idCategoria: json['idCategoria'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      iconoUrl: json['iconoUrl'],
      productos: json['productos'] != null
          ? List<ProductoResponse>.from(
          json['productos'].map((x) => ProductoResponse.fromJson(x)))
          : [],
      fechaCreacionCategoria: json['fechaCreacionCategoria'],
      fechaModificacionCategoria: json['fechaModificacionCategoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idCategoria': idCategoria,
      'nombre': nombre,
      'descripcion': descripcion,
      'iconoUrl': iconoUrl,
      'productos': productos?.map((x) => x.toJson()).toList(),
      'fechaCreacionCategoria': fechaCreacionCategoria,
      'fechaModificacionCategoria': fechaModificacionCategoria,
    };
  }
}