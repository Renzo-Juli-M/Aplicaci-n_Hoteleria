import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SuperAdminHomeScreen extends StatefulWidget {
  @override
  _SuperAdminHomeScreenState createState() => _SuperAdminHomeScreenState();
}

class _SuperAdminHomeScreenState extends State<SuperAdminHomeScreen> {
  String name = "Maria";
  String email = "maria@gmail.com";
  String profilePictureUrl = "https://via.placeholder.com/150";

  int activeUsers = 0;
  int totalReservations = 0;
  double totalIncome = 0.0;

  List<dynamic> users = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<void> fetchStats() async {
    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse('http://192.168.43.81:8080/api/stats'), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          activeUsers = data['activeUsers'] ?? 0;
          totalReservations = data['totalReservations'] ?? 0;
          totalIncome = double.tryParse(data['totalIncome'].toString()) ?? 0.0;
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = 'Error al cargar estadísticas';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error al cargar estadísticas';
      });
    }
  }

  Future<void> fetchUsers() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final headers = await _getHeaders();
      final response = await http.get(Uri.parse('http://192.168.43.81:8080/api/users'), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          users = jsonDecode(response.body);
          errorMessage = '';
        });
      } else if (response.statusCode == 401) {
        setState(() {
          errorMessage = 'No autorizado. Por favor, inicia sesión de nuevo.';
        });
        // Opcional: navegar a login automáticamente
      } else {
        setState(() {
          errorMessage = 'No se pudieron cargar los usuarios';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error de conexión';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteUser(String userId) async {
    final url = Uri.parse('http://192.168.43.81:8080/api/users/$userId');
    final headers = await _getHeaders();

    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 204) {
      fetchUsers();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuario eliminado")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al eliminar usuario")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStats();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("SuperAdmin"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await fetchStats();
              await fetchUsers();
            },
            tooltip: 'Actualizar',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            tooltip: 'Cerrar sesión',
          ),
          IconButton(
            icon: const Icon(Icons.people),
            tooltip: 'Gestionar Usuarios',
            onPressed: () {
              Navigator.pushNamed(context, '/superadmin/users');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [Colors.blueAccent, Colors.lightBlue]),
              ),
              child: Center(
                child: Text(
                  'Menú SuperAdmin',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.hotel, color: Colors.blueAccent),
              title: const Text('Hospedajes'),
              onTap: () {
                Navigator.pushNamed(context, '/superadmin/hotels');
              },
            ),
            ListTile(
              leading: const Icon(Icons.restaurant, color: Colors.orangeAccent),
              title: const Text('Restaurantes'),
              onTap: () {
                Navigator.pushNamed(context, '/superadmin/restaurants');
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_note, color: Colors.green),
              title: const Text('Reservas'),
              onTap: () {
                Navigator.pushNamed(context, '/superadmin/reservations/manage');
              },
            ),
            ListTile(
              leading: const Icon(Icons.insert_chart, color: Colors.purple),
              title: const Text('Reportes'),
              onTap: () {
                Navigator.pushNamed(context, '/superadmin/reports');
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.redAccent),
              title: const Text('Notificaciones'),
              onTap: () {
                Navigator.pushNamed(context, '/superadmin/notifications');
              },
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchStats();
          await fetchUsers();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade50, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                shadowColor: Colors.blueAccent.withOpacity(0.4),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 42,
                          backgroundImage: NetworkImage(profilePictureUrl),
                          backgroundColor: Colors.grey[200],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent.shade700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              email,
                              style: theme.textTheme.titleMedium?.copyWith(color: Colors.grey[700]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                "Estadísticas",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  _buildStatCard("Usuarios Activos", activeUsers.toString(), Icons.people, Colors.blueAccent),
                  _buildStatCard("Ingresos Totales", "\$${totalIncome.toStringAsFixed(2)}", Icons.attach_money, Colors.green),
                  _buildStatCard("Total de Reservas", totalReservations.toString(), Icons.event_note, Colors.orangeAccent),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                "Usuarios",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.blueGrey[900]),
              ),
              const SizedBox(height: 16),
              if (errorMessage.isNotEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(errorMessage, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                  ),
                )
              else if (isLoading)
                const Center(child: CircularProgressIndicator(color: Colors.blueAccent))
              else if (users.isEmpty)
                  Center(child: Text("No hay usuarios registrados", style: TextStyle(fontSize: 16, color: Colors.grey[600])))
                else
                  Container(
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return Dismissible(
                          key: Key(user['id'].toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.redAccent,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.delete, color: Colors.white, size: 32),
                          ),
                          onDismissed: (direction) {
                            deleteUser(user['id'].toString());
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent.shade100,
                              child: Text(
                                user['username'][0].toUpperCase(),
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text(
                              user['username'],
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(user['email']),
                            trailing: Chip(
                              backgroundColor: Colors.blueAccent.shade100,
                              label: Text(
                                user['role'].toString().replaceAll('ROLE_', ''),
                                style: const TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/superadmin/adduser');
        },
        icon: const Icon(Icons.person_add),
        label: const Text("Agregar usuario"),
        backgroundColor: Colors.blueAccent,
        elevation: 6,
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color iconColor) {
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: iconColor.withOpacity(0.2),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
