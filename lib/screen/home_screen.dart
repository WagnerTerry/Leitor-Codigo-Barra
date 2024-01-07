import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  // Controlador para o campo de texto
  final TextEditingController _numeroController = TextEditingController();

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _numeroController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Digite os números da nota'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: () {
                    print("numero digitado ${_numeroController.text}");
                  },
                  child: const Text('Processar número'))
            ],
          ),
        ));
  }
}
