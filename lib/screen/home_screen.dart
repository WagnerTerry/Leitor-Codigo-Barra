import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leitor de números repetidos',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Tela home",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
