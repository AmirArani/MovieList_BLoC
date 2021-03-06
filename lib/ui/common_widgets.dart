import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/gen/assets.gen.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:movie_list/models/person_entity.dart';
import 'package:movie_list/ui/artist/artist.dart';
import 'package:movie_list/ui/movie/movie.dart';
import 'package:movie_list/ui/theme_data.dart';
import 'package:movie_list/ui/tvShow/tv_show.dart';
import 'package:shimmer/shimmer.dart';

import '../common/exception.dart';
import '../models/genres_entity.dart';
import '../models/tv_show_entity.dart';

class VerticalMovieListItem extends StatelessWidget {
  final MovieEntity movieEntity;
  final String category;

  const VerticalMovieListItem(
      {Key? key, required this.movieEntity, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(
            builder: (context) {
              return MovieScreen(movie: movieEntity, category: category);
            },
          ),
        );
      },
      child: Container(
        height: 140,
        width: 100,
        decoration: (BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3), //color of shadow
              spreadRadius: 1, //spread radius
              blurRadius: 10, // blur radius
              offset: const Offset(0, 5), // changes position of shadow
            )
          ],
        )),
        margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieEntity.title,
                      style: themeData.textTheme.bodyText1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      movieEntity.overview,
                      style: themeData.textTheme.caption,
                      maxLines: 4,
                      overflow: TextOverflow.fade,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movieEntity.releaseDate,
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              movieEntity.originalLanguage,
                              style: const TextStyle(color: Colors.black38),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Hero(
              transitionOnUserGestures: true,
              tag: movieEntity.id.toString() + category,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w185${movieEntity.posterPath}',
                  width: 100,
                  height: 140,
                  fit: BoxFit.fill,
                  fadeInCurve: Curves.easeIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HorizontalMovieList extends StatelessWidget {
  const HorizontalMovieList({
    Key? key,
    required this.movieList,
    required this.themeData,
    required this.category,
  }) : super(key: key);

  final List<MovieEntity>? movieList;
  final ThemeData themeData;
  final String category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movieList?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) {
                    return MovieScreen(movie: movieList![index], category: category);
                  },
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
              width: 112,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0601B4E4),
                    blurRadius: 3,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  Hero(
                    transitionOnUserGestures: true,
                    tag: movieList![index].id.toString() + category,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(14),
                        topLeft: Radius.circular(14),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w185${movieList![index].posterPath}',
                        width: 112,
                        height: 171,
                        fit: BoxFit.cover,
                        fadeInCurve: Curves.easeIn,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 100,
                    height: 35,
                    child: Center(
                      child: Text(
                        movieList![index].title,
                        style: themeData.textTheme.bodyText2!.copyWith(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HorizontalTvShowList extends StatelessWidget {
  const HorizontalTvShowList({
    Key? key,
    required this.themeData,
    required this.tvShows,
    required this.category,
  }) : super(key: key);

  final ThemeData themeData;
  final List<TvShowEntity> tvShows;
  final String category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: tvShows.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true)
                  .push(CupertinoPageRoute(builder: (context) {
                return TvShowScreen(
                  category: category,
                  tvShow: tvShows[index],
                );
              }));
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
              width: 112,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(14),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0601B4E4),
                    blurRadius: 3,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: [
                  Hero(
                    transitionOnUserGestures: true,
                    tag: tvShows[index].id.toString() + category,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(14),
                        topLeft: Radius.circular(14),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w185${tvShows[index].posterPath}',
                        width: 112,
                        height: 171,
                        fit: BoxFit.cover,
                        fadeInCurve: Curves.easeIn,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 100,
                    height: 35,
                    child: Center(
                      child: Text(
                        tvShows[index].name,
                        style: themeData.textTheme.bodyText2!.copyWith(
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class HorizontalListShimmer extends StatelessWidget {
  const HorizontalListShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var singleHMovieShimmer = Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: LightThemeColors.background,
      ),
      height: 215,
      width: 112,
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: Shimmer(
              gradient: LinearGradient(
                colors: [
                  LightThemeColors.tertiary.withOpacity(0.3),
                  LightThemeColors.secondary.withOpacity(0.2)
                ],
              ),
              child: Row(
                children: [
                  singleHMovieShimmer,
                  singleHMovieShimmer,
                  singleHMovieShimmer,
                  singleHMovieShimmer,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GenresTopList extends StatelessWidget {
  final List<GenreEntity>? allGenres;

  const GenresTopList({
    Key? key,
    required this.allGenres,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(27, 0, 27, 0),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: allGenres?.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
            decoration: const BoxDecoration(
              color: Color(0xffC4C4C4),
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(
                        allGenres![index].name,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HorizontalPersonListItem extends StatelessWidget {
  const HorizontalPersonListItem({
    Key? key,
    required this.themeData,
    required this.personEntity,
  }) : super(key: key);

  final ThemeData themeData;
  final PersonEntity personEntity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(
            builder: (context) {
              return ArtistScreen(personEntity: personEntity);
            },
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(9, 0, 9, 0),
        width: 67,
        height: 135,
        child: Column(
          children: [
            Hero(
              transitionOnUserGestures: true,
              tag: '${personEntity.id}artist',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(33.36),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w185${personEntity.profilePath}',
                  width: 66.72,
                  height: 100,
                  fit: BoxFit.cover,
                  fadeInCurve: Curves.easeIn,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: 67,
                height: 35,
                child: Center(
                  child: Text(
                    personEntity.name,
                    style: themeData.textTheme.bodyText2!
                        .copyWith(fontSize: 14, overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerticalPersonListItem extends StatelessWidget {
  const VerticalPersonListItem({
    Key? key,
    required this.id,
    required this.name,
    required this.profilePath,
    required this.subtitle,
  }) : super(key: key);

  final int id;
  final String name;
  final String profilePath;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute(
            builder: (context) {
              return ArtistScreen(
                  personEntity: PersonEntity(
                id: id,
                name: name,
                profilePath: profilePath,
              ));
            },
          ),
        );
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                width: 67,
                height: 110,
                child: Column(
                  children: [
                    Hero(
                      transitionOnUserGestures: true,
                      tag: '${id}artist',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(33.36),
                        child: CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w185$profilePath',
                          width: 66.72,
                          height: 100,
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeIn,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    name,
                    style: const TextStyle(
                        color: LightThemeColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(subtitle),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class GenresShimmer extends StatelessWidget {
  const GenresShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var singleGenreShimmer = Container(
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: LightThemeColors.background,
      ),
      height: 30,
      width: 80,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 27),
          child: Shimmer(
            gradient: LinearGradient(
              colors: [
                LightThemeColors.tertiary.withOpacity(0.3),
                LightThemeColors.secondary.withOpacity(0.2)
              ],
            ),
            child: Row(
              children: [
                singleGenreShimmer,
                singleGenreShimmer,
                singleGenreShimmer,
                singleGenreShimmer,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ArtistShimmer extends StatelessWidget {
  const ArtistShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var singleArtistShimmer = Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(9, 0, 9, 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(33.36),
            color: LightThemeColors.background,
          ),
          height: 100,
          width: 66.72,
        ),
        // const SizedBox(height: 8),
        Container(
          margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: LightThemeColors.background,
          ),
          height: 30,
          width: 67,
        ),
      ],
    );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: Shimmer(
              gradient: LinearGradient(
                colors: [
                  LightThemeColors.tertiary.withOpacity(0.3),
                  LightThemeColors.secondary.withOpacity(0.2)
                ],
              ),
              child: Row(
                children: [
                  singleArtistShimmer,
                  singleArtistShimmer,
                  singleArtistShimmer,
                  singleArtistShimmer,
                  singleArtistShimmer,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    Key? key,
    required this.exception,
    required this.onPressed,
  }) : super(key: key);

  final AppException exception;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.img.errorState.image(height: 150),
        const SizedBox(height: 54),
        Text(exception.message),
        ElevatedButton(
          onPressed: onPressed,
          child: const Text('Retry...'),
        ),
      ],
    );
  }
}
