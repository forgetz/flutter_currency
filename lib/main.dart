import 'package:currency/screens/home_screen.dart';
import 'package:currency/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Current Cenverter',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(
        splashAnimationDuration: 2,
        navigateAfterSeconds: HomeScreen(),
      ),
    );
  }
}
