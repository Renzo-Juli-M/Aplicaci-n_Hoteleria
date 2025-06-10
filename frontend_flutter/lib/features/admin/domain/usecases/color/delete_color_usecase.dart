import 'package:infotel_flutter/features/admin/domain/repositories/color_repository.dart';

class DeleteColorUsecase {
  final ColorRepository repository;

  DeleteColorUsecase(this.repository);

  Future<void> call(int idColor) {
    return repository.deleteColor(idColor);
  }
}