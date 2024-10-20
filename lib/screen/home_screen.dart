import 'package:flutter/material.dart';
import '../components/barcode_scanner.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _numeroController = TextEditingController();
  List<String> numerosDigitados = [];

  void _ordenarNumero(String numeroDigitado) {
    List<String> listaDeDigitos = numeroDigitado.split('');
    String numeroOrdenado = listaDeDigitos.join();

    setState(() {
      if (numerosDigitados.isNotEmpty) {
        numerosDigitados[numerosDigitados.length - 1] = numeroOrdenado;
      } else {
        numerosDigitados.add(numeroOrdenado);
      }
    });
  }

  void _scanAndProcessBarcode() async {
    String barcodeScanRes = await scanBarcode();
    if (barcodeScanRes != '-1') {
      _ordenarNumero(barcodeScanRes);
    }
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
        if (contagemAtual > 1) {
          for (int j = 0; j < contagemAtual - 1; j++) {
            widgets
                .add(Text(digitoAtual, style: const TextStyle(fontSize: 18)));
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

        digitoAtual = digito;
        contagemAtual = 1;
      }
    }

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
      spacing: 4,
      runSpacing: 4,
      alignment: WrapAlignment.center,
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
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _ordenarNumero(_numeroController.text);
              },
              child: const Text('Processar número'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _scanAndProcessBarcode,
              child: const Text('Ler Código de Barras'),
            ),
            const SizedBox(height: 32),
            const Text("Números Digitados:"),
            const SizedBox(height: 8),
            _buildNumeroSequencial(numerosDigitados.join()),
          ],
        ),
      ),
    );
  }
}
