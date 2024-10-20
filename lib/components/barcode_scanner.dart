import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

Future<String> scanBarcode() async {
  String barcodeScanRes;
  try {
    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", // Cor do botão de cancelamento
      "Cancelar", // Texto do botão de cancelamento
      true, // Se deve usar o modo de flash do dispositivo
      ScanMode.BARCODE, // Modo de escaneamento (QR code ou BARCODE)
    );
  } catch (e) {
    barcodeScanRes = 'Falha ao escanear o código';
  }

  return barcodeScanRes;
}
