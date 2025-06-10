import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infotel_flutter/features/admin/data/models/categoria_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/categoria_response.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_event.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/categoria/categoria_state.dart';
import 'package:infotel_flutter/features/admin/presentation/widgets/foto_widget.dart';
import 'package:infotel_flutter/features/admin/presentation/widgets/info_row_widget.dart';

class CategoriaScreen extends StatefulWidget {
  const CategoriaScreen({super.key});

  @override
  State<CategoriaScreen> createState() => _CategoriaScreenState();
}

class _CategoriaScreenState extends State<CategoriaScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _idCategoria;
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  File? _imagenController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CategoriaBloc>().add(GetAllCategoriasEvent());
  }

  void _resetForm() {
    _nombreController.clear();
    _descripcionController.clear();
    _imagenController = null;
    _idCategoria = null;
  }

  void _cargarParaEditar(CategoriaResponse categoria) {
    setState(() {
      _idCategoria = categoria.idCategoria;
      _nombreController.text = categoria.nombre ?? "";
      _descripcionController.text = categoria.descripcion ?? "";
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
      final dto = CategoriaDto(
        nombre: _nombreController.text,
        descripcion: _descripcionController.text,
      );

      if (_idCategoria != null) {
        context.read<CategoriaBloc>().add(UpdateCategoriaEvent(
          _idCategoria!,
          dto,
          _imagenController,
        ));
      } else {
        context.read<CategoriaBloc>().add(CreateCategoriaEvent(
          dto,
          _imagenController,
        ));
      }

      _resetForm();
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, completa todos los campos requeridos.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _mostrarFormulario(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setStateDialog) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Text(
                      _idCategoria != null ? "Editar Categoría" : "Crear Categoría",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(labelText: "Nombre"),
                      validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                    ),
                    TextFormField(
                      controller: _descripcionController,
                      decoration: const InputDecoration(labelText: "Descripción"),
                      validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => _pickImage(() => setStateDialog(() {})),
                      child: const Text("Seleccionar Imagen"),
                    ),
                    const SizedBox(height: 10),
                    if (_imagenController != null)
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(_imagenController!, fit: BoxFit.cover),
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text(_idCategoria == null ? "Crear" : "Actualizar"),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {
                            _resetForm();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancelar"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Future<bool?> _onDismissed(BuildContext context, CategoriaResponse categoria) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Eliminar categoría?"),
        content: Text("¿Seguro que deseas eliminar la categoría '${categoria.nombre}'?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Eliminar")),
        ],
      ),
    );

    if (confirm == true) {
      context.read<CategoriaBloc>().add(DeleteCategoriaEvent(categoria.idCategoria!));
    }

    return confirm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<CategoriaBloc, CategoriaState>(
          listener: (context, state) {
            if (state is CategoriaSuccess || state is CategoriaDeleted) {
              context.read<CategoriaBloc>().add(GetAllCategoriasEvent());
            }
          },
          child: BlocBuilder<CategoriaBloc, CategoriaState>(
            builder: (context, state) {
              if (state is CategoriaLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CategoriaListLoaded) {
                return Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) => context.read<CategoriaBloc>().add(
                        SearchCategoriaByNameEvent(value),
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Buscar categoría...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.categorias.length,
                        itemBuilder: (context, index) {
                          final categoria = state.categorias[index];
                          return Dismissible(
                            key: Key(categoria.idCategoria.toString()),
                            confirmDismiss: (_) => _onDismissed(context, categoria),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                leading: FotoWidget(fileName: categoria.iconoUrl ?? ""),
                                title: Text(categoria.nombre ?? ""),
                                subtitle: Text(categoria.descripcion ?? ""),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.info, color: Colors.blue),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text("Detalle de Categoría"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                FotoWidget(fileName: categoria.iconoUrl ?? "", size: 80),
                                                InfoRowWidget(label: "ID", value: categoria.idCategoria.toString()),
                                                InfoRowWidget(label: "Nombre", value: categoria.nombre),
                                                InfoRowWidget(label: "Descripción", value: categoria.descripcion ?? ""),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.of(context).pop(),
                                                child: const Text("Cerrar"),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.green),
                                      onPressed: () {
                                        _cargarParaEditar(categoria);
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
                    ),
                  ],
                );
              } else if (state is CategoriaError) {
                return Text("Error: ${state.mensaje}", style: const TextStyle(color: Colors.red));
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