import 'package:infotel_flutter/features/admin/data/datasources/remote/color_api_client.dart';
import 'package:infotel_flutter/features/admin/data/models/color_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/color_repository.dart';

class ColorRepositoryImpl implements ColorRepository {
  final ColorApiClient apiClient;

  ColorRepositoryImpl(this.apiClient);

  @override
  Future<List<ColorResponse>> getColores() {
    return apiClient.getColores();
  }

  @override
  Future<ColorResponse> getColorById(int idColor) {
    return apiClient.getColorById(idColor);
  }

  @override
  Future<ColorResponse> postColor(ColorDto colorDto) {
    return apiClient.postColor(colorDto);
  }

  @override
  Future<ColorResponse> putColor(int idColor, ColorDto colorDto) {
    return apiClient.putColor(idColor, colorDto);
  }

  @override
  Future<void> deleteColor(int idColor) {
    return apiClient.deleteColor(idColor);
  }

  @override
  Future<List<ColorResponse>> buscarColoresPorNombre(String nombre) {
    return apiClient.buscarColoresPorNombre(nombre);
  }
}