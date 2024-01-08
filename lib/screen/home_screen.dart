import 'package:flutter/material.dart';
import 'package:leitor_codigo_de_barra/utils/disposeHandler.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controlador para o campo de texto
  final TextEditingController _numeroController = TextEditingController();
  final DisposeHandler disposeHandler = DisposeHandler();
  List<int> numerosDigitados = [];

  void _ordenarNumero() {
    int numeroDigitado = int.tryParse(_numeroController.text) ?? 0;
    print(numeroDigitado.runtimeType);

    setState(() {
      numerosDigitados.add(numeroDigitado);
      // numerosDigitados.sort((a, b) => a.compareTo(b));
    });

    print(numerosDigitados);
  }

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
            mainAxisAlignment: MainAxisAlignment.start,
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
                    _ordenarNumero();
                  },
                  child: const Text('Processar número')),
              const SizedBox(height: 16),
              Text("Números Digitados: ${numerosDigitados.join(", ")}")
            ],
          ),
        ));
  }

  // chamada dispose na pasta utils
  @override
  void dispose() {
    disposeHandler.disposeTextController(_numeroController);
    super.dispose();
  }

  // chamada dispose direta
  // @override
  // void dispose() {
  //   // Descartar o controlador quando não for mais necessário
  //   _numeroController.dispose();
  //   super.dispose();
  // }
}
