import 'package:dio/dio.dart';
import 'package:movie_list/common/constants.dart';

import '../../../models/movie_details_entity.dart';

abstract class IMovieDetailDataSource {
  Future<MovieDetailEntity> getMovieDetail({required int id});
  Future<MovieBackdropEntity> getMovieBackdrop({required int id});
  Future<List<String>> getImages({required int id});
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

  @override
  Future<MovieBackdropEntity> getMovieBackdrop({required int id}) async {
    String getMovieDetail = 'movie/$id?api_key=' + Constants.apiKey;
    final response = await httpClient.get(getMovieDetail);
    final MovieBackdropEntity backdrop;

    backdrop = MovieBackdropEntity.fromJson(response.data);

    return backdrop;
  }

  @override
  Future<List<String>> getImages({required int id}) async {
    String getMovieImages = 'movie/$id/images?api_key=' + Constants.apiKey;
    final response = await httpClient.get(getMovieImages);
    final List<String> images = [];
    for (var backdrop in (response.data['backdrops'])) {
      images.add(backdrop['file_path']);
    }
    for (var logo in (response.data['logos'])) {
      images.add(logo['file_path']);
    }
    for (var poster in (response.data['posters'])) {
      images.add(poster['file_path']);
    }
    return images;
  }
}
