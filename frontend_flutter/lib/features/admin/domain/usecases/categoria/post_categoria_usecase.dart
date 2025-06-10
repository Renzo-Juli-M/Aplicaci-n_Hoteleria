import 'dart:io';

import 'package:infotel_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/categoria_repository.dart';

class PostCategoriaUseCase {
  final CategoriaRepository repository;

  PostCategoriaUseCase(this.repository);

  Future<CategoriaResponse> call(CategoriaDto dto, File? file) {
    return repository.postCategoria(dto, file);
  }
}