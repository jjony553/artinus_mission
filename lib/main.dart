import 'package:artinus_mission/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: const Color(0xff7343a5),
            ),
      ),
      home: const HomeScreen(),
    );
  }
}
