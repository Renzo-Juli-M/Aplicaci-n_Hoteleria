import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/dashboard/dashboard_admin_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/dashboard/dashboard_admin_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/dashboard/dashboard_admin_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Lanza el evento solo una vez al iniciar el widget
    context.read<DashboardAdminBloc>().add(LoadDashboardEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Admin"),
        centerTitle: true,
      ),
      body: BlocBuilder<DashboardAdminBloc, DashboardAdminState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardLoaded) {
            final dashboard = state.dashboardData;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: [
                        _buildStatCard("Categorías", "${dashboard.totalCategorias}", Icons.category),
                        _buildStatCard("Productos", "${dashboard.totalProductos}", Icons.shopping_bag),
                        _buildStatCard("Colores", "${dashboard.totalColores}", Icons.palette),
                        _buildStatCard("Usuarios", "${dashboard.totalUsuarios}", Icons.people),
                      ],
                    ).animate().fade(duration: 600.ms).moveY(),
                    const SizedBox(height: 32),
                    Text("Productos por Categoría", style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: BarChart(
                        BarChartData(
                          barGroups: _buildBarGroupsFromMap(dashboard.productosPorCategoria),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final keys = dashboard.productosPorCategoria.keys.toList();
                                  return Text(
                                    value.toInt() < keys.length ? keys[value.toInt()] : '',
                                    style: const TextStyle(fontSize: 12),
                                  );
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    ).animate().fade().scale(delay: 300.ms),
                    const SizedBox(height: 32),
                    Text("Usuarios por Rol", style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 12),
                    AspectRatio(
                      aspectRatio: 1.2,
                      child: PieChart(
                        PieChartData(
                          sections: _buildPieSectionsFromMap(dashboard.usuariosPorRol),
                        ),
                      ),
                    ).animate().fade().scale(delay: 600.ms),
                  ],
                ),
              ),
            );
          } else if (state is DashboardError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.indigo, size: 32),
          const SizedBox(height: 8),
          Text(value, style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: GoogleFonts.lato(fontSize: 14)),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroupsFromMap(Map<String, int> map) {
    int i = 0;
    return map.entries.map((entry) {
      return BarChartGroupData(
        x: i++,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: Colors.indigo,
            width: 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();
  }

  List<PieChartSectionData> _buildPieSectionsFromMap(Map<String, int> map) {
    final colors = [Colors.green, Colors.blue, Colors.orange, Colors.purple, Colors.red, Colors.cyan];
    final total = map.values.fold<int>(0, (sum, item) => sum + item);
    final entries = map.entries.toList();

    return List.generate(entries.length, (i) {
      final entry = entries[i];
      final percent = total == 0 ? 0.0 : (entry.value / total) * 100;

      return PieChartSectionData(
        value: entry.value.toDouble(),
        title: '${entry.key} (${percent.toStringAsFixed(1)}%)',
        color: colors[i % colors.length],
        radius: 100,
        titleStyle: GoogleFonts.lato(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          shadows: const [Shadow(blurRadius: 2, color: Colors.black)],
        ),
      );
    });
  }
}
