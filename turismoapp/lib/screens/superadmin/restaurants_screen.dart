import 'package:flutter/material.dart';
import 'package:turismoapp/screens/superadmin/services/restaurant_service.dart';
import 'RestaurantEditScreen.dart'; // Asegúrate de crear un servicio para manejar las solicitudes.

class RestaurantsScreen extends StatefulWidget {
  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  final restaurantService = RestaurantService();
  List<dynamic> restaurants = [];
  bool isLoading = false;

  Future<void> fetchRestaurants() async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await restaurantService.getRestaurants();
      setState(() {
        restaurants = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al cargar restaurantes')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestión de Restaurantes"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Navegar a la pantalla de creación de restaurante
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => RestaurantEditScreen()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : restaurants.isEmpty
          ? Center(child: Text("No hay restaurantes disponibles"))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
          childAspectRatio: 0.8, // Proporción del aspecto de cada tarjeta
        ),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                Image.network(
                  restaurant['imageUrl'],
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                ListTile(
                  title: Text(restaurant['name']),
                  subtitle: Text(restaurant['address']),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Aquí navegarías a la pantalla de edición
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RestaurantEditScreen(restaurantId: restaurant['id']),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Aquí eliminarías el restaurante
                        _deleteRestaurant(restaurant['id']);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _deleteRestaurant(int id) async {
    try {
      await restaurantService.deleteRestaurant(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Restaurante eliminado')));
      fetchRestaurants();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al eliminar restaurante')));
    }
  }
}
