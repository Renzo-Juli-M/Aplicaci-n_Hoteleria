import 'package:infotel_flutter/features/admin/data/models/color_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/color_response.dart';

abstract class ColorRepository {
  Future<List<ColorResponse>> getColores();
  Future<ColorResponse> getColorById(int idColor);
  Future<ColorResponse> postColor(ColorDto colorDto);
  Future<ColorResponse> putColor(int idColor, ColorDto colorDto);
  Future<void> deleteColor(int idColor);
  Future<List<ColorResponse>> buscarColoresPorNombre(String nombre);
}