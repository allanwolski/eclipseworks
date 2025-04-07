import 'dart:convert';

import 'package:sembast/sembast.dart';

import '../../../common/storage/storage.dart';
import '../models/apod.dart';

abstract class NasaStorage {
  Future<List<Apod>> retrieveFavorites();
  Future<void> storeFavorites(List<Apod> favorites);
}

class NasaStorageImpl extends StorageClient implements NasaStorage {
  final _store = StoreRef<String, String>('nasa');

  @override
  Future<List<Apod>> retrieveFavorites() async {
    var record = await _store.record('favorites').get(db);
    if (record == null) return [];
    return List<Apod>.from(
      jsonDecode(record).map((e) => Apod.fromJson(e)),
    );
  }

  @override
  Future<void> storeFavorites(List<Apod> favorites) async {
    await _store.record('favorites').put(db, jsonEncode(favorites));
  }
}
