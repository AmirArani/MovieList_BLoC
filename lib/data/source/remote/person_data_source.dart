import 'package:dio/dio.dart';

import '../../../common/constants.dart';
import '../../../models/movie_entity.dart';
import '../../../models/person_entity.dart';
import '../../../models/tv_show_entity.dart';

String getPopularArtistsPath = 'person/popular?api_key=' + Constants.apiKey;

abstract class IPersonDataSource {
  Future<List<PersonEntity>> getPopularArtists();
  Future<PersonDetailEntity> getPersonDetail({required int id});
  Future<List<MovieEntity>> getCreditMovies({required int id});
  Future<List<TvShowEntity>> getCreditTvShows({required int id});
  Future<List<String>> getImages({required int id});
}

class PersonDataSource implements IPersonDataSource {
  final Dio httpClient;
  PersonDataSource(this.httpClient);

  @override
  Future<List<PersonEntity>> getPopularArtists() async {
    final response = await httpClient.get(getPopularArtistsPath);
    final List<PersonEntity> allArtists = [];

    final initialResponse = PersonResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.personList)) {
      if (element['profile_path'] != null) {
        allArtists.add(PersonEntity.fromJson(element));
      }
    }

    return allArtists;
  }

  @override
  Future<PersonDetailEntity> getPersonDetail({required int id}) async {
    //TODO: TEST
    String getPersonDetailPath = 'person/$id+?api_key=' + Constants.apiKey;
    final response = await httpClient.get(getPersonDetailPath);
    final PersonDetailEntity detail;

    detail = PersonDetailEntity.fromJson(response.data);

    return detail;
  }

  @override
  Future<List<MovieEntity>> getCreditMovies({required int id}) async {
    //TODO: TEST

    String getCreditMoviesPath =
        'person/$id/movie_credits+?api_key=' + Constants.apiKey;
    final response = await httpClient.get(getCreditMoviesPath);
    final List<MovieEntity> movies = [];

    for (var movie in (response.data['results'])) {
      movies.add(MovieEntity.fromJson(movie));
    }

    return movies;
  }

  @override
  Future<List<TvShowEntity>> getCreditTvShows({required int id}) async {
    //TODO: TEST
    String getCreditTvShowsPath =
        'person/$id/movie_credits+?api_key=' + Constants.apiKey;
    final response = await httpClient.get(getCreditTvShowsPath);
    final List<TvShowEntity> shows = [];

    for (var show in (response.data['results'])) {
      shows.add(TvShowEntity.fromJson(show));
    }

    return shows;
  }

  @override
  Future<List<String>> getImages({required int id}) async {
    //TODO: TEST
    String getPersonImages = 'person/$id/images?api_key=' + Constants.apiKey;
    final response = await httpClient.get(getPersonImages);
    final List<String> images = [];

    for (var image in (response.data['profiles'])) {
      images.add(image['file_path']);
      if (images.length == 25) break;
    }

    return images;
  }
}
