import 'package:movie_list/data/source/remote/person_data_source.dart';

import '../../common/http_client.dart';
import '../../models/person_entity.dart';

final personRepository = PersonRepository(PersonDataSource(httpClient));

abstract class IPersonRepository{
  Future<List<PersonEntity>> getPopularArtists();
}

class PersonRepository implements IPersonRepository{

  final IPersonDataSource dataSource;

  PersonRepository(this.dataSource);

  @override
  Future<List<PersonEntity>> getPopularArtists() {
    return dataSource.getPopularArtists();
  }

}