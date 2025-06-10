import 'dart:io';
import 'package:infotel_flutter/features/admin/data/models/producto_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/producto_repository.dart';

class PostProductoUsecase {
  final ProductoRepository repository;

  PostProductoUsecase(this.repository);

  Future<ProductoResponse> call(ProductoDto producto, File? imagen) {
    return repository.postProducto(producto, imagen);
  }
}
