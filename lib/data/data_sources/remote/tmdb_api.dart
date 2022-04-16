import 'package:movie_list/data/data_sources/data_source.dart';
import 'package:movie_list/models/genres_entity.dart';

import '../../../models/movie_entity.dart';

String apiKey = 'b0abba018d32248e292a0ba14df1f07b';

class TmdbAPI implements DataSource<MovieEntity> {
  String getPopularMoviesPath = 'discover/movie?sort_by=popularity.desc&api_key=' + apiKey;
  String getPopularGenresPath = 'genre/movie/list?api_key=' + apiKey;

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    final response = await HttpClient.instance.get(getPopularMoviesPath);
    final List<MovieEntity> allMovies = [];

    final initialResponse = MovieResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.moviesList)) {
      allMovies.add(MovieEntity.fromJson(element));
    }

    return allMovies;
  }

  @override
  Future<List<GenresEntity>> getPopularGenres() async {
    final response = await HttpClient.instance.get(getPopularGenresPath);
    final List<GenresEntity> allGenres = [];

    final initialResponse = GenresResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.genresList)) {
      allGenres.add(GenresEntity.fromJson(element));
    }

    return allGenres;
  }

  @override
  Future<List<MovieEntity>> searchMovies({required String searchKeyword}) {
    // TODO: implement getPopularGenres
    throw UnimplementedError();
  }
}
