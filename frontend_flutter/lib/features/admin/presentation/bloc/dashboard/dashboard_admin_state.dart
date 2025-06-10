import 'package:equatable/equatable.dart';
import 'package:infotel_flutter/features/admin/data/models/dashboard_admin_dto.dart';

abstract class DashboardAdminState extends Equatable {
  const DashboardAdminState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardAdminState {}

class DashboardLoading extends DashboardAdminState {}

class DashboardLoaded extends DashboardAdminState {
  final DashboardAdminDto dashboardData;

  const DashboardLoaded(this.dashboardData);

  @override
  List<Object?> get props => [dashboardData];
}

class DashboardError extends DashboardAdminState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
