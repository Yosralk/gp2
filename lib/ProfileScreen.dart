import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = user?.displayName ?? '';
    emailController.text = user?.email ?? '';
  }

  void updateProfile() async {
    try {
      await user?.updateDisplayName(nameController.text);
      await user?.reload();
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم التحديث')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ في التحديث')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الملف الشخصي')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'الاسم')),
            TextField(controller: emailController, readOnly: true, decoration: InputDecoration(labelText: 'البريد')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: updateProfile, child: Text('تحديث')),
          ],
        ),
      ),
    );
  }
}
