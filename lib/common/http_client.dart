import 'package:dio/dio.dart';

final httpClient = Dio(
  BaseOptions(baseUrl: 'https://api.themoviedb.org/3/'),
);
