import 'package:dio/dio.dart';
import 'package:infotel_flutter/features/admin/data/models/dashboard_admin_dto.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'dashboard_admin_api_client.g.dart';

@RestApi()
abstract class DashboardAdminApiClient {
  factory DashboardAdminApiClient(Dio dio, {String baseUrl}) = _DashboardAdminApiClient;

  @GET("/admin/dashboard")
  Future<DashboardAdminDto> getDashboard();
}