import 'dart:async';
import 'package:flutter/material.dart';
import 'mainscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => const MainScreen(
                      title: '',
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/movies.png'),
                  fit: BoxFit.cover))),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Text(
              "myMovies",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            CircularProgressIndicator(),
            Text("Version 0.1")
          ],
        ),
      )
    ]);
  }
}
