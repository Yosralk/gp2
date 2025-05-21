import 'Homepage.dart';
import 'cart_screen.dart';
import 'favorite_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
TextEditingController addController = TextEditingController();
class nanvClass extends StatefulWidget {
  const nanvClass({super.key});

  @override
  State<nanvClass> createState() => _nanvClassState();
}

FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
CollectionReference products=firebaseFirestore.collection('Products');
addTask(String name){
  products.add({
    'productName':name,
    'Price':'200JD',
    'image':'imageURL',
    'Details':'hp and any thing',
    'ststus':'false'
  });
}
class _nanvClassState extends State<nanvClass> {
  List<Widget> pages = [
    HomePage(),
    CartPage(),
    FavouritePage(),
    ProfileScreen()
  ];
  int indexPage = 0;
  TextEditingController addController = TextEditingController();
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: indexPage,
        children: pages,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        activeIndex: indexPage,
        activeColor: Colors.blue,
        gapLocation: GapLocation.center,
        inactiveColor: Colors.black.withOpacity(0.5),
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        icons: [
          Icons.home,
          Icons.shopping_cart_checkout_rounded,
          Icons.favorite,
          Icons.person,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // هذا هو المكان الصحيح لاستدعاء showDialog عند الضغط على الزر
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("add your product"),
                  content: TextField(
                    controller: addController,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            addTask(addController.text);
                            //  addController.clear();
                          });
                          Navigator.pop(context);
                        },
                        child: Text("Add")),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"))
                  ],
                );
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
