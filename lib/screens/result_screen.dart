import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String passwordResult;
  const ResultScreen({super.key, required this.passwordResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black54,
        ),
        onPressed: () {
          //홈으로 이동
        },
      )),
      body: Container(
          color: Colors.white,
          child: Center(
              child: Text(
            passwordResult,
            style: TextStyle(fontWeight: FontWeight.bold),
          ))),
    );
  }
}
