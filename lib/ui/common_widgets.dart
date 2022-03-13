import 'package:flutter/material.dart';
import 'package:movie_list/models/movie_entity.dart';

class MovieListItem extends StatelessWidget {
  final MovieEntity movieEntity;
  final bool isSorted;

  const MovieListItem({Key? key, required this.movieEntity, required this.isSorted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      height: 140,
      decoration: (BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), //color of shadow
            spreadRadius: 1, //spread radius
            blurRadius: 10, // blur radius
            offset: const Offset(0, 5), // changes position of shadow
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
                  const SizedBox(height: 8),
                  Text(
                    movieEntity.overview,
                    style: themeData.textTheme.caption,
                    maxLines: 4,
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          movieEntity.releaseDate,
                          style: TextStyle(color: Colors.black38, fontSize: 12),
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
            child: Image.network(
              'https://image.tmdb.org/t/p/w185' + movieEntity.posterPath,
              width: 100,
              height: 140,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
