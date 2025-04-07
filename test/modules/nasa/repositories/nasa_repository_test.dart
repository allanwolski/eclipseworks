import 'package:eclipseworks/modules/nasa/models/apod.dart';
import 'package:eclipseworks/modules/nasa/repositories/nasa_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../api/nasa_api_mock.dart';
import '../models/apod_mock.dart';

void main() {
  late NasaRepository repository;

  setUp(() {
    repository = NasaRepository(
      NasaApiMock(),
    );
  });

  test(
    'Should return a Apod when get astronomy picture of the day',
    () async {
      var response = await repository.getAstronomyPictureOfDay();
      expect(response, isA<Apod>());
      expect(response, apodMock);
    },
  );
}
