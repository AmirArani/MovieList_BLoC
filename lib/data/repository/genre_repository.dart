import 'package:movie_list/models/genres_entity.dart';

import '../../../common/http_client.dart';
import '../source/remote/genres_data_source.dart';

final genreRepository = GenreRepository(GenreDataSource(httpClient));

abstract class IGenreRepository {
  Future<List<GenresEntity>> getPopularGenres();
}

class GenreRepository implements IGenreRepository {
  final IGenreDataSource dataSource;

  GenreRepository(this.dataSource);

  @override
  Future<List<GenresEntity>> getPopularGenres() {
    return dataSource.getPopularGenres();
  }
}
