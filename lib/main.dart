import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seosuri_fe/Models/testcheck_provider.dart';
import 'package:seosuri_fe/Models/email_provider.dart';
import 'emailscreen.dart';
import 'camerascreen.dart';
import 'splashscreen.dart';
import 'testcheck.dart';

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
        ChangeNotifierProvider<EmailProvider>(
          create: (_) => EmailProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Seosuri',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          textTheme: TextTheme(
            bodyText2: TextStyle(
              fontFamily: 'nanum-square',
            ),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 19,
              fontFamily: 'nanum-square',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/email': (context) => EmailScreen(),
          '/camera': (context) => CameraScreen(),
          //'/check': (context) => CheckScreen(),
          '/testcheck': (context) => TestCheckScreen(categoryTitle: 'categotyTitle', level: 'level'),
          //'/testcor' : (context) => TestCorrectionScreen(selectedData: selectedData),
        },
      ),
    );
  }
}
