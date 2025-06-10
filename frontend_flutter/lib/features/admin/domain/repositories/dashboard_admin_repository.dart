import 'package:infotel_flutter/features/admin/data/models/dashboard_admin_dto.dart';

abstract class DashboardAdminRepository {
  Future<DashboardAdminDto> getDashboard();
}