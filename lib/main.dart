import 'package:flutter/material.dart';
import 'package:movie_list/data/data_sources/remote/tmdb_api.dart';
import 'package:movie_list/data/repository/repository.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:movie_list/ui/home/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List',

      //inject dependency to TMDB API just here. once and last.
      // now we can use Repository in any class without initializing TMDB API
      home: Provider<Repository<MovieEntity>>(
          create: (context) => Repository<MovieEntity>(TmdbAPI()),
          child: const HomeScreen()),
    );
  }
}
