import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        // https://www.qrcode.es/es/generador-qr-code/
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        // '#3D8BEF', 'Cancelar', false, ScanMode.QR);

        // String barcodeScanRes = 'https://www.cetys.mx/';
        String barcodeScanRes = 'geo:32.653430,-115.406609';

        if (barcodeScanRes == '-1') {
          return;
        }

        // print(barcodeScanRes);

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);

        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchURL(context, nuevoScan);
      },
    );
  }
}
