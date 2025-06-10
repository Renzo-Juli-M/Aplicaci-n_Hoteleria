import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotel_flutter/app.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/color/color_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/producto/producto_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/producto/producto_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/rol/rol_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/rol/rol_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/dashboard/dashboard_admin_bloc.dart';
import 'package:infotel_flutter/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:infotel_flutter/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:infotel_flutter/features/general/presentation/bloc/file/file_bloc.dart';
import 'package:infotel_flutter/injection/injection.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(loginUseCase: getIt()), // Inyecta el LoginBloc
        ),
        BlocProvider(
          create: (context) => RegisterBloc(registerUseCase: getIt()),
        ),
        BlocProvider<FileBloc>(
          create: (context) => getIt<FileBloc>(),
        ),
        BlocProvider<RolBloc>(
          create: (context) => RolBloc(
            getRolesUseCase: getIt(),
            getRolByIdUseCase: getIt(),
            createRolUseCase: getIt(),
            updateRolUseCase: getIt(),
            deleteRolUseCase: getIt(),
            buscarRolesPorNombreUsecase: getIt(),
          )..add(GetRolesEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<UsuarioBloc>(
          create: (context) => UsuarioBloc(
            getAllUsuariosUseCase: getIt(),
            getUsuarioByIdUseCase: getIt(),
            createUsuarioUseCase: getIt(),
            updateUsuarioUseCase: getIt(),
            deleteUsuarioUseCase: getIt(),
            buscarUsuariosCompletosPorNombreUsecase: getIt(),
            tokenStorageService: getIt(),
          )..add(GetAllUsuariosEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<CategoriaBloc>(
          create: (context) => CategoriaBloc(
            getCategoriasUseCase: getIt(),
            getCategoriaByIdUseCase: getIt(),
            postCategoriaUseCase: getIt(),
            putCategoriaUseCase: getIt(),
            deleteCategoriaUseCase: getIt(),
            buscarCategoriasPorNombreUseCase: getIt(),
          )..add(GetAllCategoriasEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<ProductoBloc>(
          create: (context) => ProductoBloc(
            getProductosUsecase: getIt(),
            getProductoByIdUsecase: getIt(),
            postProductoUsecase: getIt(),
            putProductoUsecase: getIt(),
            deleteProductoUsecase: getIt(),
            buscarProductosPorNombreUsecase: getIt(),
          )..add(GetProductosEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<ColorBloc>(
          create: (context) => ColorBloc(
            getColoresUsecase: getIt(),
            getColorByIdUsecase: getIt(),
            postColorUsecase: getIt(),
            putColorUsecase: getIt(),
            deleteColorUsecase: getIt(),
            buscarColoresPorNombreUsecase: getIt(),
          )..add(GetColoresEvent()), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
        BlocProvider<DashboardAdminBloc>(
          create: (context) => DashboardAdminBloc(
            getDashboardAdminUseCase: getIt(),
          ), // Esto garantiza que el RolBloc se inicialice correctamente
        ),
      ],
      child: const App(),
    ),
  );
}