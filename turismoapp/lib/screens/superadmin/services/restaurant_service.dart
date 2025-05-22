import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantService {
  static const String baseUrl = 'http://192.168.43.81:8080/api/restaurants';

  // Obtener el token de autenticación almacenado
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  // Configurar los encabezados de la solicitud, incluyendo el token JWT
  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Obtener todos los restaurantes
  Future<List<dynamic>> getRestaurants() async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error al cargar restaurantes');
    }
  }

  // Obtener un restaurante por ID
  Future<Map<String, dynamic>> getRestaurantById(int id) async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse('$baseUrl/$id'), headers: headers);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al cargar restaurante');
    }
  }

  // Crear
  Future<Map<String, dynamic>> createRestaurant(Map<String, dynamic> restaurantData) async {
    final headers = await _getHeaders();
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: jsonEncode(restaurantData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al crear restaurante');
    }
  }

  // Actualizar
  Future<Map<String, dynamic>> updateRestaurant(int id, Map<String, dynamic> restaurantData) async {
    final headers = await _getHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: headers,
      body: jsonEncode(restaurantData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al actualizar restaurante');
    }
  }

  // Eliminar
  Future<void> deleteRestaurant(int id) async {
    final headers = await _getHeaders();
    final response = await http.delete(Uri.parse('$baseUrl/$id'), headers: headers);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al eliminar restaurante');
    }
  }

  // imagen
  Future<void> uploadImage(int restaurantId, XFile imageFile) async {
    final url = Uri.parse('$baseUrl/$restaurantId/uploadImage');
    final request = http.MultipartRequest('POST', url);
    final headers = await _getHeaders();
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();
    if (response.statusCode != 200) {
      throw Exception('Error al subir la imagen');
    }
  }
}
