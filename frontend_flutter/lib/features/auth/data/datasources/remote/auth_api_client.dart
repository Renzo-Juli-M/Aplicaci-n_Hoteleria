import 'package:dio/dio.dart';
import 'package:infotel_flutter/features/auth/data/models/login_dto.dart';
import 'package:infotel_flutter/features/auth/data/models/login_response.dart';
import 'package:infotel_flutter/features/auth/data/models/register_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_client.g.dart';

@RestApi()
abstract class AuthApiClient {
  factory AuthApiClient(Dio dio, {String baseUrl}) = _AuthApiClient;

  @POST("/auth/login")
  Future<LoginResponse> login(@Body() LoginDto loginDto);

  @POST("/auth/register")
  Future<LoginResponse> register(@Body() RegisterDto registerDto);
}