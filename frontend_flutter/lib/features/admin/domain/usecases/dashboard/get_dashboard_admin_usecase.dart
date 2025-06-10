import 'package:infotel_flutter/features/admin/data/models/dashboard_admin_dto.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/dashboard_admin_repository.dart';

class GetDashboardAdminUseCase {
  final DashboardAdminRepository repository;

  GetDashboardAdminUseCase(this.repository);

  Future<DashboardAdminDto> call() {
    return repository.getDashboard();
  }
}