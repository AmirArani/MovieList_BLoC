import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_list/data/repository/genre_repository.dart';
import 'package:movie_list/data/repository/movie_repository.dart';
import 'package:movie_list/data/repository/person_repository.dart';
import 'package:movie_list/data/repository/tv_show_repository.dart';
import 'package:movie_list/gen/assets.gen.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:movie_list/models/person_entity.dart';
import 'package:movie_list/models/tv_show_entity.dart';
import 'package:movie_list/ui/home/bloc/home_bloc.dart';
import 'package:movie_list/ui/theme_data.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/repository/movie_detail_repository.dart';
import '../common_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
          genreRepository,
          movieRepository,
          movieDetailRepository,
          personRepository,
          tvShowRepository,
        );
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        backgroundColor: LightThemeColors.background,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 64),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: AppBar(
                elevation: 0,
                backgroundColor: LightThemeColors.primary.withOpacity(0.8),
                centerTitle: true,
                title: Assets.img.icons.tmdbLong.image(width: 280),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return Main(themeData: themeData);
              } else if (state is HomeLoading) {
                return const _LoadingStateShimmer();
              } else if (state is HomeError) {
                return Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 250),
                      AppErrorWidget(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                        },
                        exception: state.exception,
                      ),
                    ],
                  ),
                );
              } else {
                throw Exception('state is not supported');
              }
            },
          ),
        ),
      ),
    );
  }
}

class Main extends StatelessWidget {
  const Main({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 124),
        const _PopularGenres(), //Popular Genres
        const SizedBox(height: 42),
        _Trending(themeData: themeData), //Trending
        const SizedBox(height: 42),
        const _LastEpisodeToAir(),
        const SizedBox(height: 42),
        _BestDrama(themeData: themeData), //Best Drama
        const SizedBox(height: 42),
        _PopularArtists(themeData: themeData), //Popular Artists
        const SizedBox(height: 42),
        _TopTvShows(themeData: themeData), //Top TV Shows
        const SizedBox(height: 128),
      ],
    );
  }
}

class _PopularGenres extends StatelessWidget {
  const _PopularGenres({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32, left: 32),
          child: Row(
            children: const [
              Text(
                'Popular Genres',
                style: TextStyle(color: LightThemeColors.gray),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        FutureBuilder(
          future: genreRepository.getPopularGenres(),
          builder:
              (BuildContext context, AsyncSnapshot<List<GenreEntity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return GenresTopList(
                allGenres: snapshot.data,
              );
            } else {
              return const GenresShimmer();
            }
          },
        ),
      ],
    );
  }
}

class _Trending extends StatelessWidget {
  const _Trending({Key? key, required this.themeData}) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32, left: 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.img.icons.trending.svg(
                width: 22,
                color: LightThemeColors.gray,
              ),
              const SizedBox(width: 10),
              const Text(
                "Trending",
                style: TextStyle(
                  color: LightThemeColors.gray,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder(
          future: movieRepository.getPopularMovies(),
          builder:
              (BuildContext context, AsyncSnapshot<List<MovieEntity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return HorizontalMovieList(
                movieList: snapshot.data,
                themeData: themeData,
                category: 'trending',
              );
            } else {
              return const HorizontalListShimmer();
            }
          },
        ),
      ],
    );
  }
}

class _LastEpisodeToAir extends StatelessWidget {
  const _LastEpisodeToAir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: tvShowRepository.getLastEpisodeToAir(),
        builder: (BuildContext context, AsyncSnapshot<TvShowDetailEntity> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Container(
              height: 179,
              width: 330,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [LightThemeColors.secondary, LightThemeColors.tertiary]),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w185${snapshot.data!.posterPath}',
                      width: 120,
                      height: 179,
                      fit: BoxFit.cover,
                      fadeInCurve: Curves.easeIn,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          // ignore: prefer_interpolation_to_compose_strings
                          'Season ' +
                              snapshot.data!.seasonNumber.toString() +
                              " | Episode " +
                              snapshot.data!.episodeNumber.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 180,
                          child: Text(
                            snapshot.data!.overview,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              height: 1.05,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Assets.img.icons.tvShow
                                .svg(width: 24, color: Colors.white),
                            const SizedBox(width: 8),
                            const Text(
                              'Watch Now!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return SizedBox(
              height: 179,
              width: 330,
              child: Shimmer(
                gradient: LinearGradient(
                  colors: [
                    LightThemeColors.tertiary.withOpacity(0.3),
                    LightThemeColors.secondary.withOpacity(0.2)
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: LightThemeColors.background,
                  ),
                  height: 179,
                  width: 330,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class _BestDrama extends StatelessWidget {
  const _BestDrama({Key? key, required this.themeData}) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32, left: 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.img.icons.bestDrama.svg(
                height: 24,
                width: 24,
                color: LightThemeColors.gray,
              ),
              const SizedBox(width: 10),
              const Text(
                "Best Drama",
                style: TextStyle(
                  color: LightThemeColors.gray,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder(
          future: movieRepository.getBestDrama(),
          builder:
              (BuildContext context, AsyncSnapshot<List<MovieEntity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return HorizontalMovieList(
                movieList: snapshot.data,
                themeData: themeData,
                category: 'bestDrama',
              );
            } else {
              return const HorizontalListShimmer();
            }
          },
        ),
      ],
    );
  }
}

class _PopularArtists extends StatelessWidget {
  const _PopularArtists({
    Key? key,
    required this.themeData,
  }) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32, left: 32),
          child: Row(
            children: const [
              Text(
                'Popular Artist',
                style: TextStyle(color: LightThemeColors.gray),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder(
          future: personRepository.getPopularArtists(),
          builder:
              (BuildContext context, AsyncSnapshot<List<PersonEntity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return SizedBox(
                height: 168,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return HorizontalPersonListItem(
                      themeData: themeData,
                      personEntity: snapshot.data![index],
                    );
                  },
                ),
              );
            } else {
              return const ArtistShimmer();
            }
          },
        ),
      ],
    );
  }
}

class _TopTvShows extends StatelessWidget {
  const _TopTvShows({Key? key, required this.themeData}) : super(key: key);

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 32, left: 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.img.icons.tvShow.svg(width: 24, color: LightThemeColors.gray),
              const SizedBox(width: 10),
              const Text(
                "Top TV Shows",
                style: TextStyle(
                  color: LightThemeColors.gray,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ), //title
        const SizedBox(height: 12),
        FutureBuilder(
          future: tvShowRepository.getTopTvShows(),
          builder:
              (BuildContext context, AsyncSnapshot<List<TvShowEntity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return HorizontalTvShowList(
                tvShows: snapshot.data!,
                themeData: themeData,
                category: 'top',
              );
            } else {
              return const HorizontalListShimmer();
            }
          },
        ),
      ],
    );
  }
}

class _LoadingStateShimmer extends StatelessWidget {
  const _LoadingStateShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 124),
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32),
            child: Row(
              children: const [
                Text(
                  'Popular Genres',
                  style: TextStyle(color: LightThemeColors.gray),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const GenresShimmer(),
          const SizedBox(height: 42),
          Padding(
            padding: const EdgeInsets.only(right: 32, left: 32),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.img.icons.trending.svg(
                  width: 22,
                  color: LightThemeColors.gray,
                ),
                const SizedBox(width: 10),
                const Text(
                  "Trending",
                  style: TextStyle(
                    color: LightThemeColors.gray,
                    fontSize: 21,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const HorizontalListShimmer(),
          const SizedBox(height: 42),
          SizedBox(
            height: 179,
            width: 330,
            child: Shimmer(
              gradient: LinearGradient(
                colors: [
                  LightThemeColors.tertiary.withOpacity(0.3),
                  LightThemeColors.secondary.withOpacity(0.2)
                ],
              ),
              child: Container(
                margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: LightThemeColors.background,
                ),
                height: 179,
                width: 330,
              ),
            ),
          )
        ],
      ),
    );
  }
}
