import 'package:flutter/material.dart';
import '/views/splashscreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Movies App",
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
