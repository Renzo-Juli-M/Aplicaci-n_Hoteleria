import 'package:dio/dio.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'producto_api_client.g.dart';

@RestApi()
abstract class ProductoApiClient {
  factory ProductoApiClient(Dio dio, {String baseUrl}) = _ProductoApiClient;

  @GET("/admin/producto")
  Future<List<ProductoResponse>> getProductos();

  @GET("/admin/producto/{idProducto}")
  Future<ProductoResponse> getProductoById(
      @Path("idProducto") int idProducto);

  @POST("/admin/producto")
  @MultiPart()
  Future<ProductoResponse> postProducto(
      @Part(name: "producto") String productoJson,
      @Part(name: "file") MultipartFile? file);

  @PUT("/admin/producto/{idProducto}")
  @MultiPart()
  Future<ProductoResponse> putProducto(
      @Path("idProducto") int idProducto,
      @Part(name: "producto") String productoJson,
      @Part(name: "file") MultipartFile? file);

  @DELETE("/admin/producto/{idProducto}")
  Future<void> deleteProducto(@Path("idProducto") int idProducto);

  @GET("/admin/producto/buscar")
  Future<List<ProductoResponse>> buscarProductosPorNombre(
      @Query("nombre") String nombre);
}