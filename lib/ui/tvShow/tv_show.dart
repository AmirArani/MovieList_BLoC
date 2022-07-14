import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/tv_show_detail_repository.dart';
import 'package:movie_list/models/tv_show_entity.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/repository/movie_detail_repository.dart';
import '../../models/common.dart';
import '../../models/genres_entity.dart';
import '../../models/movie_entity.dart';
import '../theme_data.dart';

class TvShowScreen extends StatelessWidget {
  const TvShowScreen({
    Key? key,
    required this.tvShow,
    required this.category,
  }) : super(key: key);

  final TvShowEntity tvShow;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 440,
              child: Stack(
                children: [
                  _TopBackDrop(tvShowID: tvShow.id),
                  _MainPoster(
                    category: category,
                    posterPath: tvShow.posterPath,
                    id: tvShow.id,
                  ),
                  _TitleAndInfo(title: tvShow.name, id: tvShow.id),
                ],
              ),
            ),
            // _BottomTabBar(movie: tvShow)
          ],
        ),
      ),
    );
  }
}

class _TopBackDrop extends StatelessWidget {
  const _TopBackDrop({
    Key? key,
    required this.tvShowID,
  }) : super(key: key);

  final int tvShowID;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: FutureBuilder(
        future: tvShowDetailRepository.getTvShowBackdrop(id: tvShowID),
        builder: (BuildContext context, AsyncSnapshot<BackdropEntity> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return CachedNetworkImage(
              imageUrl:
                  'https://image.tmdb.org/t/p/w400${snapshot.data!.backdropPath}',
              fadeInCurve: Curves.easeIn,
              errorWidget: (context, url, error) => SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.57,
                child: const Center(
                  child: Icon(Icons.error),
                ),
              ),
            );
          } else {
            return Shimmer(
              gradient: LinearGradient(
                colors: [
                  LightThemeColors.tertiary.withOpacity(0.3),
                  LightThemeColors.secondary.withOpacity(0.2),
                  LightThemeColors.secondary.withOpacity(0.2),
                  LightThemeColors.tertiary.withOpacity(0.3),
                ],
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.57,
                color: LightThemeColors.background,
              ),
            );
          }
        },
      ),
    );
  }
}

class _MainPoster extends StatelessWidget {
  const _MainPoster({
    Key? key,
    required this.category,
    required this.id,
    required this.posterPath,
  }) : super(key: key);

  final int id;
  final String posterPath;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 170,
      left: 20,
      child: Hero(
        transitionOnUserGestures: true,
        tag: id.toString() + category,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color: LightThemeColors.gray.withOpacity(0.5),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w185$posterPath',
              width: 172,
              height: 257,
              fit: BoxFit.cover,
              fadeInCurve: Curves.easeIn,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleAndInfo extends StatelessWidget {
  const _TitleAndInfo({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 240,
      left: 205,
      width: 185,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          FutureBuilder(
            future: movieDetailRepository.getMovieDetail(id: id),
            builder:
                (BuildContext context, AsyncSnapshot<MovieDetailEntity> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data!.tagLine),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: LightThemeColors.gray.withOpacity(0.7),
                          ),
                          child: Text(
                            snapshot.data!.originalLanguage,
                            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                color: Colors.white, fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Icon(CupertinoIcons.star,
                            color: Color(0xffEDC700), size: 18),
                        const SizedBox(width: 4),
                        Text(
                          snapshot.data!.vote.toString(),
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: const Color(0xffEDC700),
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(width: 15),
                        const Icon(CupertinoIcons.clock,
                            size: 18, color: LightThemeColors.primary),
                        const SizedBox(width: 4),
                        Text(snapshot.data!.runtime.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(fontWeight: FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      clipBehavior: Clip.hardEdge,
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (var genre in snapshot.data!.genres)
                          Container(
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: LightThemeColors.tertiary.withOpacity(0.8),
                            ),
                            child: Text(GenreEntity.fromJson(genre).name,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                          )
                      ],
                    )
                  ],
                );
              } else {
                return Shimmer(
                  gradient: LinearGradient(
                    colors: [
                      LightThemeColors.tertiary.withOpacity(0.2),
                      LightThemeColors.secondary.withOpacity(0.1)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: LightThemeColors.background,
                        ),
                        height: 25,
                        width: 128,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: LightThemeColors.background,
                            ),
                            height: 25,
                            width: 50,
                          ),
                          const SizedBox(width: 1),
                          Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: LightThemeColors.background,
                            ),
                            height: 25,
                            width: 50,
                          ),
                          const SizedBox(width: 1),
                          Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: LightThemeColors.background,
                            ),
                            height: 25,
                            width: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
