// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_core/core/data/abstract/network/response_body_printer_interceptor.dart';

Future<Dio> createAuthorizedHttpClient(String baseUrl) async {
  Dio dio = Dio();
  dio.options.baseUrl = baseUrl;
  dio.options.connectTimeout = 80000;
  dio.options.receiveTimeout = 50000;

  dio.interceptors
    ..add(LogInterceptor(requestBody: true))
    ..add(ResponseBodyPrinterInterceptor());

  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  };

  return dio;
}
