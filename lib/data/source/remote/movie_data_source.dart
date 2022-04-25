import 'package:dio/dio.dart';
import 'package:movie_list/models/movie_entity.dart';

import '../../../common/constants.dart';

abstract class IMovieDataSource{
  Future<List<MovieEntity>> getPopularMovies();
  Future<List<MovieEntity>> getBestDrama();
}

String getPopularMoviesPath = 'movie/now_playing?api_key=' + Constants.apiKey;
String getBestDramaPath = 'discover/movie?with_genres=18&api_key=' + Constants.apiKey;


class MovieDataSource implements IMovieDataSource{

  final Dio httpClient;

  MovieDataSource(this.httpClient);

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    final response = await httpClient.get(getPopularMoviesPath);
    final List<MovieEntity> allMovies = [];

    final initialResponse = MovieResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.moviesList)) {
      allMovies.add(MovieEntity.fromJson(element));
    }

    return allMovies;
  }

  @override
  Future<List<MovieEntity>> getBestDrama() async{
    final response = await httpClient.get(getBestDramaPath);
    final List<MovieEntity> allMovies = [];

    final initialResponse = MovieResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.moviesList)) {
      allMovies.add(MovieEntity.fromJson(element));
    }

    return allMovies;
  }
}
