import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/producto_response.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_state.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/color/color_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/producto/producto_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/producto/producto_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/producto/producto_state.dart';
import 'package:infotel_flutter/features/admin/presentation/widgets/foto_widget.dart';

class ProductoScreen extends StatefulWidget {
  const ProductoScreen({super.key});

  @override
  State<ProductoScreen> createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _idProducto;
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _tallasController = TextEditingController();
  final _materialController = TextEditingController();
  final _precioController = TextEditingController();
  final _stockController = TextEditingController();
  final _categoriaController = TextEditingController();
  File? _imagenController;
  final _searchController = TextEditingController();

  String? _categoriaSeleccionada;

  final TextEditingController _coloresController = TextEditingController();
  List<String> _coloresSeleccionados = [];


  @override
  void initState() {
    super.initState();
    context.read<ProductoBloc>().add(GetProductosEvent());
  }

  void _resetForm() {
    _idProducto = null;
    _nombreController.clear();
    _descripcionController.clear();
    _tallasController.clear();
    _materialController.clear();
    _precioController.clear();
    _stockController.clear();
    _categoriaController.clear();
    _coloresController.clear();
    _imagenController = null;
  }

  void _cargarParaEditar(ProductoResponse producto) {
    setState(() {
      _idProducto = producto.idProducto;
      _nombreController.text = producto.nombre ?? "";
      _descripcionController.text = producto.descripcion ?? "";
      _tallasController.text = producto.tallas ?? "";
      _materialController.text = producto.material ?? "";
      _precioController.text = producto.precio?.toString() ?? "";
      _stockController.text = producto.stock?.toString() ?? "";
    });
  }

  Future<void> _pickImage(Function() setStateCallback) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imagenController = File(image.path);
      setStateCallback();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final dto = ProductoDto(
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
        tallas: _tallasController.text,
        material: _materialController.text,
        precio: double.tryParse(_precioController.text),
        stock: int.tryParse(_stockController.text),
        nombreCategoria: _categoriaController.text,
        nombresColores: _coloresSeleccionados,
      );

      if (_idProducto != null) {
        context.read<ProductoBloc>().add(PutProductoEvent(
          _idProducto!,
          dto,
          _imagenController,
        ));
      } else {
        context.read<ProductoBloc>().add(PostProductoEvent(
          dto,
          _imagenController,
        ));
      }

      _resetForm();
      Navigator.of(context).pop();
    }
  }

  void _mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) => AlertDialog(
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(controller: _nombreController, decoration: const InputDecoration(labelText: 'Nombre'), validator: _required),
                    TextFormField(controller: _descripcionController, decoration: const InputDecoration(labelText: 'Descripción'), validator: _required),
                    TextFormField(controller: _tallasController, decoration: const InputDecoration(labelText: 'Tallas'), validator: _required),
                    TextFormField(controller: _materialController, decoration: const InputDecoration(labelText: 'Material'), validator: _required),
                    TextFormField(controller: _precioController, decoration: const InputDecoration(labelText: 'Precio'), validator: _required, keyboardType: TextInputType.number),
                    TextFormField(controller: _stockController, decoration: const InputDecoration(labelText: 'Stock'), validator: _required, keyboardType: TextInputType.number),
                    BlocBuilder<CategoriaBloc, CategoriaState>(
                      builder: (context, categoriaState) {
                        if (categoriaState is CategoriaListLoaded) {
                          final categorias = categoriaState.categorias
                              .map((c) => c.nombre)
                              .toSet()
                              .toList();

                          final currentValue = categorias.contains(_categoriaController.text)
                              ? _categoriaController.text
                              : null;

                          return DropdownButtonFormField<String>(
                            value: _categoriaSeleccionada ?? currentValue,
                            decoration: const InputDecoration(labelText: "Categoria"),
                            items: categorias.map((categoria) {
                              return DropdownMenuItem(value: categoria, child: Text(categoria!));
                            }).toList(),
                            onChanged: (value) {
                              setStateDialog(() {
                                _categoriaSeleccionada = value;
                                _categoriaController.text = value ?? '';
                              });
                            },
                            validator: (value) =>
                            value == null || value.isEmpty ? 'Campo requerido' : null,
                          );
                        } else if (categoriaState is CategoriaLoading) {
                          return const CircularProgressIndicator();
                        } else if (categoriaState is CategoriaError) {
                          return Text("Error al cargar roles: ${categoriaState.mensaje}");
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    BlocBuilder<ColorBloc, ColorState>(
                      builder: (context, colorState) {
                        if (colorState is ColoresLoaded) {
                          final colores = colorState.colores.map((c) => c.nombre ?? '').toList();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Colores", style: TextStyle(fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: () async {
                                  final seleccionados = await showDialog<List<String>>(
                                    context: context,
                                    builder: (context) {
                                      List<String> seleccionTemp = List.from(_coloresSeleccionados);
                                      return StatefulBuilder(
                                        builder: (context, setStateCheckbox) {
                                          return AlertDialog(
                                            title: const Text("Selecciona colores"),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: colores.map((nombre) {
                                                  return CheckboxListTile(
                                                    title: Text(nombre),
                                                    value: seleccionTemp.contains(nombre),
                                                    onChanged: (bool? selected) {
                                                      setStateCheckbox(() {
                                                        if (selected == true) {
                                                          seleccionTemp.add(nombre);
                                                        } else {
                                                          seleccionTemp.remove(nombre);
                                                        }
                                                      });
                                                    },
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text("Cancelar"),
                                              ),
                                              ElevatedButton(
                                                onPressed: () => Navigator.pop(context, seleccionTemp),
                                                child: const Text("Aceptar"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  );

                                  if (seleccionados != null) {
                                    setStateDialog(() {
                                      _coloresSeleccionados = seleccionados;
                                      _coloresController.text = seleccionados.join(', ');
                                    });
                                  }
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    controller: _coloresController,
                                    decoration: const InputDecoration(
                                      labelText: 'Colores',
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                    ),
                                    validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (colorState is ColorLoading) {
                          return const CircularProgressIndicator();
                        } else if (colorState is ColorError) {
                          return Text("Error al cargar colores: ${colorState.message}");
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    ElevatedButton(onPressed: () => _pickImage(() => setStateDialog(() {})), child: const Text("Seleccionar Imagen")),
                    if (_imagenController != null)
                      Image.file(_imagenController!, width: 100, height: 100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(onPressed: _submitForm, child: Text(_idProducto == null ? "Crear" : "Actualizar")),
                        OutlinedButton(onPressed: () => Navigator.of(context).pop(), child: const Text("Cancelar"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String? _required(String? v) => (v == null || v.isEmpty) ? "Campo requerido" : null;

  void _mostrarDetalleProducto(BuildContext context, ProductoResponse producto) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(producto.nombre ?? "Detalle del producto"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (producto.imagenUrl != null && producto.imagenUrl!.isNotEmpty)
                FotoWidget(fileName: producto.imagenUrl!),
              Text("Descripción: ${producto.descripcion ?? ""}"),
              const SizedBox(height: 8),
              Text("Tallas: ${producto.tallas ?? ""}"),
              Text("Material: ${producto.material ?? ""}"),
              Text("Precio: \$${producto.precio?.toStringAsFixed(2) ?? '0.00'}"),
              Text("Stock: ${producto.stock ?? 0}"),
              Text("Categoría: ${producto.categoria ?? 'N/A'}"),
              Text("Colores: ${producto.productoColores ?? ''}"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<ProductoBloc, ProductoState>(
          listener: (context, state) {
            if (state is ProductoSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              context.read<ProductoBloc>().add(GetProductosEvent());
            }
          },
          child: BlocBuilder<ProductoBloc, ProductoState>(
            builder: (context, state) {
              if (state is ProductoLoading) return const Center(child: CircularProgressIndicator());
              if (state is ProductosLoaded) {
                return Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) => context.read<ProductoBloc>().add(BuscarProductosPorNombreEvent(value)),
                      decoration: const InputDecoration(
                        labelText: 'Buscar productos...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.productos.length,
                        itemBuilder: (_, index) {
                          final producto = state.productos[index];
                          return Dismissible(
                            key: Key(producto.idProducto.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            onDismissed: (_) {
                              context.read<ProductoBloc>().add(DeleteProductoEvent(producto.idProducto!));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Producto eliminado: ${producto.nombre}')),
                              );
                            },
                            child: Card(
                              child: ListTile(
                                leading: FotoWidget(fileName: producto.imagenUrl ?? ""),
                                title: Text(producto.nombre ?? ""),
                                subtitle: Text(producto.descripcion ?? ""),
                                trailing: Wrap(
                                  spacing: 8,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.info, color: Colors.blue),
                                      onPressed: () => _mostrarDetalleProducto(context, producto),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.green),
                                      onPressed: () {
                                        _cargarParaEditar(producto);
                                        _mostrarFormulario(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                );
              }
              if (state is ProductoError) {
                return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _mostrarFormulario(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}