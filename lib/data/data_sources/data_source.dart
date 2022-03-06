import 'package:dio/dio.dart';

abstract class DataSource<T> {

  static Dio dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3/'),
  );

  Future<List<T>> getAllMovies();

  Future<List<T>> searchMovies({required String searchKeyword});
}

class HttpClient {
  static Dio instance = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3/'),
  );
}


