import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseAuth auth_instance=FirebaseAuth.instance;

class AuthServicess{
  final TextEditingController controllerName = TextEditingController();//new
  static Future<AuthProcess> register(String email, String pass,String Fullname) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      CollectionReference users = FirebaseFirestore.instance.collection('users');

      users.doc(credential.user!.uid)
          .set({
        'full_name':Fullname,
        'age': 18
      })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));


    } on FirebaseAuthException catch (e) {
      String msg="error-happend";
      if (e.code == 'weak-password') {
        msg="The password provided is too weak.";


      } else if (e.code == 'email-already-in-use') {
        msg='The account already exists for that email.';
      }
      else if(e.code=='invalid-email'){
        msg='invalid-email';
      }
      return AuthProcess(isValid: false,errorMsg: msg);
      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg),backgroundColor: Colors.red,));

    } catch (e) {
      print(e);

      //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),backgroundColor: Colors.red,));
    }
    return AuthProcess(isValid: false,errorMsg: "Error defualt");
  }
  //authuserstate(2)
  static User? userState(){//هاي ال User? اصلا موجوده بالفيربيس مش انا الي عملته
    return FirebaseAuth.instance.currentUser;
  }
//logout
  static void LogOut(){
    FirebaseAuth.instance.signOut();
  }

}

class AuthProcess{
  bool isValid;
  String errorMsg;
  AuthProcess({required this.isValid,this.errorMsg=""});
}
Future<bool> login(String email, String pass)async{
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');

    }

  }return false;
}