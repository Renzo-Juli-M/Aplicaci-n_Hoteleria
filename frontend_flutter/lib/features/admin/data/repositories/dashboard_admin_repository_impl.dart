import 'package:infotel_flutter/features/admin/data/datasources/remote/dashboard_admin_api_client.dart';
import 'package:infotel_flutter/features/admin/data/models/dashboard_admin_dto.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/dashboard_admin_repository.dart';

class DashboardAdminRepositoryImpl implements DashboardAdminRepository {
  final DashboardAdminApiClient apiClient;

  DashboardAdminRepositoryImpl(this.apiClient);

  @override
  Future<DashboardAdminDto> getDashboard() {
    return apiClient.getDashboard();
  }
}