import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:infotel_flutter/features/admin/data/models/categoria_dto.dart';

abstract class CategoriaEvent extends Equatable {
  const CategoriaEvent();

  @override
  List<Object?> get props => [];
}

class GetAllCategoriasEvent extends CategoriaEvent {}

class GetCategoriaByIdEvent extends CategoriaEvent {
  final int id;

  const GetCategoriaByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}

class CreateCategoriaEvent extends CategoriaEvent {
  final CategoriaDto dto;
  final File? imagen;

  const CreateCategoriaEvent(this.dto, this.imagen);

  @override
  List<Object?> get props => [dto, imagen];
}

class UpdateCategoriaEvent extends CategoriaEvent {
  final int id;
  final CategoriaDto dto;
  final File? imagen;

  const UpdateCategoriaEvent(this.id, this.dto, this.imagen);

  @override
  List<Object?> get props => [id, dto, imagen];
}

class DeleteCategoriaEvent extends CategoriaEvent {
  final int id;

  const DeleteCategoriaEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SearchCategoriaByNameEvent extends CategoriaEvent {
  final String nombre;

  const SearchCategoriaByNameEvent(this.nombre);

  @override
  List<Object> get props => [nombre];
}