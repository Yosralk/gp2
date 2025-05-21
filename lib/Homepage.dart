import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  void addToFavorites(String productId, Map<String, dynamic> product) async {
    if (user != null) {
      final favRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('favorites');
      await favRef.doc(productId).set(product);
    }
  }

  void addToCart(String productId, Map<String, dynamic> product) async {
    if (user != null) {
      final cartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('cart');
      await cartRef.doc(productId).set({
        ...product,
        'quantity': 1,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('المنتجات'),
        backgroundColor: Colors.blueGrey,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text('حدث خطأ في تحميل البيانات'));

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
            return Center(child: Text('لا توجد منتجات حالياً'));

          final products = snapshot.data!.docs;

          // ✅ طباعة عدد المنتجات في الكونسول
          print("Products Count: ${products.length}");

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final data = product.data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.all(10),
                elevation: 4,
                child: ListTile(
                  leading: Image.network(
                    data['image'] ?? '',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  title: Text(data['name'] ?? 'بدون اسم'),
                  subtitle: Text('${data['price']} دينار'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () => addToFavorites(product.id, data),
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () => addToCart(product.id, data),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}