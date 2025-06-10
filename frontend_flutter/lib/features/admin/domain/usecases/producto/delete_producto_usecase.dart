import 'package:infotel_flutter/features/admin/domain/repositories/producto_repository.dart';

class DeleteProductoUsecase {
  final ProductoRepository repository;

  DeleteProductoUsecase(this.repository);

  Future<void> call(int id) {
    return repository.deleteProducto(id);
  }
}
