import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:infotel_flutter/features/admin/data/datasources/remote/categoria_api_client.dart';
import 'package:infotel_flutter/features/admin/data/datasources/remote/color_api_client.dart';
import 'package:infotel_flutter/features/admin/data/datasources/remote/dashboard_admin_api_client.dart';
import 'package:infotel_flutter/features/admin/data/datasources/remote/producto_api_client.dart';
import 'package:infotel_flutter/features/admin/data/datasources/remote/rol_api_client.dart';
import 'package:infotel_flutter/features/admin/data/datasources/remote/usuario_api_client.dart';
import 'package:infotel_flutter/features/admin/data/repositories/categoria_repository_impl.dart';
import 'package:infotel_flutter/features/admin/data/repositories/color_repository_impl.dart';
import 'package:infotel_flutter/features/admin/data/repositories/dashboard_admin_repository_impl.dart';
import 'package:infotel_flutter/features/admin/data/repositories/producto_repository_impl.dart';
import 'package:infotel_flutter/features/admin/data/repositories/rol_repository_impl.dart';
import 'package:infotel_flutter/features/admin/data/repositories/usuario_respository_impl.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/categoria_repository.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/color_repository.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/dashboard_admin_repository.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/producto_repository.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/rol_repository.dart';
import 'package:infotel_flutter/features/admin/domain/repositories/usuario_repository.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/buscar_categorias_por_nombre_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/delete_categoria_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/get_categoria_by_id_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/get_categorias_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/post_categoria_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/put_categoria_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/buscar_colores_por_nombre_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/delete_color_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/get_color_by_id_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/get_colores_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/post_color_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/put_color_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/dashboard/get_dashboard_admin_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/buscar_productos_por_nombre_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/delete_producto_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/get_producto_by_id_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/get_productos_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/post_producto_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/put_producto_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/rol/buscar_roles_por_nombre_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/rol/create_rol_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/rol/delete_rol_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/rol/get_rol_by_id_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/rol/get_roles_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/rol/update_rol_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/usuario/buscar_usuarios_completos_por_nombre_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/usuario/create_usuario_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/usuario/delete_usuario_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/usuario/get_usuario_by_id_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/usuario/get_usuarios_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/usuario/update_usuario_usecase.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/color/color_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/producto/producto_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/usuario/usuario_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/dashboard/dashboard_admin_bloc.dart';

final getIt = GetIt.instance;

void injectAdminDependencies() {
  // ApiClient para CRUD de roles usando Dio con interceptor
  getIt.registerLazySingleton<RolApiClient>(
        () => RolApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<RolRepository>(
        () => RolRepositoryImpl(rolApiClient: getIt<RolApiClient>()),
  );

  getIt.registerLazySingleton<CreateRolUseCase>(
        () => CreateRolUseCase(rolRepository: getIt<RolRepository>()),
  );

  getIt.registerLazySingleton<GetRolesUseCase>(
        () => GetRolesUseCase(rolRepository: getIt<RolRepository>()),
  );

  getIt.registerLazySingleton<UpdateRolUseCase>(
        () => UpdateRolUseCase(rolRepository: getIt<RolRepository>()),
  );

  getIt.registerLazySingleton<DeleteRolUseCase>(
        () => DeleteRolUseCase(rolRepository: getIt<RolRepository>()),
  );

  getIt.registerLazySingleton<GetRolByIdUseCase>(
        () => GetRolByIdUseCase(rolRepository: getIt<RolRepository>()),
  );

  getIt.registerLazySingleton<BuscarRolesPorNombreUsecase>(
        () => BuscarRolesPorNombreUsecase(getIt<RolRepository>()),
  );
  print('✅ BuscarRolesPorNombreUsecase registrado'); // <-- este print

  // ---------- USUARIO ----------
  getIt.registerLazySingleton<UsuarioApiClient>(
        () => UsuarioApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<UsuarioRepository>(
        () => UsuarioRepositoryImpl(getIt<UsuarioApiClient>()),
  );

  getIt.registerLazySingleton<GetAllUsuariosUseCase>(
        () => GetAllUsuariosUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerLazySingleton<GetUsuarioByIdUseCase>(
        () => GetUsuarioByIdUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerLazySingleton<CreateUsuarioUseCase>(
        () => CreateUsuarioUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerLazySingleton<UpdateUsuarioUseCase>(
        () => UpdateUsuarioUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerLazySingleton<DeleteUsuarioUseCase>(
        () => DeleteUsuarioUseCase(getIt<UsuarioRepository>()),
  );

  getIt.registerLazySingleton<BuscarUsuariosCompletosPorNombreUsecase>(
        () => BuscarUsuariosCompletosPorNombreUsecase(getIt<UsuarioRepository>()),
  );

  getIt.registerFactory<UsuarioBloc>(
        () => UsuarioBloc(
      getAllUsuariosUseCase: getIt<GetAllUsuariosUseCase>(),
      getUsuarioByIdUseCase: getIt<GetUsuarioByIdUseCase>(),
      createUsuarioUseCase: getIt<CreateUsuarioUseCase>(),
      updateUsuarioUseCase: getIt<UpdateUsuarioUseCase>(),
      deleteUsuarioUseCase: getIt<DeleteUsuarioUseCase>(),
      buscarUsuariosCompletosPorNombreUsecase: getIt<BuscarUsuariosCompletosPorNombreUsecase>(),
      tokenStorageService: getIt(),
    ),
  );

  // ---------- CATEGORIA ----------
  getIt.registerLazySingleton<CategoriaApiClient>(
        () => CategoriaApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<CategoriaRepository>(
        () => CategoriaRepositoryImpl(getIt<CategoriaApiClient>()),
  );

  getIt.registerLazySingleton<GetCategoriasUseCase>(
        () => GetCategoriasUseCase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<GetCategoriaByIdUseCase>(
        () => GetCategoriaByIdUseCase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<PostCategoriaUseCase>(
        () => PostCategoriaUseCase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<PutCategoriaUseCase>(
        () => PutCategoriaUseCase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<DeleteCategoriaUseCase>(
        () => DeleteCategoriaUseCase(getIt<CategoriaRepository>()),
  );

  getIt.registerLazySingleton<BuscarCategoriasPorNombreUseCase>(
        () => BuscarCategoriasPorNombreUseCase(getIt<CategoriaRepository>()),
  );

  getIt.registerFactory<CategoriaBloc>(
        () => CategoriaBloc(
      getCategoriasUseCase: getIt<GetCategoriasUseCase>(),
          getCategoriaByIdUseCase: getIt<GetCategoriaByIdUseCase>(),
          postCategoriaUseCase: getIt<PostCategoriaUseCase>(),
          putCategoriaUseCase: getIt<PutCategoriaUseCase>(),
          deleteCategoriaUseCase: getIt<DeleteCategoriaUseCase>(),
          buscarCategoriasPorNombreUseCase: getIt<BuscarCategoriasPorNombreUseCase>(),
    ),
  );

  // ---------- PRODUCTO ----------
  getIt.registerLazySingleton<ProductoApiClient>(
        () => ProductoApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ProductoRepository>(
        () => ProductoRepositoryImpl(getIt<ProductoApiClient>()),
  );

  getIt.registerLazySingleton<GetProductosUsecase>(
        () => GetProductosUsecase(getIt<ProductoRepository>()),
  );

  getIt.registerLazySingleton<GetProductoByIdUsecase>(
        () => GetProductoByIdUsecase(getIt<ProductoRepository>()),
  );

  getIt.registerLazySingleton<PostProductoUsecase>(
        () => PostProductoUsecase(getIt<ProductoRepository>()),
  );

  getIt.registerLazySingleton<PutProductoUsecase>(
        () => PutProductoUsecase(getIt<ProductoRepository>()),
  );

  getIt.registerLazySingleton<DeleteProductoUsecase>(
        () => DeleteProductoUsecase(getIt<ProductoRepository>()),
  );

  getIt.registerLazySingleton<BuscarProductosPorNombreUsecase>(
        () => BuscarProductosPorNombreUsecase(getIt<ProductoRepository>()),
  );

  getIt.registerFactory<ProductoBloc>(
        () => ProductoBloc(
      getProductosUsecase: getIt<GetProductosUsecase>(),
      getProductoByIdUsecase: getIt<GetProductoByIdUsecase>(),
      postProductoUsecase: getIt<PostProductoUsecase>(),
      putProductoUsecase: getIt<PutProductoUsecase>(),
      deleteProductoUsecase: getIt<DeleteProductoUsecase>(),
      buscarProductosPorNombreUsecase: getIt<BuscarProductosPorNombreUsecase>(),
    ),
  );

  // ---------- COLOR ----------
  getIt.registerLazySingleton<ColorApiClient>(
        () => ColorApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ColorRepository>(
        () => ColorRepositoryImpl(getIt<ColorApiClient>()),
  );

  getIt.registerLazySingleton<GetColoresUsecase>(
        () => GetColoresUsecase(getIt<ColorRepository>()),
  );

  getIt.registerLazySingleton<GetColorByIdUsecase>(
        () => GetColorByIdUsecase(getIt<ColorRepository>()),
  );

  getIt.registerLazySingleton<PostColorUsecase>(
        () => PostColorUsecase(getIt<ColorRepository>()),
  );

  getIt.registerLazySingleton<PutColorUsecase>(
        () => PutColorUsecase(getIt<ColorRepository>()),
  );

  getIt.registerLazySingleton<DeleteColorUsecase>(
        () => DeleteColorUsecase(getIt<ColorRepository>()),
  );

  getIt.registerLazySingleton<BuscarColoresPorNombreUsecase>(
        () => BuscarColoresPorNombreUsecase(getIt<ColorRepository>()),
  );

  getIt.registerFactory<ColorBloc>(
        () => ColorBloc(
      getColoresUsecase: getIt<GetColoresUsecase>(),
      getColorByIdUsecase: getIt<GetColorByIdUsecase>(),
      postColorUsecase: getIt<PostColorUsecase>(),
      putColorUsecase: getIt<PutColorUsecase>(),
      deleteColorUsecase: getIt<DeleteColorUsecase>(),
      buscarColoresPorNombreUsecase: getIt<BuscarColoresPorNombreUsecase>(),
    ),
  );

  // ---------- DASHBOARD ----------
  getIt.registerLazySingleton<DashboardAdminApiClient>(
        () => DashboardAdminApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<DashboardAdminRepository>(
        () => DashboardAdminRepositoryImpl(getIt<DashboardAdminApiClient>()),
  );

  getIt.registerLazySingleton<GetDashboardAdminUseCase>(
        () => GetDashboardAdminUseCase(getIt<DashboardAdminRepository>()),
  );

  getIt.registerFactory<DashboardAdminBloc>(
        () => DashboardAdminBloc(
      getDashboardAdminUseCase: getIt<GetDashboardAdminUseCase>(),
    ),
  );
}