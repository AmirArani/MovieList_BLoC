import 'package:movie_list/data/source/remote/movie_data_source.dart';

import '../../common/http_client.dart';
import '../../models/movie_entity.dart';

final movieRepository = MovieRepository(MovieDataSource(httpClient));

abstract class IMovieRepository {
  Future<List<MovieEntity>> getPopularMovies();
  Future<List<MovieEntity>> getBestDrama();
  Future<List<MovieEntity>> searchMovies({required String searchKeyword});
}

class MovieRepository implements IMovieRepository {
  final IMovieDataSource dataSource;

  MovieRepository(this.dataSource);

  @override
  Future<List<MovieEntity>> getBestDrama() {
    return dataSource.getBestDrama();
  }

  @override
  Future<List<MovieEntity>> getPopularMovies() {
    return dataSource.getPopularMovies();
  }

  @override
  Future<List<MovieEntity>> searchMovies({required String searchKeyword}) {
    return dataSource.searchMovies(searchKeyword: searchKeyword);
  }

}
