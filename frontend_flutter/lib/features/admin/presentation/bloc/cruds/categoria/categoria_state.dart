import 'package:equatable/equatable.dart';
import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';

abstract class CategoriaState extends Equatable {
  const CategoriaState();

  @override
  List<Object?> get props => [];
}

class CategoriaInitial extends CategoriaState {}

class CategoriaLoading extends CategoriaState {}

class CategoriaListLoaded extends CategoriaState {
  final List<CategoriaResponse> categorias;

  const CategoriaListLoaded(this.categorias);

  @override
  List<Object> get props => [categorias];
}

class CategoriaLoaded extends CategoriaState {
  final CategoriaResponse categoria;

  const CategoriaLoaded(this.categoria);

  @override
  List<Object> get props => [categoria];
}

class CategoriaSuccess extends CategoriaState {
  final CategoriaResponse categoria;

  const CategoriaSuccess(this.categoria);

  @override
  List<Object> get props => [categoria];
}

class CategoriaDeleted extends CategoriaState {}

class CategoriaError extends CategoriaState {
  final String mensaje;

  const CategoriaError(this.mensaje);

  @override
  List<Object> get props => [mensaje];
}