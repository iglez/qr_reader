// Singleton

import 'package:flutter/material.dart';
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
    return null;
  }

}
