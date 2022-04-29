import 'package:movie_list/data/source/remote/movie_detail_data_source.dart';

import '../../common/http_client.dart';
import '../../models/movie_details_entity.dart';

final movieDetailRepository =
    MovieDetailRepository(MovieDetailDataSource(httpClient));

abstract class IMovieDetailRepository {
  Future<MovieDetailEntity> getMovieDetail({required int id});
  Future<MovieBackdropEntity> getMovieBackdrop({required int id});
  Future<List<String>> getImages({required int id});
}

class MovieDetailRepository implements IMovieDetailRepository {
  final IMovieDetailDataSource dataSource;

  MovieDetailRepository(this.dataSource);

  @override
  Future<MovieDetailEntity> getMovieDetail({required int id}) {
    return dataSource.getMovieDetail(id: id);
  }

  @override
  Future<MovieBackdropEntity> getMovieBackdrop({required int id}) {
    return dataSource.getMovieBackdrop(id: id);
  }

  @override
  Future<List<String>> getImages({required int id}) {
    return dataSource.getImages(id: id);
  }
}
