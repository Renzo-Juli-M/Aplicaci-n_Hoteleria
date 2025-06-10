import 'dart:io';
import 'package:infotel_flutter/features/admin/data/models/producto_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';

abstract class ProductoRepository {
  Future<List<ProductoResponse>> getProductos();
  Future<ProductoResponse> getProductoById(int id);
  Future<ProductoResponse> postProducto(ProductoDto producto, File? imagen);
  Future<ProductoResponse> putProducto(int id, ProductoDto producto, File? imagen);
  Future<void> deleteProducto(int id);
  Future<List<ProductoResponse>> buscarProductosPorNombre(String nombre);
}