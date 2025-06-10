import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infotel_flutter/features/admin/data/models/color_dto.dart';
import 'package:infotel_flutter/features/admin/data/models/color_response.dart';
import 'package:infotel_flutter/features/admin/presentation/bloc/cruds/color/color_bloc.dart';
import 'package:infotel_flutter/features/admin/presentation/widgets/info_row_widget.dart';

class ColorScreen extends StatefulWidget {
  const ColorScreen({super.key});

  @override
  State<ColorScreen> createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _idColor;
  final _nombreController = TextEditingController();
  File? _imagenController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ColorBloc>().add(GetColoresEvent());
  }

  void _resetForm() {
    _nombreController.clear();
    _imagenController = null;
    _idColor = null;
  }

  void _cargarParaEditar(ColorResponse color) {
    setState(() {
      _idColor = color.idColor;
      _nombreController.text = color.nombre ?? "";
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
      final dto = ColorDto(nombre: _nombreController.text);

      if (_idColor != null) {
        context.read<ColorBloc>().add(PutColorEvent(_idColor!, dto));
      } else {
        context.read<ColorBloc>().add(PostColorEvent(dto));
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
                      _idColor != null ? "Editar Color" : "Crear Color",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(labelText: "Nombre"),
                      validator: (v) => v!.isEmpty ? "Campo requerido" : null,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: _submitForm,
                          child: Text(_idColor == null ? "Crear" : "Actualizar"),
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

  Future<bool?> _onDismissed(BuildContext context, ColorResponse color) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Eliminar color?"),
        content: Text("¿Seguro que deseas eliminar el color '${color.nombre}'?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancelar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Eliminar")),
        ],
      ),
    );

    if (confirm == true) {
      context.read<ColorBloc>().add(DeleteColorEvent(color.idColor!));
    }

    return confirm;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocListener<ColorBloc, ColorState>(
          listener: (context, state) {
            if (state is ColorSuccess) {
              context.read<ColorBloc>().add(GetColoresEvent());
            }
          },
          child: BlocBuilder<ColorBloc, ColorState>(
            builder: (context, state) {
              if (state is ColorLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ColoresLoaded) {
                return Column(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) =>
                          context.read<ColorBloc>().add(BuscarColoresPorNombreEvent(value)),
                      decoration: const InputDecoration(
                        labelText: 'Buscar color...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.colores.length,
                        itemBuilder: (context, index) {
                          final color = state.colores[index];
                          return Dismissible(
                            key: Key(color.idColor.toString()),
                            confirmDismiss: (_) => _onDismissed(context, color),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20),
                              child: const Icon(Icons.delete, color: Colors.white),
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(color.nombre ?? ""),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.info, color: Colors.blue),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text("Detalle de Color"),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                InfoRowWidget(label: "ID", value: color.idColor.toString()),
                                                InfoRowWidget(label: "Nombre", value: color.nombre),
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
                                        _cargarParaEditar(color);
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
              } else if (state is ColorError) {
                return Text("Error: ${state.message}", style: const TextStyle(color: Colors.red));
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