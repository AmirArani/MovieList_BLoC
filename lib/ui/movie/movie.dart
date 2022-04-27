import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/movie_detail_repository.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/movie_details_entity.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:shimmer/shimmer.dart';

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
                                                color: Color(0xffEDC700),
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
            Container(
              color: Colors.red.shade100,
              height: 480,
            )
          ],
        ),
      ),
    );
  }
}
