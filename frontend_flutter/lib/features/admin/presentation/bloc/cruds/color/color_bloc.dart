import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infotel_flutter/features/admin/data/models/color_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/buscar_colores_por_nombre_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/delete_color_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/get_color_by_id_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/get_colores_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/post_color_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/color/put_color_usecase.dart';
import 'package:rxdart/rxdart.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  final GetColoresUsecase getColoresUsecase;
  final GetColorByIdUsecase getColorByIdUsecase;
  final PostColorUsecase postColorUsecase;
  final PutColorUsecase putColorUsecase;
  final DeleteColorUsecase deleteColorUsecase;
  final BuscarColoresPorNombreUsecase buscarColoresPorNombreUsecase;

  ColorBloc({
    required this.getColoresUsecase,
    required this.getColorByIdUsecase,
    required this.postColorUsecase,
    required this.putColorUsecase,
    required this.deleteColorUsecase,
    required this.buscarColoresPorNombreUsecase,
  }) : super(ColorInitial()) {
    on<GetColoresEvent>(_onGetColores);
    on<GetColorByIdEvent>(_onGetColorById);
    on<PostColorEvent>(_onPostColor);
    on<PutColorEvent>(_onPutColor);
    on<DeleteColorEvent>(_onDeleteColor);
    on<BuscarColoresPorNombreEvent>(
      _onBuscarPorNombre,
      transformer: debounceRestartable(const Duration(milliseconds: 300)),
    );
  }

  Future<void> _onGetColores(GetColoresEvent event, Emitter<ColorState> emit) async {
    emit(ColorLoading());
    try {
      final colores = await getColoresUsecase();
      emit(ColoresLoaded(colores));
    } catch (e) {
      emit(ColorError("Error al obtener colores: $e"));
    }
  }

  Future<void> _onGetColorById(GetColorByIdEvent event, Emitter<ColorState> emit) async {
    emit(ColorLoading());
    try {
      final color = await getColorByIdUsecase(event.id);
      emit(ColorLoaded(color));
    } catch (e) {
      emit(ColorError("Error al obtener color: $e"));
    }
  }

  Future<void> _onPostColor(PostColorEvent event, Emitter<ColorState> emit) async {
    emit(ColorLoading());
    try {
      final nuevo = await postColorUsecase(event.dto);
      emit(ColorSuccess("Color creado correctamente", nuevo));
    } catch (e) {
      emit(ColorError("Error al crear color: $e"));
    }
  }

  Future<void> _onPutColor(PutColorEvent event, Emitter<ColorState> emit) async {
    emit(ColorLoading());
    try {
      final actualizado = await putColorUsecase(event.id, event.dto);
      emit(ColorSuccess("Color actualizado correctamente", actualizado));
    } catch (e) {
      emit(ColorError("Error al actualizar color: $e"));
    }
  }

  Future<void> _onDeleteColor(DeleteColorEvent event, Emitter<ColorState> emit) async {
    emit(ColorLoading());
    try {
      await deleteColorUsecase(event.id);
      emit(ColorSuccess("Color eliminado correctamente"));
    } catch (e) {
      emit(ColorError("Error al eliminar color: $e"));
    }
  }

  Future<void> _onBuscarPorNombre(BuscarColoresPorNombreEvent event, Emitter<ColorState> emit) async {
    try {
      final resultados = await buscarColoresPorNombreUsecase(event.nombre);
      emit(ColoresLoaded(resultados));
    } catch (e) {
      emit(ColorError("Error al buscar colores: $e"));
    }
  }

  EventTransformer<T> debounceRestartable<T>(Duration duration) {
    return (events, mapper) => events
        .debounceTime(duration)
        .switchMap(mapper); // evita búsquedas obsoletas
  }
}