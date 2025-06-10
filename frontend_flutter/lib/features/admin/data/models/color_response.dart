import 'package:infotel_flutter/features/admin/data/models/producto_color_response.dart';

class ColorResponse {
  final int? idColor;
  final String? nombre;
  final List<ProductoColorResponse>? productoColores;
  final String? fechaCreacionColor;
  final String? fechaModificacionColor;

  ColorResponse({
    this.idColor,
    this.nombre,
    this.productoColores,
    this.fechaCreacionColor,
    this.fechaModificacionColor,
  });

  factory ColorResponse.fromJson(Map<String, dynamic> json) {
    return ColorResponse(
      idColor: json['idColor'],
      nombre: json['nombre'],
      productoColores: json['productoColores'] != null
          ? List<ProductoColorResponse>.from(
          json['productoColores'].map((x) => ProductoColorResponse.fromJson(x)))
          : [],
      fechaCreacionColor: json['fechaCreacionColor'],
      fechaModificacionColor: json['fechaModificacionColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idColor': idColor,
      'nombre': nombre,
      'productoColores': productoColores?.map((x) => x.toJson()).toList(),
      'fechaCreacionColor': fechaCreacionColor,
      'fechaModificacionColor': fechaModificacionColor,
    };
  }
}