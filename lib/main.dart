import 'package:flutter/material.dart';
import 'package:flutter_application_1/grid.dart';

void main() {
  runApp(const MyApp());
}

var mult = 1;

class MyButton extends StatelessWidget {
  final Widget child;

  const MyButton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        const snackBar = SnackBar(content: Text('Tap'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        mult = mult * 10;
      },
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Grid List';
    

    return MaterialApp(
      
      home: MyGrid());
  }
}
