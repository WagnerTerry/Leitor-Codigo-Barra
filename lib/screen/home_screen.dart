import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _numeroController = TextEditingController();
  List<String> numerosDigitados = [];

  void _ordenarNumero() {
    String numeroDigitado = _numeroController.text;

    List<String> listaDeDigitos = numeroDigitado.split('');
    String numeroOrdenado = listaDeDigitos.join();

    setState(() {
      if (numerosDigitados.isNotEmpty) {
        numerosDigitados[numerosDigitados.length - 1] = numeroOrdenado;
      } else {
        numerosDigitados.add(numeroOrdenado);
      }
    });

    // print(numerosDigitados);
  }

  Wrap _buildNumeroSequencial(String numeroOrdenado) {
    List<Widget> widgets = [];

    String digitoAtual = '';
    int contagemAtual = 0;
    List lista = [];

    for (int i = 0; i < numeroOrdenado.length; i++) {
      String digito = numeroOrdenado[i];

      if (digito == digitoAtual) {
        contagemAtual++;
        lista.add(digito);
      } else {
        lista.add(0);
        digitoAtual = digito;
        contagemAtual = 1;
      }

      if (contagemAtual > 1) {
        widgets.add(Column(
          children: [
            Text(digito,
                style: TextStyle(
                    fontSize:
                        18)), // Ajuste o tamanho da fonte conforme necessário
            SizedBox(
                height:
                    4), // Adiciona um espaçamento entre o número original e o indicador
            Text(contagemAtual.toString(), style: TextStyle(fontSize: 12)),
          ],
        ));
      } else {
        widgets.add(Text(digito,
            style: TextStyle(
                fontSize:
                    18))); // Ajuste o tamanho da fonte conforme necessário
      }
      print("lista $lista");
    }

    // -----------

    //   for (int i = 0; i < numeroOrdenado.length; i++) {
    //   String digito = numeroOrdenado[i];

    //   if (digito == digitoAtual) {
    //     contagemAtual++;
    //     lista.add(digito);
    //   } else {
    //     lista.add(0);
    //     digitoAtual = digito;
    //     contagemAtual = 1;
    //   }

    //   if (contagemAtual > 1) {
    //     widgets.add(Column(
    //       children: [
    //         Text(digito,
    //             style: TextStyle(
    //                 fontSize:
    //                     18)), // Ajuste o tamanho da fonte conforme necessário
    //         SizedBox(
    //             height:
    //                 4), // Adiciona um espaçamento entre o número original e o indicador
    //         Text(contagemAtual.toString(), style: TextStyle(fontSize: 12)),
    //       ],
    //     ));
    //   } else {
    //     widgets.add(Text(digito,
    //         style: TextStyle(
    //             fontSize:
    //                 18))); // Ajuste o tamanho da fonte conforme necessário
    //   }
    // }

    return Wrap(
      spacing: 4, // Adiciona um espaçamento horizontal entre os números
      runSpacing: 4, // Adiciona um espaçamento vertical entre as linhas
      alignment: WrapAlignment.center, // Centraliza os elementos
      children: widgets,
    );
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
                labelText: 'Digite os números da nota',
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                _ordenarNumero();
              },
              child: const Text('Processar número'),
            ),
            const SizedBox(height: 32),
            Text("Números Digitados:"),
            const SizedBox(height: 8),
            _buildNumeroSequencial(numerosDigitados.join()),
          ],
        ),
      ),
    );
  }
}
