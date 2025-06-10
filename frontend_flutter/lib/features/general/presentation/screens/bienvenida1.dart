import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:go_router/go_router.dart';

class Bienvenida1 extends StatefulWidget {
  const Bienvenida1({super.key});

  @override
  _Bienvenida1State createState() => _Bienvenida1State();
}

class _Bienvenida1State extends State<Bienvenida1> {
  bool _isPressed = false;

  final List<Map<String, String>> products = [
    {
      'image': 'assets/images/imagenBienvenida1.png',
      'name': 'Black Winter Jacket',
      'description': 'Autumn & Winter  Casual cotton-padded jacket',
      'price': '₹499',
      'rating': '4.5',
      'reviews': '6,890',
    },
    {
      'image': 'assets/images/imagenBienvenida1.png',
      'name': 'Mens Starry Shirt',
      'description': 'Starry Sky Printed Shirt, 100% Cotton',
      'price': '₹399',
      'rating': '4.7',
      'reviews': '152,344',
    },
    {
      'image': 'assets/images/imagenBienvenida1.png',
      'name': 'Black Dress',
      'description': 'Solid Black Dress para Women, Sexy Chain Shorts',
      'price': '₹2,000',
      'rating': '4.6',
      'reviews': '5,234,456',
    },
    {
      'image': 'assets/images/playa.jpg',
      'name': 'Pink Embroidered',
      'description': 'EARTHEN Rose Pink Embroidered Tiered Maxi',
      'price': '₹1,900',
      'rating': '4.4',
      'reviews': '45,678',
    },
    {
      'image': 'assets/images/imagenBienvenida1.png',
      'name': 'Flare Dress',
      'description': 'Anthea   Black & Rust Orange Floral Print Tiered Midi',
      'price': '₹1,990',
      'rating': '4.3',
      'reviews': '355,566',
    },
    {
      'image': 'assets/images/imagenBienvenida1.png',
      'name': 'Denim Dress',
      'description': 'Blue cotton denim dress, Look 2 Printed cotton',
      'price': '₹999',
      'rating': '4.2',
      'reviews': '27,344',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar con el botón "Ingresar" pequeño
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Tesoros_Locales',
          style: TextStyle(
            color: Color(0xFF0AA3EF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AnimatedButton(
              height: 36,
              width: 100,
              text: 'Ingresar',
              isReverse: _isPressed,
              textStyle: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              transitionType: TransitionType.LEFT_TO_RIGHT,
              backgroundColor:
              _isPressed ? const Color(0xFF0AA3EF) : Colors.blueAccent,
              borderColor: Colors.blueAccent,
              borderRadius: 20,
              borderWidth: 1,
              onPress: () {
                setState(() {
                  _isPressed = !_isPressed;
                });
                context.go('/bienvenida1');
              },
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search any Product...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: const Icon(Icons.mic),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Count + Sort y Filter
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '52,082+ Items',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.swap_vert, size: 18),
                      label: const Text('Sort'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list, size: 18),
                      label: const Text('Filter'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Grid de productos
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.58,
                ),
                itemBuilder: (context, index) {
                  final p = products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen del producto
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: Image.asset(
                            p['image']!,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Detalles
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                p['name']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                p['description']!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600]),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                p['price']!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 14,
                                      color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(
                                    p['rating']!,
                                    style: const TextStyle(
                                        fontSize: 12),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '(${p['reviews']!})',
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
