import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "404 - Page Not Found",
          style: TextStyle(
            color: Colors.white,
            backgroundColor: Colors.red,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
