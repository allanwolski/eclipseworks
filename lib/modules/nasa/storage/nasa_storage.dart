import 'dart:convert';

import 'package:sembast/sembast.dart';

import '../../../common/storage/storage.dart';
import '../models/apod.dart';

abstract class NasaStorage {
  Future<List<Apod>> retrieveFavorites();
  Future<void> storeFavorites(List<Apod> favorites);
}

class NasaStorageImpl implements NasaStorage {
  final Storage storage;
  final _store = StoreRef<String, String>('nasa');

  NasaStorageImpl(this.storage);

  @override
  Future<List<Apod>> retrieveFavorites() async {
    var db = await storage.db;
    var record = await _store.record('favorites').get(db);
    if (record == null) return [];
    return List<Apod>.from(
      jsonDecode(record).map((e) => Apod.fromJson(e)),
    );
  }

  @override
  Future<void> storeFavorites(List<Apod> favorites) async {
    var db = await storage.db;
    await _store.record('favorites').put(db, jsonEncode(favorites));
  }
}
