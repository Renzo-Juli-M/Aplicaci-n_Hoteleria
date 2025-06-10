import 'dart:io';

import 'package:infotel_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/categoria_repository.dart';

class PutCategoriaUseCase {
  final CategoriaRepository repository;

  PutCategoriaUseCase(this.repository);

  Future<CategoriaResponse> call(int id, CategoriaDto dto, File? file) {
    return repository.putCategoria(id, dto, file);
  }
}
