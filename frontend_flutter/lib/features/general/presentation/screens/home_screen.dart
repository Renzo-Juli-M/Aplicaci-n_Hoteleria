import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:go_router/go_router.dart';
import 'package:infotel_flutter/core/services/token_storage_service.dart';
import 'package:infotel_flutter/core/utils/auth_utils.dart';

class HomeScreen extends StatefulWidget {
  final Widget? child;
  const HomeScreen({super.key, this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _bottomNavIndex = 0;

  bool _isClickedLogin = false;
  bool _isClickedSignup = false;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkIfLoggedIn(); // <- Esto faltaba
  }

  final List<Widget> _screens = [
    const Center(child: Text("Inicio")),
    const Center(child: Text("Noticias")),
    const Center(child: Text("Perfil")),
  ];

  void _navigateToIndex(int index) {
    setState(() {
      _bottomNavIndex = index;
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/home?tab=inicio');
        break;
      case 1:
        context.go('/home/noticias');
        break;
      case 2:
        context.go('/home/perfil');
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final tab = GoRouterState.of(context).uri.queryParameters['tab'];
    switch (tab) {
      case 'inicio':
        _selectedIndex = 0;
        break;
      case 'noticias':
        _selectedIndex = 1;
        break;
      case 'perfil':
        _selectedIndex = 2;
        break;
    }
  }

  Future<void> _checkIfLoggedIn() async {
    final tokenService = TokenStorageService();
    final token = await tokenService.getToken();

    if (token != null && token.isNotEmpty) {
      final role = getRoleFromToken(token);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (role == 'ROLE_ADMIN') {
          context.go('/admin');
        } else if (role == 'ROLE_EMPRENDEDOR') {
          context.go('/emprendedor');
        }
        // ROLE_USUARIO se queda en /home
      });

      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(["Inicio", "Noticias", "Perfil"][_selectedIndex], style: TextStyle(color: Colors.white),),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF3A506B),
        actions: _isLoggedIn
            ? [
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
                _isLoggedIn = false;
                //_usuario = null;
              });
              context.go("/login");
            },
          ),
        ]
            : [
          AnimatedButton(
            text: 'LogIn',
            onPress: () {
              setState(() => _isClickedLogin = !_isClickedLogin);
              context.go('/login');
            },
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _isClickedLogin ? Colors.black : Colors.white,
            ),
            backgroundColor: _isClickedLogin ? Colors.cyan : Colors.blue,
            borderRadius: 10,
            borderWidth: 2,
            borderColor: Colors.blueGrey,
            isReverse: _isClickedLogin,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            width: 85,
            height: 30,
          ),
          const SizedBox(width: 10),
          AnimatedButton(
            text: 'SignUp',
            onPress: () {
              setState(() => _isClickedSignup = !_isClickedSignup);
              context.go('/register');
            },
            textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: _isClickedSignup ? Colors.black : Colors.white,
            ),
            backgroundColor: _isClickedSignup ? Colors.cyan : Colors.blue,
            borderRadius: 10,
            borderWidth: 2,
            borderColor: Colors.blueGrey,
            isReverse: _isClickedSignup,
            transitionType: TransitionType.LEFT_TO_RIGHT,
            width: 85,
            height: 30,
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text("Usuario"),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                _navigateToIndex(0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text('Noticias'),
              onTap: () {
                _navigateToIndex(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Perfil'),
              onTap: () {
                _navigateToIndex(2);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: widget.child ?? _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        onTap: _navigateToIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Noticias'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}