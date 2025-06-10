import 'dart:io';
import 'package:infotel_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';

abstract class CategoriaRepository {
  Future<List<CategoriaResponse>> getCategorias();
  Future<CategoriaResponse> getCategoriaById(int id);
  Future<CategoriaResponse> postCategoria(CategoriaDto categoria, File? imagen);
  Future<CategoriaResponse> putCategoria(int id, CategoriaDto categoria, File? imagen);
  Future<void> deleteCategoria(int id);
  Future<List<CategoriaResponse>> buscarCategoriasPorNombre(String nombre);
}