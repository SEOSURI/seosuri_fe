import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Models/testcheck_provider.dart';
import 'emailscreen.dart';
import 'camerascreen.dart';
import 'splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TestCheckProvider>(
          create: (_) => TestCheckProvider(),
        ),
      ],
      child: MaterialApp(
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
          //'/check': (context) => CheckScreen(),
          //'/test': (context) => TestCheckScreen(),
          //'/testcor' : (context) => TestCorrectionScreen(selectedData: selectedData),
        },
      ),
    );
  }
}