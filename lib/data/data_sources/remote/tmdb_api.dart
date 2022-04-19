import 'package:movie_list/data/data_sources/data_source.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/person_entity.dart';
import 'package:movie_list/models/tv_show_entity.dart';

import '../../../models/movie_entity.dart';

String apiKey = 'b0abba018d32248e292a0ba14df1f07b';

class TmdbAPI implements DataSource<MovieEntity> {
  String getPopularGenresPath = 'genre/movie/list?api_key=' + apiKey;
  String getPopularMoviesPath = '/movie/now_playing?api_key=' + apiKey;
  // String getPopularMoviesPath = 'discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc&api_key=' + apiKey;
  String getLatestFeaturedEpisodeIDPath = 'tv/airing_today?api_key=' + apiKey;
  String getBestDramaPath = 'discover/movie?with_genres=18&api_key=' + apiKey;
  String getPopularArtistsPath = 'person/popular?api_key=' + apiKey;
  String getTopTvShowPath = '/tv/top_rated?api_key=' + apiKey;


  @override
  Future<List<GenresEntity>> getPopularGenres() async {
    final response = await HttpClient.instance.get(getPopularGenresPath);
    final List<GenresEntity> allGenres = [];

    final initialResponse = GenresResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.genresList)) {
      allGenres.add(GenresEntity.fromJson(element));
    }

    return allGenres;
  }

  @override
  Future<List<MovieEntity>> getPopularMovies() async {
    final response = await HttpClient.instance.get(getPopularMoviesPath);
    final List<MovieEntity> allMovies = [];

    final initialResponse = MovieResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.moviesList)) {
      allMovies.add(MovieEntity.fromJson(element));
    }

    return allMovies;
  }

  // @override
  // Future<TvShowLastEpisodeToAirEntity> getLatestFeaturedEpisode() async {
  //   final response = await HttpClient.instance.get(getLatestFeaturedEpisodeIDPath);
  //   final List<TvShowLastEpisodeToAirEntity> show;
  //
  //   final initialResponse = TvShowResponseEntity.fromJson(response.data);
  //
  //   int episodeId = TvShowEntity.fromJson(initialResponse[0]).id;
  //
  //     return show;
  //
  // }

  @override
  Future<List<MovieEntity>> getBestDrama() async {
    final response = await HttpClient.instance.get(getBestDramaPath);
    final List<MovieEntity> allMovies = [];

    final initialResponse = MovieResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.moviesList)) {
      allMovies.add(MovieEntity.fromJson(element));
    }

    return allMovies;
  }

  @override
  Future<List<PersonEntity>> getPopularArtists() async {
    final response = await HttpClient.instance.get(getPopularArtistsPath);
    final List<PersonEntity> allArtists = [];

    final initialResponse = PersonResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.personList)) {
      allArtists.add(PersonEntity.fromJson(element));
    }

    return allArtists;
  }

  @override
  Future<List<TvShowEntity>> getTopTvShows() async {
    final response = await HttpClient.instance.get(getTopTvShowPath);
    final List<TvShowEntity> allShows = [];

    final initialResponse = TvShowResponseEntity.fromJson(response.data);

    for (var element in (initialResponse.moviesList)) {
      allShows.add(TvShowEntity.fromJson(element));
    }

    return allShows;
  }

  @override
  Future<List<MovieEntity>> searchMovies({required String searchKeyword}) async {
    // TODO: implement getBestDrama
    throw UnimplementedError();
  }
}
