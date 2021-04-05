// Singleton

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;

  // Constructor privado
  static final DBProvider db = DBProvider._();
  DBProvider._();

  get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();

    return _database;
  }

  Future<Database> initDB() async {
    // pathd de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // crear base de datos
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT
            )
          ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    final Database db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans(id, tipo, valor)
      VALUES($id, '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final Database db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());

    // ID del ultimo registro insertado
    // print(res);
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final Database db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    if (res.isEmpty) {
      return null;
    }

    return ScanModel.fromJson(res.first);
  }

  Future<List<ScanModel>> getScans() async {
    final Database db = await database;
    final res = await db.query('Scans');

    if (res.isEmpty) {
      return [];
    }

    return res.map((scn) => ScanModel.fromJson(scn)).toList();
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final Database db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    if (res.isEmpty) {
      return [];
    }

    return res.map((scn) => ScanModel.fromJson(scn)).toList();
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final Database db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int> deleteScan(int id) async {
    final Database db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);

    return res;
  }
}
