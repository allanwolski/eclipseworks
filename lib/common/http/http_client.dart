import 'dart:developer';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:http_cache_sembast_store/http_cache_sembast_store.dart';

class HttpClient with DioMixin {
  HttpClient() {
    options = BaseOptions(
      baseUrl: 'https://api.nasa.gov',
      contentType: 'application/json; charset=utf-8',
      queryParameters: {
        'api_key': '8XWPbIfyVnpM2YaIwLvEusinBQhmRQnsnBK4f5zS',
      },
    );

    httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        return io.HttpClient()
          ..badCertificateCallback = (cert, host, port) {
            return host == 'api.nasa.gov';
          };
      },
    );

    final cacheOptions = CacheOptions(
      store: SembastCacheStore(storePath: '${io.Directory.systemTemp.path}/cache.db'),
      policy: CachePolicy.forceCache,
    );

    interceptors.add(
      DioCacheInterceptor(options: cacheOptions),
    );

    if (kDebugMode) {
      interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) {
          log(object.toString());
        },
      ));
    }
  }
}
