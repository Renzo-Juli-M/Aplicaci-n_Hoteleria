import 'package:dio/dio.dart';
import 'package:infotel_flutter/features/admin/data/models/color_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'color_api_client.g.dart';

@RestApi()
abstract class ColorApiClient {
  factory ColorApiClient(Dio dio, {String baseUrl}) = _ColorApiClient;

  @GET("/admin/color")
  Future<List<ColorResponse>> getColores();

  @GET("/admin/color/{idColor}")
  Future<ColorResponse> getColorById(
      @Path("idColor") int idColor);

  @POST("/admin/color")
  Future<ColorResponse> postColor(
      @Body() ColorDto colorDto,
      );

  @PUT("/admin/color/{idColor}")
  Future<ColorResponse> putColor(
      @Path("idColor") int idColor,
      @Body() ColorDto colorDto,
      );

  @DELETE("/admin/color/{idColor}")
  Future<void> deleteColor(@Path("idColor") int idColor);

  @GET("/admin/color/buscar")
  Future<List<ColorResponse>> buscarColoresPorNombre(
      @Query("nombre") String nombre,
      );
}