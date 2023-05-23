import 'package:flutter/material.dart';
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
            bodyText2: TextStyle(
              fontFamily: 'nanum-square',
            )
          ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                fontSize: 19,
                fontFamily: 'nanum-square',
                fontWeight: FontWeight.w600
              )
          )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/email': (context) => EmailScreen(),
        '/camera': (context) => CameraScreen(),
        //'/check' : (context) => CheckScreen(data: data),
        //'/test' : (context) => TestCheckScreen(),
        //'/testcor' : (context) => TestCorrectionScreen(selectedData: selectedData),
      },
    );
  }
}