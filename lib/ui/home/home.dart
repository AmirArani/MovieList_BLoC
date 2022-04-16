import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/repository.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:movie_list/ui/theme_data.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final Repository<MovieEntity> repository =
        Provider.of<Repository<MovieEntity>>(context);
    return Scaffold(
      backgroundColor: LightThemeColors.background,
      appBar: AppBar(
        backgroundColor: LightThemeColors.secondary,
        title: Row(
          children: const [
            Icon(CupertinoIcons.film),
            SizedBox(width: 16),
            Text('Favorite Movies'),
          ],
        ),
        actions: [
          Row(
            children: const [
              Icon(CupertinoIcons.ellipsis),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          FutureBuilder(
            future: repository.tmdb.getAllMovies(),
            builder:
                (BuildContext context, AsyncSnapshot<List<MovieEntity>> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return HorizontalMovieList(trendingMovies: snapshot.data, themeData: themeData);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class HorizontalMovieList extends StatelessWidget {
  const HorizontalMovieList({
    Key? key,
    required this.trendingMovies,
    required this.themeData,
  }) : super(key: key);

  final List<MovieEntity>? trendingMovies;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24.5, 0, 24.5, 0),
        scrollDirection: Axis.horizontal,
        itemCount: trendingMovies?.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.fromLTRB(7.5, 0, 7.5, 5),
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
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(14),
                    topLeft: Radius.circular(14),
                  ),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w185' +
                        trendingMovies![index].posterPath,
                    width: 112,
                    height: 171,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 100,
                  height: 35,
                  child: Center(
                    child: Text(
                      trendingMovies![index].title,
                      style: themeData.textTheme.bodyText2!.copyWith(
                          fontSize: 15, overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                      textAlign: TextAlign.center,
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
