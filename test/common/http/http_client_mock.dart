import 'package:dio/dio.dart';
import 'package:eclipseworks/common/http/http_client.dart';
import 'package:mocktail/mocktail.dart';

class HttpClientMock extends Mock implements HttpClient {
  @override
  Interceptors get interceptors => Interceptors();
}
