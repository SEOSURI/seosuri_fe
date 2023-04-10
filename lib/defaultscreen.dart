import 'package:flutter/material.dart';
import 'emailscreen.dart';
import 'splashscreen.dart';

class defaultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('초기 화면'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('이메일 보내기'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SendEmail()),
            );
          },
        ),
      ),
    );
  }
}
