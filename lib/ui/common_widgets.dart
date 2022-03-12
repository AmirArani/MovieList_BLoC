import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_list/models/movie_entity.dart';

class MovieListItem extends StatelessWidget {
  final MovieEntity movieEntity;

  const MovieListItem({Key? key, required this.movieEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: (BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [BoxShadow(
          color: Colors.grey.withOpacity(0.5), //color of shadow
          spreadRadius: 5, //spread radius
          blurRadius: 7, // blur radius
          offset: Offset(0, 2), // changes position of shadow
          //first paramerter of offset is left-right
          //second parameter is top to down
        )]
      )),
      margin: const EdgeInsets.fromLTRB(16, 5, 16, 5),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movieEntity.title),
                  Text(movieEntity.releaseDate),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              'assets/img/movie.png',
              width: 115,
              height: 115,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 2.5),
        ],
      ),
    );
  }
}
