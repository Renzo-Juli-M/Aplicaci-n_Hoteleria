import 'package:equatable/equatable.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';

abstract class ProductoState extends Equatable {
  const ProductoState();

  @override
  List<Object?> get props => [];
}

class ProductoInitial extends ProductoState {}

class ProductoLoading extends ProductoState {}

class ProductosLoaded extends ProductoState {
  final List<ProductoResponse> productos;

  const ProductosLoaded(this.productos);

  @override
  List<Object?> get props => [productos];
}

class ProductoLoaded extends ProductoState {
  final ProductoResponse producto;

  const ProductoLoaded(this.producto);

  @override
  List<Object?> get props => [producto];
}

class ProductoSuccess extends ProductoState {
  final String message;

  const ProductoSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductoError extends ProductoState {
  final String message;

  const ProductoError(this.message);

  @override
  List<Object?> get props => [message];
}