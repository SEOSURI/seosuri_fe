import 'package:flutter/material.dart';

class defaultscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('Hello, World!'),
      ),
    );
  }
}