import 'package:infotel_flutter/features/auth/data/models/login_dto.dart';
import 'package:infotel_flutter/features/auth/data/models/login_response.dart';
import 'package:infotel_flutter/features/auth/data/models/register_dto.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  Future<LoginResponse> register(RegisterDto registerDto);
}