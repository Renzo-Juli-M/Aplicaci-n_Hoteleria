import 'dart:io';
import 'package:infotel_flutter/features/admin/data/models/producto_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/producto_repository.dart';

class PutProductoUsecase {
  final ProductoRepository repository;

  PutProductoUsecase(this.repository);

  Future<ProductoResponse> call(int id, ProductoDto producto, File? imagen) {
    return repository.putProducto(id, producto, imagen);
  }
}
