import 'package:dio/dio.dart';
import 'package:eclipseworks/modules/nasa/api/nasa_api.dart';
import 'package:eclipseworks/modules/nasa/models/apod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../common/http/http_client_mock.dart';
import '../models/apod_json_mock.dart';

void main() {
  late NasaApiImpl api;
  late HttpClientMock httpClient;

  setUp(() {
    httpClient = HttpClientMock();
    api = NasaApiImpl(httpClient);
  });

  test(
    'Should return a Apod when get astronomy picture of the day request return with success',
    () async {
      when(
        () => httpClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          data: apodResponseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: 'any_path'),
        ),
      );
      final response = await api.getAstronomyPictureOfDay(DateTime.now());
      expect(response, isA<Apod>());
    },
  );

  test(
    'Should throw a Exception when get astronomy picture of the day request return with error',
    () {
      when(
        () => httpClient.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          options: any(named: 'options'),
        ),
      ).thenThrow(Exception());
      final response = api.getAstronomyPictureOfDay(DateTime.now());
      expect(response, throwsA(isA<Exception>()));
    },
  );
}
