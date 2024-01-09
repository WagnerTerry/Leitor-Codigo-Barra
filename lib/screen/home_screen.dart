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
  List<String> numerosDigitados = [];
  bool isButtonDisabled = true;

  void _ordenarNumero() {
    String numeroDigitado = _numeroController.text;

    List<String> listaDeDigitos = numeroDigitado.split('');
    listaDeDigitos.sort();

    String numeroOrdenado = listaDeDigitos.join();

    setState(() {
      // limpar o controlador ao pressionar botão.
      // _numeroController.clear();
      // isButtonDisabled = true;

      if (numerosDigitados.isNotEmpty) {
        // Se já existir algum número na lista, substitui o último
        numerosDigitados[numerosDigitados.length - 1] = numeroOrdenado;
      } else {
        // Se a lista estiver vazia, adiciona o número ordenado
        numerosDigitados.add(numeroOrdenado);
      }
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
                onChanged: (value) {
                  setState(() {
                    isButtonDisabled = value.length <= 3;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: 'Digite os números da nota'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                  onPressed: isButtonDisabled
                      ? null
                      : () {
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
