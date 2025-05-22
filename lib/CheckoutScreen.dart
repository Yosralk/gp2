import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckoutScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  Future<double> calculateTotal() async {
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart');

    final snapshot = await cartRef.get();
    double total = 0.0;

    for (var doc in snapshot.docs) {
      final data = doc.data();
      total += (data['price'] ?? 0) * (data['quantity'] ?? 1);
    }

    return total;
  }

  Future<void> placeOrder(BuildContext context) async {
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('cart');

    final snapshot = await cartRef.get();

    if (snapshot.docs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('السلة فارغة')),
      );
      return;
    }

    final orderData = {
      'items': snapshot.docs.map((doc) => doc.data()).toList(),
      'timestamp': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('orders')
        .add(orderData);

    // إفراغ السلة بعد الطلب
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم إرسال الطلب بنجاح')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الدفع')),
      body: FutureBuilder<double>(
        future: calculateTotal(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final total = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('المبلغ الإجمالي: $total دينار', style: TextStyle(fontSize: 22)),
                SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: Icon(Icons.payment),
                  label: Text('إتمام الدفع'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () => placeOrder(context),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}