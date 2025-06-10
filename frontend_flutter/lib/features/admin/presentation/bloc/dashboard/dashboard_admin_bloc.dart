import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/dashboard/get_dashboard_admin_usecase.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/dashboard/dashboard_admin_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/dashboard/dashboard_admin_state.dart';

class DashboardAdminBloc extends Bloc<DashboardAdminEvent, DashboardAdminState> {
  final GetDashboardAdminUseCase getDashboardAdminUseCase;

  DashboardAdminBloc({required this.getDashboardAdminUseCase}) : super(DashboardInitial()) {
    on<LoadDashboardEvent>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(
      LoadDashboardEvent event,
      Emitter<DashboardAdminState> emit,
      ) async {
    emit(DashboardLoading());

    try {
      final dashboard = await getDashboardAdminUseCase();
      emit(DashboardLoaded(dashboard));
    } catch (e) {
      emit(DashboardError('Error al cargar el dashboard: ${e.toString()}'));
    }
  }
}