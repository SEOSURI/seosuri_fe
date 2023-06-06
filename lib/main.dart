import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seosuri_fe/Models/testcheck_provider.dart';
import 'camerascreen.dart';
import 'splashscreen.dart';
import 'testcheck.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
          create: (_) => TestCheckProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Seosuri',
        theme: ThemeData(
          primarySwatch: createMaterialColor(Colors.black),
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
          '/camera': (context) => CameraScreen(),
          '/testcheck': (context) => TestCheckScreen(categoryTitle: 'categoryTitle', level: 'level'),
        },
      ),
    );
  }
}
