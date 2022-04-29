import 'package:movie_list/data/source/remote/movie_detail_data_source.dart';
import 'package:movie_list/models/review_entity.dart';

import '../../common/http_client.dart';
import '../../models/credit_entity.dart';
import '../../models/movie_details_entity.dart';

final movieDetailRepository =
    MovieDetailRepository(MovieDetailDataSource(httpClient));

abstract class IMovieDetailRepository {
  Future<MovieDetailEntity> getMovieDetail({required int id});
  Future<MovieBackdropEntity> getMovieBackdrop({required int id});
  Future<List<String>> getImages({required int id});
  Future<CreditEntity> getCastAndCrew({required int id});
  Future<List<ReviewEntity>> getReviews({required int id});
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

  @override
  Future<CreditEntity> getCastAndCrew({required int id}) {
    return dataSource.getCastAndCrew(id: id);
  }

  @override
  Future<List<ReviewEntity>> getReviews({required int id}) {
    return dataSource.getReviews(id: id);
  }
}
