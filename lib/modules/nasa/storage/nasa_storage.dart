import 'dart:convert';

import '../../../common/storage/storage.dart';
import '../models/apod.dart';

abstract class NasaStorage {
  Future<List<Apod>> retrieveFavorites();
  Future<void> storeFavorites(List<Apod> favorites);
}

class NasaStorageImpl implements NasaStorage {
  final Storage storage;
  const NasaStorageImpl(this.storage);

  @override
  Future<List<Apod>> retrieveFavorites() async {
    var record = await storage.getString('favorites');
    if (record == null) return [];
    return List<Apod>.from(
      jsonDecode(record).map((e) => Apod.fromJson(e)),
    );
  }

  @override
  Future<void> storeFavorites(List<Apod> favorites) async {
    await storage.putString('favorites', jsonEncode(favorites));
  }
}
