import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:infotel_flutter/features/admin/presentation/screens/admin_screen.dart';
import 'package:infotel_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:infotel_flutter/features/auth/presentation/screens/register_screen.dart';
import 'package:infotel_flutter/features/general/presentation/screens/bienvenida1.dart';
import 'package:infotel_flutter/features/general/presentation/screens/bienvenida2.dart';
import 'package:infotel_flutter/features/general/presentation/screens/home_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Bienvenida1(), // solo carga el Home vacío
    ),
    GoRoute(
      path: '/bienvenida1',
      builder: (context, state) => const Bienvenida2(), // solo carga el Home vacío
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(), // solo carga el Home vacío
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(), // solo carga el Home vacío
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(), // solo carga el Home vacío
    ),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminScreen(), // solo carga el Home vacío
    ),
  ],
);