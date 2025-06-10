import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infotel_flutter/core/services/token_storage_service.dart';
import 'package:infotel_flutter/features/admin/data/models/usuario_completo_response.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_state.dart';
import 'package:infotel_flutter/features/admin/presentation/screens/admin_dashboard_screen.dart';
import 'package:infotel_flutter/features/admin/presentation/screens/cruds/categoria_screen.dart';
import 'package:infotel_flutter/features/admin/presentation/screens/cruds/color_screen.dart';
import 'package:infotel_flutter/features/admin/presentation/screens/cruds/producto_screen.dart';
import 'package:infotel_flutter/features/admin/presentation/screens/cruds/rol_screen.dart';
import 'package:infotel_flutter/features/admin/presentation/screens/cruds/usuario_screen.dart';
import 'package:infotel_flutter/features/admin/presentation/widgets/foto_widget.dart';

class AdminScreen extends StatefulWidget {
  final Widget? child;
  const AdminScreen({super.key, this.child});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final tab = GoRouterState.of(context).uri.queryParameters['tab'];

    switch (tab) {
      case 'dashboard':
        _setTabIndex(0);
        break;
      case 'roles':
        _setTabIndex(1);
        break;
      case 'usuarios':
        _setTabIndex(2);
        break;
      case 'categorias':
        _setTabIndex(3);
        break;
      case 'productos':
        _setTabIndex(4);
        break;
      case 'colores':
        _setTabIndex(5);
        break;
      default:
        _setTabIndex(0); // Dashboard por defecto
    }
  }

  void _setTabIndex(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
        _bottomNavIndex = 0;
      });
    }
  }

  // Índice para controlar la pantalla actual
  int _selectedIndex = 0;

  void _navigateToIndex(int index) {
    setState(() {
      _bottomNavIndex = index;
      if (index == 0) {
        _selectedIndex = 0;
        context.go('/admin');
      } else if (index == 1) {
        _selectedIndex = 9;
        context.go('/admin/noticias');
      } else if (index == 2) {
        _selectedIndex = 10;
        context.go('/admin/perfil');
      }
    });
  }

  int _bottomNavIndex = 0;
  // Lista de pantallas que pueden mostrarse
  final List<Widget> _screens = [
    const AdminDashboardScreen(),
    const RolScreen(),
    const UsuarioScreen(),
    const CategoriaScreen(),
    const ProductoScreen(),
    const ColorScreen(),
  ];

  final List<IconData> _icons = [
    Icons.dashboard,          // Panel de Administración
    Icons.admin_panel_settings, // Roles
    Icons.person,             // Usuarios
    Icons.category,
    Icons.shopping_bag,
    Icons.color_lens,
  ];

  // Lista de títulos correspondientes a cada pantalla
  final List<String> _titles = [
    'Administración',
    'Roles',
    'Usuarios',
    'Categorias',
    'Productos',
    'Colores',
  ];

  // Guardar el usuario en una variable para la pantalla
  UsuarioCompletoResponse? _usuario;

  @override
  void initState() {
    super.initState();
    print("Bloc encontrado: ${context.read<UsuarioBloc>()}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UsuarioBloc>().add(GetMyUsuarioEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsuarioBloc, UsuarioState>(
      listener: (context, state) {
        if (state is UsuarioProfileLoaded) {
          setState(() {
            _usuario = state.usuario;  // Actualizamos el estado del usuario
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                Icon(_icons[_selectedIndex], color: Colors.white),
                SizedBox(width: 8),
                Expanded( // Esto limita el ancho del texto al espacio disponible
                  child: Text(
                    _titles[_selectedIndex],
                    style: TextStyle(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.blueGrey[800],
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Acción de notificaciones
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Acción de configuración
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  final tokenService = TokenStorageService();
                  await tokenService.clearToken();
                  setState(() {
                    _usuario = null;
                  });
                  context.go("/login");
                },
              ),
            ]
        ),
        drawer: _buildDrawer(),
        body: Builder(
          builder: (context) {
            final uri = GoRouterState.of(context).uri;
            final isAdminBase = uri.path == '/admin';
            final tabParam = uri.queryParameters['tab'];

            if (isAdminBase) {
              return _screens[_selectedIndex];
            } else if (uri.path == '/admin/noticias') {
            } else if (uri.path == '/admin/perfil') {
            }

            return widget.child ?? const SizedBox();
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomNavIndex,
          onTap: _navigateToIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Noticias'),
            BottomNavigationBarItem(icon: Icon(Icons.person_pin), label: 'Perfil'),
          ],
        ),
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      backgroundColor: Colors.grey[100],
      child: Column(
        children: [
          // Header con info de usuario
          _usuario == null
              ? const DrawerHeader(
            child: Center(child: CircularProgressIndicator()),
          )
              : DrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey[800]),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _usuario!.persona?.fotoPerfil != null
                      ? FotoWidget(
                    fileName: _usuario!.persona!.fotoPerfil!,
                    size: 60,
                  )
                      : const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,
                        size: 36, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _usuario!.persona?.nombres ?? "Sin nombre",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _usuario!.persona?.correoElectronico ?? "Sin correo",
                    style: const TextStyle(color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Menú de opciones
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              setState(() {
                _selectedIndex = 0;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings),
            title: const Text('Roles'),
            onTap: () {
              setState(() {
                _selectedIndex = 1;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=roles');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Usuarios'),
            onTap: () {
              setState(() {
                _selectedIndex = 2;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=usuarios');
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorias'),
            onTap: () {
              setState(() {
                _selectedIndex = 3;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=categorias');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Productos'),
            onTap: () {
              setState(() {
                _selectedIndex = 4;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=productos');
            },
          ),
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text('Colores'),
            onTap: () {
              setState(() {
                _selectedIndex = 5;
                _bottomNavIndex = 0;
              });
              Navigator.of(context).pop();
              context.go('/admin?tab=colores');
            },
          ),

          const Spacer(), // <- Este empuja el siguiente widget al final

          // Cerrar sesión
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar sesión'),
            onTap: () async {
              final tokenService = TokenStorageService();
              await tokenService.clearToken();
              context.go("/login");
            },
          ),
        ],
      ),
    );
  }

}