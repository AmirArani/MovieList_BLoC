import 'package:dio/dio.dart';
import 'package:movie_list/models/person_entity.dart';
import 'package:movie_list/models/tv_show_entity.dart';

abstract class DataSource<T> {

  static Dio dio = Dio(
    BaseOptions(baseUrl: 'https://api.themoviedb.org/3/'),
  );

  Future<EpisodeDetailEntity> getLatestFeaturedEpisode();

  Future<List<TvShowEntity>> getTopTvShows();
}


