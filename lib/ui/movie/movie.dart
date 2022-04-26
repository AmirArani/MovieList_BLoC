import 'package:flutter/material.dart';
import 'package:movie_list/models/movie_entity.dart';

class MovieScreen extends StatelessWidget{
  final MovieEntity movie;

  const MovieScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Hero(
            tag: 'moviePoster',
            child: Image.network(
              'https://image.tmdb.org/t/p/w185' +
                  movie.posterPath,
              width: 172,
              height: 257,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

}