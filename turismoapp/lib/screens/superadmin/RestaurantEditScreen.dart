import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:turismoapp/screens/superadmin/services/restaurant_service.dart'; // Servicio para interactuar con el backend

class RestaurantEditScreen extends StatefulWidget {
  final int? restaurantId;

  const RestaurantEditScreen({Key? key, this.restaurantId}) : super(key: key);

  @override
  _RestaurantEditScreenState createState() => _RestaurantEditScreenState();
}

class _RestaurantEditScreenState extends State<RestaurantEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final restaurantService = RestaurantService();
  String name = '';
  String address = '';
  String description = '';
  XFile? _imageFile;
  bool isLoading = false;

  // Función para seleccionar una imagen de la galería
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  // Subir la imagen al servidor
  Future<void> _uploadImage(int restaurantId) async {
    if (_imageFile == null) return;

    final url = Uri.parse('http://192.168.1.8:8080/api/restaurants/$restaurantId/uploadImage');
    final request = http.MultipartRequest('POST', url);
    final headers = await _getHeaders();
    request.headers.addAll(headers as Map<String, String>);
    request.files.add(await http.MultipartFile.fromPath('image', _imageFile!.path));

    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Error al subir la imagen');
    }
  }

  // Guardar el restaurante
  Future<void> _saveRestaurant() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() => isLoading = true);

    try {
      final restaurantData = {
        "name": name,
        "address": address,
        "description": description,
      };

      int? restaurantId;

      if (widget.restaurantId == null) {
        final createdRestaurant = await restaurantService.createRestaurant(restaurantData);
        restaurantId = createdRestaurant['id'];
      } else {
        await restaurantService.updateRestaurant(widget.restaurantId!, restaurantData);
        restaurantId = widget.restaurantId!;
      }

      // Subir imagen si se seleccionó
      if (_imageFile != null && restaurantId != null) {
        await _uploadImage(restaurantId);
      }

      Navigator.pop(context, true); // Volver a la lista
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al guardar restaurante')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurantId == null ? 'Nuevo Restaurante' : 'Editar Restaurante'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Imagen'),
              SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: _imageFile != null
                    ? Image.file(File(_imageFile!.path), height: 150)
                    : Container(
                  height: 150,
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 100, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: name,
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => name = value ?? '',
              ),
              TextFormField(
                initialValue: address,
                decoration: InputDecoration(labelText: 'Dirección'),
                onSaved: (value) => address = value ?? '',
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Descripción'),
                onSaved: (value) => description = value ?? '',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveRestaurant,
                child: Text(widget.restaurantId == null ? 'Crear' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _getHeaders {
}
