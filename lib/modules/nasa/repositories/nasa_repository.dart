import '../api/nasa_api.dart';
import '../models/apod.dart';

class NasaRepository {
  final NasaApi api;
  NasaRepository(this.api);

  Future<Apod> getAstronomyPictureOfDay({DateTime? date}) {
    return api.getAstronomyPictureOfDay(date ?? DateTime.now());
  }
}
