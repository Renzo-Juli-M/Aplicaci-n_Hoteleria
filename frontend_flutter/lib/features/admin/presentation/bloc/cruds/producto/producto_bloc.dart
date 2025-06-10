import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_dto.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/buscar_productos_por_nombre_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/delete_producto_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/get_producto_by_id_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/get_productos_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/post_producto_usecase.dart';
import 'package:infotel_flutter/features/admin/domain/usecases/producto/put_producto_usecase.dart';
import 'package:rxdart/rxdart.dart';
import 'producto_event.dart';
import 'producto_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  final GetProductosUsecase getProductosUsecase;
  final GetProductoByIdUsecase getProductoByIdUsecase;
  final BuscarProductosPorNombreUsecase buscarProductosPorNombreUsecase;
  final PostProductoUsecase postProductoUsecase;
  final PutProductoUsecase putProductoUsecase;
  final DeleteProductoUsecase deleteProductoUsecase;

  ProductoBloc({
    required this.getProductosUsecase,
    required this.getProductoByIdUsecase,
    required this.buscarProductosPorNombreUsecase,
    required this.postProductoUsecase,
    required this.putProductoUsecase,
    required this.deleteProductoUsecase,
  }) : super(ProductoInitial()) {
    on<GetProductosEvent>((event, emit) async {
      emit(ProductoLoading());
      try {
        final productos = await getProductosUsecase();
        emit(ProductosLoaded(productos));
      } catch (e) {
        emit(ProductoError("Error al obtener productos: $e"));
      }
    });

    on<GetProductoByIdEvent>((event, emit) async {
      emit(ProductoLoading());
      try {
        final producto = await getProductoByIdUsecase(event.id);
        emit(ProductoLoaded(producto));
      } catch (e) {
        emit(ProductoError("Error al obtener producto: $e"));
      }
    });

    on<BuscarProductosPorNombreEvent>((event, emit) async {
      try {
        final productos = await buscarProductosPorNombreUsecase(event.nombre);
        emit(ProductosLoaded(productos));
      } catch (e) {
        emit(ProductoError("Error al buscar productos: $e"));
      }
    },
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );

    on<PostProductoEvent>((event, emit) async {
      emit(ProductoLoading());
      try {
        final producto = await postProductoUsecase(event.producto, event.imagen);
        emit(ProductoSuccess("Producto creado: ${producto.nombre}"));
      } catch (e) {
        emit(ProductoError("Error al crear producto: $e"));
      }
    });

    on<PutProductoEvent>((event, emit) async {
      emit(ProductoLoading());
      try {
        final producto = await putProductoUsecase(event.id, event.producto, event.imagen);
        emit(ProductoSuccess("Producto actualizado: ${producto.nombre}"));
      } catch (e) {
        emit(ProductoError("Error al actualizar producto: $e"));
      }
    });

    on<DeleteProductoEvent>((event, emit) async {
      emit(ProductoLoading());
      try {
        await deleteProductoUsecase(event.id);
        emit(ProductoSuccess("Producto eliminado con éxito"));
      } catch (e) {
        emit(ProductoError("Error al eliminar producto: $e"));
      }
    });
  }
}