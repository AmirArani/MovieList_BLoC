import 'package:flutter/material.dart';
import 'package:movie_list/models/movie_entity.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key, required this.movie, required this.category})
      : super(key: key);

  final MovieEntity movie;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
    );
  }
}
