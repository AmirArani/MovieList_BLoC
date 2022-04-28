import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/movie_detail_repository.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/movie_details_entity.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../theme_data.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key, required this.movie, required this.category})
      : super(key: key);

  final MovieEntity movie;
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
                  Positioned(
                    top: 0,
                    child: FutureBuilder(
                      future: movieDetailRepository.getMovieBackdrop(id: movie.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<MovieBackdropEntity> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Image(
                            image: CachedNetworkImageProvider(
                                'https://image.tmdb.org/t/p/w400' +
                                    snapshot.data!.backdropPath),
                          );
                        } else {
                          return Shimmer(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 0.57,
                              color: LightThemeColors.background,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                LightThemeColors.tertiary.withOpacity(0.3),
                                LightThemeColors.secondary.withOpacity(0.2)
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 20,
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: movie.id.toString() + category,
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
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w185' + movie.posterPath,
                            width: 172,
                            height: 257,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 240,
                    left: 205,
                    width: 185,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        FutureBuilder(
                          future: movieDetailRepository.getMovieDetail(id: movie.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<MovieDetailEntity> snapshot) {
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
                                          color:
                                              LightThemeColors.gray.withOpacity(0.7),
                                        ),
                                        child: Text(
                                          snapshot.data!.originalLanguage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      const Icon(CupertinoIcons.star,
                                          color: Color(0xffEDC700), size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        snapshot.data!.vote.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
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
                                              .copyWith(
                                                  fontWeight: FontWeight.normal)),
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
                                          padding:
                                              const EdgeInsets.fromLTRB(8, 5, 8, 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: LightThemeColors.tertiary
                                                .withOpacity(0.8),
                                          ),
                                          child: Text(
                                              GenreEntity.fromJson(genre).name,
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
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 480,
              child: DefaultTabController(
                length: 4,
                child: Scaffold(
                  appBar: TabBar(
                    physics: const BouncingScrollPhysics(),
                    labelColor: LightThemeColors.primary,
                    unselectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.w300),
                    unselectedLabelColor: LightThemeColors.primary.withOpacity(0.4),
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorWeight: 3,
                    labelPadding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                    indicator: DotIndicator(
                      distanceFromCenter: 15,
                      color: LightThemeColors.primary,
                    ),
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Cast & Crew'),
                      Tab(text: 'Reviews'),
                      Tab(text: 'Similar Movies'),
                    ],
                  ),
                  body: const TabBarView(
                    children: [
                      Icon(CupertinoIcons.settings),
                      Icon(CupertinoIcons.settings),
                      Icon(CupertinoIcons.settings),
                      Icon(CupertinoIcons.settings),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
