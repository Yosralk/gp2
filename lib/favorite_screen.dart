import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouritePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) return Center(child: Text('يرجى تسجيل الدخول'));
    final favRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('favorites');
    return Scaffold(
      appBar: AppBar(
        title: Text('المفضلة'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: favRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final favDocs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: favDocs.length,
            itemBuilder: (context, index) {
              final fav = favDocs[index];
              return ListTile(
                title: Text(fav.id),
                // يمكنكِ جلب تفاصيل المنتج من مجموعة 'products' باستخدام fav.id
              );
            },
          );
        },
      ),
    );
  }
}