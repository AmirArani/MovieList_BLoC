import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_list/models/movie_entity.dart';

import '../theme_data.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key, required this.movie, required this.category})
      : super(key: key);

  final MovieEntity movie;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 64),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: AppBar(
              elevation: 0,
              backgroundColor: LightThemeColors.primary.withOpacity(0.8),
              centerTitle: true,
              title: Text(movie.title),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              transitionOnUserGestures: true,
              tag: movie.id.toString() + category,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185' + movie.posterPath,
                width: 172,
                height: 257,
                fit: BoxFit.cover,
              ),
            ),
            Text(movie.title),
          ],
        ),
      ),
    );
  }
}
