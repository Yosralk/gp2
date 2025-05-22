import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartPage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) return Center(child: Text('يرجى تسجيل الدخول'));

    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart');

    return Scaffold(
      appBar: AppBar(title: Text('السلة')),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final cartDocs = snapshot.data!.docs;

          if (cartDocs.isEmpty) return Center(child: Text("السلة فارغة"));

          return ListView.builder(
            itemCount: cartDocs.length,
            itemBuilder: (context, index) {
              final item = cartDocs[index];
              final data = item.data() as Map<String, dynamic>;

              return ListTile(
                leading: Image.network(data['image'], width: 50, height: 50, fit: BoxFit.cover),
                title: Text(data['name']),
                subtitle: Text('${data['price']} دينار'),
                trailing: Text('×${data['quantity']}'),
              );
            },
          );
        },
      ),
    );
  }
}