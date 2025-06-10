import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';

class ProductoColorResponse {
  final int? id;
  final ProductoResponse? producto;
  final ColorResponse? color;
  final String? fechaCreacionProductoColor;
  final String? fechaModificacionProductoColor;

  ProductoColorResponse({
    this.id,
    this.producto,
    this.color,
    this.fechaCreacionProductoColor,
    this.fechaModificacionProductoColor,
  });

  factory ProductoColorResponse.fromJson(Map<String, dynamic> json) {
    return ProductoColorResponse(
      id: json['id'],
      producto: json['producto'] != null
          ? ProductoResponse.fromJson(json['producto'])
          : null,
      color: json['color'] != null
          ? ColorResponse.fromJson(json['color'])
          : null,
      fechaCreacionProductoColor: json['fechaCreacionProductoColor'],
      fechaModificacionProductoColor: json['fechaModificacionProductoColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'producto': producto?.toJson(),
      'color': color?.toJson(),
      'fechaCreacionProductoColor': fechaCreacionProductoColor,
      'fechaModificacionProductoColor': fechaModificacionProductoColor,
    };
  }
}
