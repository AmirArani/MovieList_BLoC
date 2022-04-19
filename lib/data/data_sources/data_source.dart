import 'package:dio/dio.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/person_entity.dart';
import 'package:movie_list/models/tv_show_entity.dart';

abstract class DataSource<T> {

  static Dio dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3/'),
  );

  Future<List<GenresEntity>> getPopularGenres();

  Future<List<T>> getPopularMovies();

  Future<TvShowDetailEntity> getLatestFeaturedEpisode();

  Future<List<T>> getBestDrama();

  Future<List<PersonEntity>> getPopularArtists();

  Future<List<TvShowDetailEntity>> getTopTvShows();

  Future<List<T>> searchMovies({required String searchKeyword});
}

class HttpClient {
  static Dio instance = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3/'),
  );
}


