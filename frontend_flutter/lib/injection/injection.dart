import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:infotel_flutter/config/constants/constants.dart';
import 'package:infotel_flutter/core/network/auth_interceptor.dart';
import 'package:infotel_flutter/core/services/token_storage_service.dart';
import 'package:infotel_flutter/features/admin/admin_injection.dart';
import 'package:infotel_flutter/features/auth/auth_injection.dart';
import 'package:infotel_flutter/features/general/general_injection.dart';

final getIt = GetIt.instance;

void setupLocator() {

  getIt.registerLazySingleton<TokenStorageService>(() => TokenStorageService());
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton<Dio>(() {
      final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrlDev));
      dio.interceptors.add(AuthInterceptor());
      return dio;
    });
  }

  // Dio sin interceptor para login y registro
  if (!getIt.isRegistered<Dio>(instanceName: "noAuth")) {
    getIt.registerLazySingleton<Dio>(
          () => Dio(BaseOptions(baseUrl: ApiConstants.baseUrlDev)),
      instanceName: "noAuth",
    );
  }

  injectAuthDependencies();
  injectGeneralDependencies();
  injectAdminDependencies();
}