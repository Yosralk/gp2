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
      appBar: AppBar(title: Text('المفضلة')),
      body: StreamBuilder<QuerySnapshot>(
        stream: favRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final favDocs = snapshot.data!.docs;

          if (favDocs.isEmpty) return Center(child: Text("لا يوجد منتجات في المفضلة"));

          return ListView.builder(
            itemCount: favDocs.length,
            itemBuilder: (context, index) {
              final fav = favDocs[index];
              final data = fav.data() as Map<String, dynamic>;

              return ListTile(
                leading: Image.network(data['image'], width: 50, height: 50, fit: BoxFit.cover),
                title: Text(data['name']),
                subtitle: Text('${data['price']} دينار'),
              );
            },
          );
        },
      ),
    );
  }
}