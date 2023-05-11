import 'package:flutter/material.dart';
import 'package:seosuri_fe/testcheck.dart';
import 'emailscreen.dart';
import 'camerascreen.dart';
import 'splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Seosuri',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: TextTheme(
            bodyLarge: TextStyle(
              //fontFamily: ,
            )
          ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                fontSize: 19,
                // fontFamily: 'YourFontFamily' 원하는 글꼴 찾아 넣기
              )
          )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/email': (context) => EmailScreen(),
        '/camera': (context) => CameraScreen(),
        //'/check' : (context) => CheckScreen(data: data),
        '/test' : (context) => TestCheckScreen(),
        //'/testcor' : (context) => TestCorrectionScreen(selectedData: selectedData),
      },
    );
  }
}