import 'dart:async';
import 'dart:io';

import 'package:sembast/sembast_io.dart';

abstract class StorageClient {
  Database get db => Storage.instance.db;
}

class Storage {
  Storage._();
  late Database db;

  static final Storage _instance = Storage._();
  static Storage get instance => _instance;

  Future<void> init() async {
    db = await _openDatabase();
  }

  Future<Database> _openDatabase() async {
    final dbPath = '${Directory.systemTemp.path}/app.db';
    return databaseFactoryIo.openDatabase(dbPath).catchError((e) {
      databaseFactoryIo.deleteDatabase(dbPath);
      return _openDatabase();
    });
  }
}
