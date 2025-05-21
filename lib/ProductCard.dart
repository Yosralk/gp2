import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCard extends StatelessWidget {
  final QueryDocumentSnapshot product;
  final VoidCallback onTap;

  ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                product['image'],
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(product['name'], style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Text('${product['price']} ريال'),
          ],
        ),
      ),
    );
  }
}
