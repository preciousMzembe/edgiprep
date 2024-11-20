import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

Dio createDio() {
  var dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
  return dio;
}
