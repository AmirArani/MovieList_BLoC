part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeError extends HomeState {
  final AppException exception;

  const HomeError({required this.exception});

  @override
  List<Object?> get props => [exception];
}

class HomeSuccess extends HomeState {
  final List<GenreEntity> popularGenres;
  final List<MovieEntity> trendingMovies;
  //TODO:  final TvShowDetailEntity lastEpisodeToAir;
  final List<MovieEntity> bestDrama;
  final List<PersonEntity> popularArtists;
  final List<TvShowEntity> topTvShow;

  const HomeSuccess({
    required this.popularGenres,
    required this.trendingMovies,
    //TODO:  required this.lastEpisodeToAir,
    required this.bestDrama,
    required this.popularArtists,
    required this.topTvShow,
  });

  @override
  List<Object?> get props => [];
}
