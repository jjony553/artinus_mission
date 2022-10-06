import 'package:artinus_mission/screens/home_screen.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String passwordResult;
  const ResultScreen({super.key, required this.passwordResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomeScreen()),
                  (route) => false);
            },
          )),
      body: Container(
          color: Colors.white,
          child: Center(
              child: Text(
            passwordResult,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ))),
    );
  }
}
