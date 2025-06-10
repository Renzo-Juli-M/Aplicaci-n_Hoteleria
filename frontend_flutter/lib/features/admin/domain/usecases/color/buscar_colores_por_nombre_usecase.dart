import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/color_repository.dart';

class BuscarColoresPorNombreUsecase {
  final ColorRepository repository;

  BuscarColoresPorNombreUsecase(this.repository);

  Future<List<ColorResponse>> call(String nombre) {
    return repository.buscarColoresPorNombre(nombre);
  }
}