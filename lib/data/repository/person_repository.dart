import 'package:movie_list/data/source/remote/person_data_source.dart';
import 'package:movie_list/models/tv_show_entity.dart';

import '../../common/http_client.dart';
import '../../models/movie_entity.dart';
import '../../models/person_entity.dart';

final personRepository = PersonRepository(PersonDataSource(httpClient));

abstract class IPersonRepository {
  Future<List<PersonEntity>> getPopularArtists();
  Future<PersonDetailEntity> getPersonDetail({required int id});
  Future<List<MovieEntity>> getCreditMovies({required int id});
  Future<List<TvShowEntity>> getCreditTvShows({required int id});
  Future<List<String>> getImages({required int id});
}

class PersonRepository implements IPersonRepository {
  final IPersonDataSource dataSource;

  PersonRepository(this.dataSource);

  @override
  Future<List<PersonEntity>> getPopularArtists() {
    return dataSource.getPopularArtists();
  }

  @override
  Future<PersonDetailEntity> getPersonDetail({required int id}) {
    return dataSource.getPersonDetail(id: id);
  }

  @override
  Future<List<MovieEntity>> getCreditMovies({required int id}) {
    return dataSource.getCreditMovies(id: id);
  }

  @override
  Future<List<TvShowEntity>> getCreditTvShows({required int id}) {
    return dataSource.getCreditTvShows(id: id);
  }

  @override
  Future<List<String>> getImages({required int id}) {
    return dataSource.getImages(id: id);
  }
}
