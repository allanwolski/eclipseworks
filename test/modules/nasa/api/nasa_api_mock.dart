import 'package:eclipseworks/modules/nasa/api/nasa_api.dart';
import 'package:eclipseworks/modules/nasa/models/apod.dart';

import '../models/apod_mock.dart';

class NasaApiMock implements NasaApi {
  @override
  Future<Apod> getAstronomyPictureOfDay(DateTime date) async {
    return apodMock;
  }
}
