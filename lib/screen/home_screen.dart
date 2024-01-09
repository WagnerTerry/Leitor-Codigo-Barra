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
  Map<String, int> numerosRepetidos = {};
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

      // Atualizar o mapa de números repetidos
      _contarOcorrencias(numeroOrdenado);
    });

    print(numerosDigitados);
    print(numerosRepetidos);
  }

  void _contarOcorrencias(String numeroOrdenado) {
    // Limpar o mapa antes de contar as ocorrências
    numerosRepetidos.clear();

    for (int i = 0; i < numeroOrdenado.length; i++) {
      String digito = numeroOrdenado[i];
      numerosRepetidos.update(digito, (value) => value + 1, ifAbsent: () => 1);
    }
  }

  String _formatNumerosRepetidos() {
    return numerosRepetidos.entries
        .map((entry) => '${entry.key} -> repetiu ${entry.value} vezes\n')
        .join("");
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
              const SizedBox(height: 32),
              ElevatedButton(
                  onPressed: isButtonDisabled
                      ? null
                      : () {
                          _ordenarNumero();
                        },
                  child: const Text('Processar número')),
              const SizedBox(height: 32),
              Text("Números Digitados: ${numerosDigitados.join(", ")}"),
              const SizedBox(height: 16),
              Text(
                "Números repetidos: \n${_formatNumerosRepetidos()}",
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 239, 22, 6)),
              )
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
