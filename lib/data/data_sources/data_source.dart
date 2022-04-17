import 'package:dio/dio.dart';
import 'package:movie_list/models/genres_entity.dart';

abstract class DataSource<T> {

  static Dio dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3/'),
  );

  Future<List<GenresEntity>> getPopularGenres();

  Future<List<T>> getPopularMovies();

  Future<List<T>> getBestDrama();

  Future<List<T>> getPopularArtists();

  Future<List<T>> searchMovies({required String searchKeyword});
}

class HttpClient {
  static Dio instance = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3/'),
  );
}


