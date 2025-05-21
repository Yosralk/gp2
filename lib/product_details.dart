import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final String productId;

  ProductDetailsPage({required this.product, required this.productId});

  final user = FirebaseAuth.instance.currentUser;

  Future<void> addToFavorites() async {
    if (user == null) return;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favorites')
        .doc(productId)
        .set(product);
  }

  Future<void> addToCart() async {
    if (user == null) return;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart')
        .doc(productId)
        .set({
      ...product,
      'quantity': 1,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(
              product['image'],
              height: 250,
            ),
            SizedBox(height: 20),
            Text(
              product['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '${product['price']} دينار',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: addToFavorites,
                  icon: Icon(Icons.favorite),
                  label: Text("إضافة للمفضلة"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.pink),
                ),
                ElevatedButton.icon(
                  onPressed: addToCart,
                  icon: Icon(Icons.shopping_cart),
                  label: Text("إضافة للسلة"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}