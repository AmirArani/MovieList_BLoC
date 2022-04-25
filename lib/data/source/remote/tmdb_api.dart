import 'package:movie_list/common/constants.dart';
import 'package:movie_list/common/http_client.dart';
import 'package:movie_list/data/source/data_source.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/person_entity.dart';
import 'package:movie_list/models/tv_show_entity.dart';

import '../../../models/movie_entity.dart';


class TmdbAPI implements DataSource<MovieEntity> {
  String getLatestFeaturedEpisodeIDPath = 'tv/airing_today?api_key=' + Constants.apiKey;
  String getPopularArtistsPath = 'person/popular?api_key=' + Constants.apiKey;
  String getTopTvShowPath = '/tv/top_rated?api_key=' + Constants.apiKey;


  @override
  Future<EpisodeDetailEntity> getLatestFeaturedEpisode() async {
    // 1. get last episode to Air ID
    final responseId = await httpClient.get(getLatestFeaturedEpisodeIDPath);
    final initialResponseId = TvShowResponseEntity.fromJson(responseId.data);
    TvShowEntity show = TvShowEntity.fromJson(initialResponseId.results[0]);
    int id = show.id;

    // 2. get initial_response with id
    String getLatestFeaturedEpisodeDETAILPath =
        'tv/' + id.toString() + '?api_key=' + Constants.apiKey;
    final responseDetail =
        await httpClient.get(getLatestFeaturedEpisodeDETAILPath);
    final tvShowDetail = TvShowDetailEntity.fromJson(responseDetail.data);

    // 3. get the true result from initial_response
    final EpisodeEntity episodeNumbers =
        EpisodeEntity.fromJson(
            tvShowDetail.lastEpisodeDetail);

    final EpisodeDetailEntity finalResult =
        EpisodeDetailEntity(
      id: tvShowDetail.id,
      name: tvShowDetail.name,
      overview: tvShowDetail.overview,
      posterPath: tvShowDetail.posterPath,
      seasonNumber: episodeNumbers.seasonNumber,
      episodeNumber: episodeNumbers.episodeNumber,
    );

    return finalResult;
  }


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

  @override
  Future<List<TvShowEntity>> getTopTvShows() async {
    final response = await httpClient.get(getTopTvShowPath);
    final List<TvShowEntity> allShows = [];

    final initialResponse = TvShowResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.results)) {
      allShows.add(TvShowEntity.fromJson(element));
    }

    return allShows;
  }
}
