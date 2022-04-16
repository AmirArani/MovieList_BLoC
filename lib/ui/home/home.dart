import 'dart:ui';

import 'package:flutter/material.dart';
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
          children: [
            const SizedBox(height: 114),
            FutureBuilder(
              future: repository.tmdb.getPopularGenres(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<GenresEntity>> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return SizedBox(
                    height: 30,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(27, 0, 27, 0),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data?.length,
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
                                      snapshot.data![index].name,
                                      style: const TextStyle( color: Colors.white,
                                          fontSize: 15),
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
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(height: 50),
            FutureBuilder(
              future: repository.tmdb.getPopularMovies(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<MovieEntity>> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return HorizontalMovieList(
                      trendingMovies: snapshot.data, themeData: themeData);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(
              height: 500,
            ),
          ],
        ),
      ),
    );
  }
}
