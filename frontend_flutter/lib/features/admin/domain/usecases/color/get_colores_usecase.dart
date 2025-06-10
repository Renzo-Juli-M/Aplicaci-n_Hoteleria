import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/color_repository.dart';

class GetColoresUsecase {
  final ColorRepository repository;

  GetColoresUsecase(this.repository);

  Future<List<ColorResponse>> call() {
    return repository.getColores();
  }
}