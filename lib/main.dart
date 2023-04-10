import 'package:flutter/material.dart';
import 'splashscreen.dart';
import 'defaultscreen.dart';
import 'emailscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

