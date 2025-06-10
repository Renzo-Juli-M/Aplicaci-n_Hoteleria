import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/producto_repository.dart';

class GetProductoByIdUsecase {
  final ProductoRepository repository;

  GetProductoByIdUsecase(this.repository);

  Future<ProductoResponse> call(int id) {
    return repository.getProductoById(id);
  }
}