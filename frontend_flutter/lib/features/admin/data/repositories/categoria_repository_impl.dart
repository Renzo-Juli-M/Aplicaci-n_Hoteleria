import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:infotel_flutter/features/admin/data/datasources/remote/categoria_api_client.dart';
import 'package:infotel_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/categoria_repository.dart';

class CategoriaRepositoryImpl implements CategoriaRepository {
  final CategoriaApiClient apiClient;

  CategoriaRepositoryImpl(this.apiClient);

  @override
  Future<List<CategoriaResponse>> getCategorias() {
    return apiClient.getCategorias();
  }

  @override
  Future<CategoriaResponse> getCategoriaById(int id) {
    return apiClient.getCategoriaById(id);
  }

  @override
  Future<CategoriaResponse> postCategoria(CategoriaDto categoria, File? imagen) async {
    final categoriaJson = jsonEncode(categoria.toJson());
    MultipartFile? multipartFile;

    if (imagen != null) {
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }

    return apiClient.postCategoria(categoriaJson, multipartFile);
  }

  @override
  Future<CategoriaResponse> putCategoria(int id, CategoriaDto categoria, File? imagen) async {
    final categoriaJson = jsonEncode(categoria.toJson());
    MultipartFile? multipartFile;

    if (imagen != null) {
      multipartFile = await MultipartFile.fromFile(
        imagen.path,
        filename: imagen.uri.pathSegments.last,
        contentType: MediaType("image", "jpeg"),
      );
    }

    return apiClient.putCategoria(id, categoriaJson, multipartFile);
  }

  @override
  Future<void> deleteCategoria(int id) {
    return apiClient.deleteCategoria(id);
  }

  @override
  Future<List<CategoriaResponse>> buscarCategoriasPorNombre(String nombre) {
    return apiClient.buscarCategoriasPorNombre(nombre);
  }
}