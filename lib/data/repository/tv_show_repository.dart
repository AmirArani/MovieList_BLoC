import 'package:movie_list/data/source/remote/tv_show_data_source.dart';

import '../../common/http_client.dart';
import '../../models/tv_show_entity.dart';

final tvShowRepository = TvShowRepository(TvShowDataSource(httpClient));

abstract class ITvShowRepository {
  Future<List<TvShowEntity>> getTopTvShows();
  Future<TvShowDetailEntity> getLatestFeaturedEpisode();
}

class TvShowRepository implements ITvShowRepository {
  final ITvShowDataSource dataSource;

  TvShowRepository(this.dataSource);

  @override
  Future<TvShowDetailEntity> getLatestFeaturedEpisode() {
    return dataSource.getLatestFeaturedEpisode();
  }

  @override
  Future<List<TvShowEntity>> getTopTvShows() {
    return dataSource.getTopTvShows();
  }
}
