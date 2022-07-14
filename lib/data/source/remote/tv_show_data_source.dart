import 'package:dio/dio.dart';

import '../../../common/constants.dart';
import '../../../models/tv_show_entity.dart';

String getLatestFeaturedEpisodeIDPath =
    'tv/airing_today?api_key=${Constants.apiKey}';
String getTopTvShowPath = '/tv/top_rated?api_key=${Constants.apiKey}';

abstract class ITvShowDataSource {
  Future<List<TvShowEntity>> getTopTvShows();
}

class TvShowDataSource implements ITvShowDataSource {
  final Dio httpClient;

  TvShowDataSource(this.httpClient);

  @override
  Future<List<TvShowEntity>> getTopTvShows() async {
    final response = await httpClient.get(getTopTvShowPath);
    final List<TvShowEntity> allShows = [];

    for (var element in (response.data['results'])) {
      allShows.add(TvShowEntity.fromJson(element));
    }

    return allShows;
  }
}
