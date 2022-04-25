import 'package:dio/dio.dart';
import 'package:movie_list/models/genres_entity.dart';

import '../../../common/constants.dart';

abstract class IGenreDataSource {
  Future<List<GenresEntity>> getPopularGenres();
}

String getPopularGenresPath = 'genre/movie/list?api_key=' + Constants.apiKey;

class GenreDataSource implements IGenreDataSource {
  final Dio httpClient;

  GenreDataSource(this.httpClient);

  @override
  Future<List<GenresEntity>> getPopularGenres() async {
    final response = await httpClient.get(getPopularGenresPath);
    final List<GenresEntity> allGenres = [];

    final initialResponse = GenresResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.genresList)) {
      allGenres.add(GenresEntity.fromJson(element));
    }

    return allGenres;
  }
}
