import 'package:dio/dio.dart';
import 'package:movie_list/models/genres_entity.dart';

import '../../../common/constants.dart';

abstract class IGenreDataSource {
  Future<List<GenreEntity>> getPopularGenres();
}

String getPopularGenresPath = 'genre/movie/list?api_key=' + Constants.apiKey;

class GenreDataSource implements IGenreDataSource {
  final Dio httpClient;

  GenreDataSource(this.httpClient);

  @override
  Future<List<GenreEntity>> getPopularGenres() async {
    final response = await httpClient.get(getPopularGenresPath);
    final List<GenreEntity> allGenres = [];

    final initialResponse = GenresResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.genresList)) {
      allGenres.add(GenreEntity.fromJson(element));
    }

    return allGenres;
  }
}
