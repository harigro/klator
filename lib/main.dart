import 'package:flutter/material.dart';
import 'screen/kalkulator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 600, // Set the width you desire
            height: 600, // Set the height you desire
            decoration: BoxDecoration(
              color: Colors.white, // Optional: set the background color
              border: Border.all(color: Colors.black), // Optional: add a border
              borderRadius: BorderRadius.circular(12), // Optional: round the corners
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: KalkulatorScreen(),
          ),
        ),
      ),
    );
  }
}
