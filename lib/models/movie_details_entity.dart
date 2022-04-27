class MovieDetailEntity {
  final String tagLine;
  // final String overview;
  final String originalLanguage;
  // final String releaseDate;
  final int runtime;
  final double vote;
  final List<dynamic> genres;

  MovieDetailEntity.fromJson(Map<String, dynamic> json)
      : tagLine = json['tagline'],
        // overview = json['overview'],
        originalLanguage = json['original_language'],
        // releaseDate = json['release_date'],
        vote = json['vote_average'],
        runtime = json['runtime'],
        genres = json['genres'];
}

class MovieBackdropEntity {
  final String backdropPath;

  MovieBackdropEntity.fromJson(Map<String, dynamic> json)
      : backdropPath = json['backdrop_path'];
}
