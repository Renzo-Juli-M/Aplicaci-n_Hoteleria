import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/producto_repository.dart';

class GetProductosUsecase {
  final ProductoRepository repository;

  GetProductosUsecase(this.repository);

  Future<List<ProductoResponse>> call() {
    return repository.getProductos();
  }
}