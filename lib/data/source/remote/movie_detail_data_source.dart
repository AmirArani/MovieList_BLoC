import 'package:dio/dio.dart';
import 'package:movie_list/common/constants.dart';

import '../../../models/movie_details_entity.dart';

abstract class IMovieDetailDataSource {
  Future<MovieDetailEntity> getMovieDetail({required int id});
}

class MovieDetailDataSource implements IMovieDetailDataSource {
  final Dio httpClient;

  MovieDetailDataSource(this.httpClient);

  @override
  Future<MovieDetailEntity> getMovieDetail({required int id}) async {
    String getMovieDetail = 'movie/$id?api_key=' + Constants.apiKey;

    final response = await httpClient.get(getMovieDetail);
    final MovieDetailEntity movieDetail;

    movieDetail = MovieDetailEntity.fromJson(response.data);

    return movieDetail;
  }
}
