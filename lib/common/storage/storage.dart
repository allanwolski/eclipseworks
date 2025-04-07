import 'dart:async';
import 'dart:io';

import 'package:sembast/sembast_io.dart';

class Storage {
  late final Future<Database> db;

  Storage() {
    db = _openDatabase();
  }

  Future<Database> _openDatabase() {
    final dbPath = '${Directory.systemTemp.path}/app.db';
    return databaseFactoryIo.openDatabase(dbPath).catchError((e) {
      databaseFactoryIo.deleteDatabase(dbPath);
      return _openDatabase();
    });
  }
}
