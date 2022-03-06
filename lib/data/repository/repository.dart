import 'package:movie_list/data/data_sources/data_source.dart';

class Repository <T> implements DataSource{

  final DataSource<T> tmdb;
  // final DataSource<T> local;

  Repository(this.tmdb);

  @override
  Future<List> getAllMovies() {
    return tmdb.getAllMovies();
  }

  @override
  Future<List> searchMovies({required String searchKeyword}) {
    return tmdb.searchMovies(searchKeyword: searchKeyword);
  }

}