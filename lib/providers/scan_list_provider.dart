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

    if (this.tipoSeleccionado == scanModel.tipo) {
      this.scans.add(scanModel);
      notifyListeners();
    }
  }

  cargarScans() async {
    List<ScanModel> scans = await DBProvider.db.getScans();
    this.scans = [...scans];

    notifyListeners();
  }

  cargarScansPorTipo(String tipo) {}

  borrarTodos() {}
}
