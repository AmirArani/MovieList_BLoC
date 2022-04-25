import 'package:dio/dio.dart';

import '../../../common/constants.dart';
import '../../../models/person_entity.dart';

String getPopularArtistsPath = 'person/popular?api_key=' + Constants.apiKey;

abstract class IPersonDataSource {
  Future<List<PersonEntity>> getPopularArtists();
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
      allArtists.add(PersonEntity.fromJson(element));
    }

    return allArtists;
  }
}
