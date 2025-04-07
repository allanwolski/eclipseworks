import 'dart:async';
import 'dart:io';

import 'package:sembast/sembast_io.dart';

class Storage {
  late final Future<Database> db;
  final store = StoreRef<String, String>('store');

  Storage() {
    db = _openDatabase();
  }

  Future<String?> getString(String key) async {
    return store.record(key).get(await db);
  }

  Future<String?> putString(String key, String value) async {
    return store.record(key).put(await db, value);
  }

  Future<Database> _openDatabase() {
    final dbPath = '${Directory.systemTemp.path}/app.db';
    return databaseFactoryIo.openDatabase(dbPath).catchError((e) {
      databaseFactoryIo.deleteDatabase(dbPath);
      return _openDatabase();
    });
  }
}
