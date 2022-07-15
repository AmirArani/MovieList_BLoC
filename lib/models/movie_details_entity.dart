class MovieDetailEntity {
  final String tagLine;
  final String originalLanguage;
  final int runtime;
  final double vote;
  final List<dynamic> genres;

  MovieDetailEntity.fromJson(Map<String, dynamic> json)
      : tagLine = json['tagline'],
        originalLanguage = json['original_language'],
        vote = json['vote_average'],
        runtime = json['runtime'],
        genres = json['genres'];
}
