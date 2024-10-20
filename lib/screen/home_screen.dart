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

    for (int i = 0; i < numeroOrdenado.length; i++) {
      String digito = numeroOrdenado[i];

      if (digito == digitoAtual) {
        contagemAtual++;
      } else {
        // Adiciona os números repetidos
        if (contagemAtual > 1) {
          // Adiciona cada repetição do número
          for (int j = 0; j < contagemAtual - 1; j++) {
            widgets
                .add(Text(digitoAtual, style: const TextStyle(fontSize: 18)));
          }
          // Adiciona o último número com a contagem abaixo
          widgets.add(Column(
            children: [
              Text(digitoAtual, style: const TextStyle(fontSize: 18)),
              Text(contagemAtual.toString(),
                  style: const TextStyle(fontSize: 12, color: Colors.red)),
            ],
          ));
        } else if (contagemAtual == 1) {
          widgets.add(Text(digitoAtual, style: const TextStyle(fontSize: 18)));
        }

        // Atualiza para o novo dígito e reseta a contagem
        digitoAtual = digito;
        contagemAtual = 1;
      }
    }

    // Adiciona o último dígito e sua contagem após o loop
    if (contagemAtual > 1) {
      for (int j = 0; j < contagemAtual - 1; j++) {
        widgets.add(Text(digitoAtual, style: TextStyle(fontSize: 18)));
      }
      widgets.add(Column(
        children: [
          Text(digitoAtual, style: const TextStyle(fontSize: 18)),
          Text(contagemAtual.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.red)),
        ],
      ));
    } else if (contagemAtual == 1) {
      widgets.add(Text(digitoAtual, style: const TextStyle(fontSize: 18)));
    }

    return Wrap(
      spacing: 4, // Espaçamento horizontal entre os números
      runSpacing: 4, // Espaçamento vertical entre as linhas
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
