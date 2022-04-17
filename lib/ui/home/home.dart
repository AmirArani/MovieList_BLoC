import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_list/data/repository/repository.dart';
import 'package:movie_list/gen/assets.gen.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:movie_list/ui/theme_data.dart';
import 'package:provider/provider.dart';

import '../common_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final Repository<MovieEntity> repository =
        Provider.of<Repository<MovieEntity>>(context);

    return Scaffold(
      backgroundColor: LightThemeColors.background,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 64),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: AppBar(
              elevation: 0,
              backgroundColor: LightThemeColors.primary.withOpacity(0.9),
              centerTitle: true,
              title: Assets.img.icons.tmdbLong.image(width: 280),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 114),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
                  child: Row(
                    children: const [
                      Text(
                        'Popular Genres',
                        style: TextStyle(color: LightThemeColors.gray),
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: repository.tmdb.getPopularGenres(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<GenresEntity>> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return GenresTopList(
                        allGenres: snapshot.data,
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 1),
                      );
                    }
                  },
                ),
              ],
            ),  //Popular Genres
            const SizedBox(height: 24),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
                  child: Row(
                    children: [
                      Assets.img.icons.trending.image(
                        height: 22,
                        width: 22,
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
                const SizedBox(height: 4),
                FutureBuilder(
                  future: repository.tmdb.getPopularMovies(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MovieEntity>> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return HorizontalMovieList(
                          trendingMovies: snapshot.data, themeData: themeData);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 1),
                      );
                    }
                  },
                ),
              ],
            ),  //Trending
            const SizedBox(height: 24),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 5, 32, 5),
                  child: Row(
                    children: [
                      Assets.img.icons.bestDrama.image(
                        height: 22,
                        width: 22,
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
                const SizedBox(height: 4),
                FutureBuilder(
                  future: repository.tmdb.getBestDrama(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MovieEntity>> snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return HorizontalMovieList(
                          trendingMovies: snapshot.data, themeData: themeData);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 1),
                      );
                    }
                  },
                ),
              ],
            ),  //Best Drama
          ],
        ),
      ),
    );
  }
}
