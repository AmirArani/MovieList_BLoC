import 'package:flutter/cupertino.dart';
import 'package:movie_list/data/data_sources/data_source.dart';

import '../../../models/movie_entity.dart';

String apiKey = 'b0abba018d32248e292a0ba14df1f07b';

class TmdbAPI implements DataSource<MovieEntity> {
  String path = 'discover/movie?sort_by=popularity.desc&api_key=' + apiKey;

  @override
  Future<List<MovieEntity>> getAllMovies() async {
    final response = await HttpClient.instance.get(path);
    final List<MovieEntity> allMovies = [];

    if (response.data is List<dynamic>) {
      (response.data as List<dynamic>).forEach((jsonObject) {
        allMovies.add(MovieEntity.fromJson(jsonObject));
      });
    }

    return allMovies;
  }

  @override
  Future<List<MovieEntity>> searchMovies({required String searchKeyword}) {
    // TODO: implement searchMovies
    throw UnimplementedError();
  }
}
