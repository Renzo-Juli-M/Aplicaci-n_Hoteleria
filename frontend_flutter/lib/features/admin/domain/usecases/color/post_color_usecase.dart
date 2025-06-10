import 'package:infotel_flutter/features/admin/data/models/color_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/color_repository.dart';

class PostColorUsecase {
  final ColorRepository repository;

  PostColorUsecase(this.repository);

  Future<ColorResponse> call(ColorDto dto) {
    return repository.postColor(dto);
  }
}
