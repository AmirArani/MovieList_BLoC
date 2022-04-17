import 'package:movie_list/data/data_sources/data_source.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/person_entity.dart';
import 'package:movie_list/models/tv_show_entity.dart';

class Repository<T> implements DataSource {
  final DataSource<T> tmdb;
  // final DataSource<T> local;

  // inject dependency to the data source as constructor parameter
  Repository(this.tmdb);


  @override
  Future<List<GenresEntity>> getPopularGenres() {
    return tmdb.getPopularGenres();
  }

  @override
  Future<List> getPopularMovies() {
    return tmdb.getPopularMovies();
  }

  @override
  Future<TvShowEntity> getLatestFeaturedEpisode() {
    return tmdb.getLatestFeaturedEpisode();
  }

  @override
  Future<List> getBestDrama() {
    return tmdb.getBestDrama();
  }

  @override
  Future<List<PersonEntity>> getPopularArtists() {
    return tmdb.getPopularArtists();
  }

  @override
  Future<List<TvShowEntity>> getTopTvShows() {
    return tmdb.getTopTvShows();
  }

  @override
  Future<List> searchMovies({required String searchKeyword}) {
    return tmdb.searchMovies(searchKeyword: searchKeyword);
  }
}
