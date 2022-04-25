import 'package:movie_list/data/source/data_source.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/person_entity.dart';
import 'package:movie_list/models/tv_show_entity.dart';

class Repository<T> implements DataSource {
  final DataSource<T> tmdb;
  // final DataSource<T> local;

  // inject dependency to the data source as constructor parameter
  Repository(this.tmdb);


  @override
  Future<EpisodeDetailEntity> getLatestFeaturedEpisode() {
    return tmdb.getLatestFeaturedEpisode();
  }

  @override
  Future<List<TvShowEntity>> getTopTvShows() {
    return tmdb.getTopTvShows();
  }
}
