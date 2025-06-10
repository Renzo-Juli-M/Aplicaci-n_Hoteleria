import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_dto.dart';

abstract class ProductoEvent extends Equatable {
  const ProductoEvent();

  @override
  List<Object?> get props => [];
}

class GetProductosEvent extends ProductoEvent {}

class GetProductoByIdEvent extends ProductoEvent {
  final int id;

  const GetProductoByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class BuscarProductosPorNombreEvent extends ProductoEvent {
  final String nombre;

  const BuscarProductosPorNombreEvent(this.nombre);

  @override
  List<Object?> get props => [nombre];
}

class PostProductoEvent extends ProductoEvent {
  final ProductoDto producto;
  final File? imagen;

  const PostProductoEvent(this.producto, this.imagen);

  @override
  List<Object?> get props => [producto, imagen];
}

class PutProductoEvent extends ProductoEvent {
  final int id;
  final ProductoDto producto;
  final File? imagen;

  const PutProductoEvent(this.id, this.producto, this.imagen);

  @override
  List<Object?> get props => [id, producto, imagen];
}

class DeleteProductoEvent extends ProductoEvent {
  final int id;

  const DeleteProductoEvent(this.id);

  @override
  List<Object?> get props => [id];
}