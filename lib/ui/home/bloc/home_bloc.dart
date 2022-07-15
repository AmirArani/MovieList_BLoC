import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_list/data/repository/genre_repository.dart';
import 'package:movie_list/data/repository/movie_detail_repository.dart';
import 'package:movie_list/data/repository/movie_repository.dart';
import 'package:movie_list/data/repository/person_repository.dart';
import 'package:movie_list/data/repository/tv_show_repository.dart';

import '../../../common/exception.dart';
import '../../../models/genres_entity.dart';
import '../../../models/movie_entity.dart';
import '../../../models/person_entity.dart';
import '../../../models/tv_show_entity.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IGenreRepository genreRepository;
  final IMovieRepository movieRepository;
  final IMovieDetailRepository movieDetailRepository;
  final IPersonRepository personRepository;
  final ITvShowRepository tvShowRepository;

  HomeBloc(
    this.genreRepository,
    this.movieRepository,
    this.movieDetailRepository,
    this.personRepository,
    this.tvShowRepository,
  ) : super(HomeLoading()) {
    on<HomeEvent>(
      (event, emit) async {
        if (event is HomeStarted || event is HomeRefresh) {
          try {
            emit(HomeLoading());

            final popularGenres = await genreRepository.getPopularGenres();
            final trendingMovies = await movieRepository.getPopularMovies();
            final lastEpisodeToAir = await tvShowRepository.getLastEpisodeToAir();
            final bestDrama = await movieRepository.getBestDrama();
            final popularArtists = await personRepository.getPopularArtists();
            final topTvShows = await tvShowRepository.getTopTvShows();

            emit(HomeSuccess(
              popularGenres: popularGenres,
              trendingMovies: trendingMovies,
              lastEpisodeToAir: lastEpisodeToAir,
              bestDrama: bestDrama,
              popularArtists: popularArtists,
              topTvShow: topTvShows,
            ));
          } catch (e) {
            emit(HomeError(exception: e is AppException ? e : AppException()));
          }
        }
      },
    );
  }
}
