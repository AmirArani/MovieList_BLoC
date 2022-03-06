import 'package:movie_list/data/data_sources/data_source.dart';

import '../../../models/movie_entity.dart';

class TmdbAPI implements DataSource<MovieEntity>{

  // TODO: call API here

  @override
  Future<List<MovieEntity>> getAllMovies() {
    // TODO: implement getAllMovies
    throw UnimplementedError();
  }

  @override
  Future<List<MovieEntity>> searchMovies({required String searchKeyword}) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }


}

