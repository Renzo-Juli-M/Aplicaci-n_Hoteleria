import 'package:infotel_flutter/features/admin/data/models/color_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/color_repository.dart';

class PutColorUsecase {
  final ColorRepository repository;

  PutColorUsecase(this.repository);

  Future<ColorResponse> call(int idColor, ColorDto dto) {
    return repository.putColor(idColor, dto);
  }
}
