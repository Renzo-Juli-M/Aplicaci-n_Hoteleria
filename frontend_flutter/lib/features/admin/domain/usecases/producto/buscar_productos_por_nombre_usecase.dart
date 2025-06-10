import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/producto_repository.dart';

class BuscarProductosPorNombreUsecase {
  final ProductoRepository repository;

  BuscarProductosPorNombreUsecase(this.repository);

  Future<List<ProductoResponse>> call(String nombre) {
    return repository.buscarProductosPorNombre(nombre);
  }
}
