import 'package:flutter/material.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    ScanModel scanModel = ScanModel(valor: valor);
    int id = await DBProvider.db.nuevoScan(scanModel);
    scanModel.id = id;

    if (this.tipoSeleccionado == scanModel.tipo) {
      this.scans.add(scanModel);
      notifyListeners();
    }

    return scanModel;
  }

  cargarScans() async {
    List<ScanModel> scans = await DBProvider.db.getScans();
    this.scans = [...scans];

    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    List<ScanModel> scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];

    this.tipoSeleccionado = tipo;

    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScans();

    this.scans = [];
    notifyListeners();
  }

  borrarScansPorId(int id) async {
    await DBProvider.db.deleteScan(id);

    cargarScansPorTipo(this.tipoSeleccionado);
    // notifyListeners();
  }
}
