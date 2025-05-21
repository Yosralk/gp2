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
      appBar: AppBar(
        title: Text('السلة'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: cartRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final cartDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: cartDocs.length,
            itemBuilder: (context, index) {
              final cartItem = cartDocs[index];
              return ListTile(
                title: Text(cartItem.id),
                subtitle: Text('الكمية: ${cartItem['quantity']}'),
                // يمكنكِ جلب تفاصيل المنتج من مجموعة 'products' باستخدام cartItem.id
              );
            },
          );
        },
      ),
    );
  }
}