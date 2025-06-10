import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/buscar_categorias_por_nombre_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/delete_categoria_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/get_categoria_by_id_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/get_categorias_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/post_categoria_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/categoria/put_categoria_usecase.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_state.dart';
import 'package:rxdart/rxdart.dart';

class CategoriaBloc extends Bloc<CategoriaEvent, CategoriaState> {
  final GetCategoriasUseCase getCategoriasUseCase;
  final GetCategoriaByIdUseCase getCategoriaByIdUseCase;
  final PostCategoriaUseCase postCategoriaUseCase;
  final PutCategoriaUseCase putCategoriaUseCase;
  final DeleteCategoriaUseCase deleteCategoriaUseCase;
  final BuscarCategoriasPorNombreUseCase buscarCategoriasPorNombreUseCase;

  CategoriaBloc({
    required this.getCategoriasUseCase,
    required this.getCategoriaByIdUseCase,
    required this.postCategoriaUseCase,
    required this.putCategoriaUseCase,
    required this.deleteCategoriaUseCase,
    required this.buscarCategoriasPorNombreUseCase,
  }) : super(CategoriaInitial()) {
    on<GetAllCategoriasEvent>((event, emit) async {
      emit(CategoriaLoading());
      try {
        final categorias = await getCategoriasUseCase();
        emit(CategoriaListLoaded(categorias));
      } catch (e) {
        emit(CategoriaError("Error al obtener categorías: $e"));
      }
    });

    on<GetCategoriaByIdEvent>((event, emit) async {
      emit(CategoriaLoading());
      try {
        final categoria = await getCategoriaByIdUseCase(event.id);
        emit(CategoriaLoaded(categoria));
      } catch (e) {
        emit(CategoriaError("Error al obtener categoría: $e"));
      }
    });

    on<CreateCategoriaEvent>((event, emit) async {
      emit(CategoriaLoading());
      try {
        final categoria = await postCategoriaUseCase(event.dto, event.imagen);
        emit(CategoriaSuccess(categoria));
      } catch (e) {
        emit(CategoriaError("Error al crear categoría: $e"));
      }
    });

    on<UpdateCategoriaEvent>((event, emit) async {
      emit(CategoriaLoading());
      try {
        final categoria = await putCategoriaUseCase(
          event.id,
          event.dto,
          event.imagen,
        );
        emit(CategoriaSuccess(categoria));
      } catch (e) {
        emit(CategoriaError("Error al actualizar categoría: $e"));
      }
    });

    on<DeleteCategoriaEvent>((event, emit) async {
      emit(CategoriaLoading());
      try {
        await deleteCategoriaUseCase(event.id);
        emit(CategoriaDeleted());
      } catch (e) {
        emit(CategoriaError("Error al eliminar categoría: $e"));
      }
    });

    on<SearchCategoriaByNameEvent>(
          (event, emit) async {
      try {
        final categorias = await buscarCategoriasPorNombreUseCase(event.nombre);
        emit(CategoriaListLoaded(categorias));
      } catch (e) {
        emit(CategoriaError("Error al buscar categoría: $e"));
      }
    },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
  }
}