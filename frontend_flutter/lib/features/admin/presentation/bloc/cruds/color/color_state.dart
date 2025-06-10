part of 'color_bloc.dart';

abstract class ColorState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ColorInitial extends ColorState {}

class ColorLoading extends ColorState {}

class ColoresLoaded extends ColorState {
  final List<ColorResponse> colores;

  ColoresLoaded(this.colores);

  @override
  List<Object?> get props => [colores];
}

class ColorLoaded extends ColorState {
  final ColorResponse color;

  ColorLoaded(this.color);

  @override
  List<Object?> get props => [color];
}

class ColorSuccess extends ColorState {
  final String message;
  final ColorResponse? color;

  ColorSuccess(this.message, [this.color]);

  @override
  List<Object?> get props => [message, color];
}

class ColorError extends ColorState {
  final String message;

  ColorError(this.message);

  @override
  List<Object?> get props => [message];
}