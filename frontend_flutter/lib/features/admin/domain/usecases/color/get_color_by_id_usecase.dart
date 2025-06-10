import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/color_repository.dart';

class GetColorByIdUsecase {
  final ColorRepository repository;

  GetColorByIdUsecase(this.repository);

  Future<ColorResponse> call(int idColor) {
    return repository.getColorById(idColor);
  }
}
