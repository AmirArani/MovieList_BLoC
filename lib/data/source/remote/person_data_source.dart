import 'package:dio/dio.dart';

import '../../../common/constants.dart';
import '../../../models/movie_entity.dart';
import '../../../models/person_entity.dart';

String getPopularArtistsPath = 'person/popular?api_key=' + Constants.apiKey;

abstract class IPersonDataSource {
  Future<List<PersonEntity>> getPopularArtists();
  Future<PersonDetailEntity> getPersonDetail({required int id});
  Future<List<MovieEntity>> getCreditMovies({required int id});
  Future<List<MovieEntity>> getCreditTvShows({required int id});
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
    String getPersonDetailPath = 'person/$id+?api_key=' + Constants.apiKey;
    final response = await httpClient.get(getPersonDetailPath);
    final PersonDetailEntity detail;

    detail = PersonDetailEntity.fromJson(response.data);

    return detail;
  }

  @override
  Future<List<MovieEntity>> getCreditMovies({required int id}) {
    // TODO: implement getCreditMovies
    throw UnimplementedError();
  }

  @override
  Future<List<MovieEntity>> getCreditTvShows({required int id}) {
    // TODO: implement getCreditTvShows
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getImages({required int id}) {
    // TODO: implement getImages
    throw UnimplementedError();
  }
}
