import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:infotel_flutter/features/admin/data/datasources/remote/producto_api_client.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/producto_repository.dart';

class ProductoRepositoryImpl implements ProductoRepository {
  final ProductoApiClient apiClient;

  ProductoRepositoryImpl(this.apiClient);

  @override
  Future<List<ProductoResponse>> getProductos() {
    return apiClient.getProductos();
  }

  @override
  Future<ProductoResponse> getProductoById(int id) {
    return apiClient.getProductoById(id);
  }

  @override
  Future<ProductoResponse> postProducto(ProductoDto producto, File? imagen) async {
    final productoJson = jsonEncode(producto.toJson());
    MultipartFile? multipartFile;

    if (imagen != null) {
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }

    return apiClient.postProducto(productoJson, multipartFile);
  }

  @override
  Future<ProductoResponse> putProducto(int id, ProductoDto producto, File? imagen) async {
    final productoJson = jsonEncode(producto.toJson());
    MultipartFile? multipartFile;

    if (imagen != null) {
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }

    return apiClient.putProducto(id, productoJson, multipartFile);
  }

  @override
  Future<void> deleteProducto(int id) {
    return apiClient.deleteProducto(id);
  }

  @override
  Future<List<ProductoResponse>> buscarProductosPorNombre(String nombre) {
    return apiClient.buscarProductosPorNombre(nombre);
  }
}