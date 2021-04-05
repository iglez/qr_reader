import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async {
    ScanModel scanModel = ScanModel(valor: valor);
    int id = await DBProvider.db.nuevoScan(scanModel);
    scanModel.id = id;

    this.scans.add(scanModel);
    notifyListeners();
  }
}