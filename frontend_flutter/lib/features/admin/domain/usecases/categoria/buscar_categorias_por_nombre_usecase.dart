import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/categoria_repository.dart';

class BuscarCategoriasPorNombreUseCase {
  final CategoriaRepository repository;

  BuscarCategoriasPorNombreUseCase(this.repository);

  Future<List<CategoriaResponse>> call(String nombre) {
    return repository.buscarCategoriasPorNombre(nombre);
  }
}