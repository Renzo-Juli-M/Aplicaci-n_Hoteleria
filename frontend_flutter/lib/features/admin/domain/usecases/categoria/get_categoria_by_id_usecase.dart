import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/categoria_repository.dart';

class GetCategoriaByIdUseCase {
  final CategoriaRepository repository;

  GetCategoriaByIdUseCase(this.repository);

  Future<CategoriaResponse> call(int id) {
    return repository.getCategoriaById(id);
  }
}