import 'package:dio/dio.dart';
import 'package:movie_list/common/constants.dart';
import 'package:movie_list/models/cast&crew_entity.dart';

import '../../../models/movie_details_entity.dart';

abstract class IMovieDetailDataSource {
  Future<MovieDetailEntity> getMovieDetail({required int id});
  Future<MovieBackdropEntity> getMovieBackdrop({required int id});
  Future<List<String>> getImages({required int id});
  Future<CastAndCrewEntity> getCastAndCrew({required int id});
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
      if (images.length == 25) break;
    }

    return images;
  }

  @override
  Future<CastAndCrewEntity> getCastAndCrew({required int id}) async {
    String getCastAndCrewPath = 'movie/$id/credits?api_key=' + Constants.apiKey;
    final response = await httpClient.get(getCastAndCrewPath);
    final List<CastEntity> casts = [];
    final List<CrewEntity> crews = [];

    for (var cast in (response.data['cast'])) {
      casts.add(CastEntity.fromJsom(cast));
    }

    for (var crew in (response.data['crew'])) {
      crew.add(CrewEntity.fromJsom(crew));
    }

    return CastAndCrewEntity(cast: casts, crew: crews);
  }
}
