import 'package:flutter/material.dart';
import 'package:movie_list/models/movie_entity.dart';

class MovieListItem extends StatelessWidget {
  final MovieEntity movieEntity;

  const MovieListItem({Key? key, required this.movieEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      height: 120,
      decoration: (BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), //color of shadow
            spreadRadius: 1, //spread radius
            blurRadius: 5, // blur radius
            offset: const Offset(0, 0), // changes position of shadow
          )
        ],
      )),
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieEntity.title,
                    style: themeData.textTheme.bodyText1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movieEntity.overview,
                    style: themeData.textTheme.caption,
                    maxLines: 3,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          movieEntity.releaseDate,
                          style: themeData.textTheme.bodyText2,
                        ),
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            movieEntity.originalLanguage,
                            style: const TextStyle(color: Colors.black38),
                          ),
                        ),
                      )
                    ],
                  ),
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
