import 'package:infotel_flutter/features/admin/domain/repositories/categoria_repository.dart';

class DeleteCategoriaUseCase {
  final CategoriaRepository repository;

  DeleteCategoriaUseCase(this.repository);

  Future<void> call(int id) {
    return repository.deleteCategoria(id);
  }
}