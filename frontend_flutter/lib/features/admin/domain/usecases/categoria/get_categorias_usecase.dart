import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/categoria_repository.dart';

class GetCategoriasUseCase {
  final CategoriaRepository repository;

  GetCategoriasUseCase(this.repository);

  Future<List<CategoriaResponse>> call() {
    return repository.getCategorias();
  }
}