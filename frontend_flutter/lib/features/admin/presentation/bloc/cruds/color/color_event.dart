part of 'color_bloc.dart';

abstract class ColorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetColoresEvent extends ColorEvent {}

class GetColorByIdEvent extends ColorEvent {
  final int id;

  GetColorByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class PostColorEvent extends ColorEvent {
  final ColorDto dto;

  PostColorEvent(this.dto);

  @override
  List<Object?> get props => [dto];
}

class PutColorEvent extends ColorEvent {
  final int id;
  final ColorDto dto;

  PutColorEvent(this.id, this.dto);

  @override
  List<Object?> get props => [id, dto];
}

class DeleteColorEvent extends ColorEvent {
  final int id;

  DeleteColorEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class BuscarColoresPorNombreEvent extends ColorEvent {
  final String nombre;

  BuscarColoresPorNombreEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}
