import 'package:intl/intl.dart';

import '../../../common/http/http_client.dart';
import '../models/apod.dart';

abstract class NasaApi {
  Future<Apod> getAstronomyPictureOfDay(DateTime date);
}

class NasaApiImpl implements NasaApi {
  final HttpClient httpClient;
  const NasaApiImpl(this.httpClient);

  @override
  Future<Apod> getAstronomyPictureOfDay(DateTime date) async {
    final response = await httpClient.get('/planetary/apod', queryParameters: {
      'thumbs': true,
      'date': DateFormat('yyyy-MM-dd').format(date),
    });
    return Apod.fromJson(response.data);
  }
}
