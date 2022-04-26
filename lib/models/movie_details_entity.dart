class MovieDetailEntity {
  final String tagLine;
  final String overview;
  final String originalLanguage;
  final String backdropPath;
  final String releaseDate;
  final int runtime;
  final List<dynamic> genres;

  MovieDetailEntity.fromJson(Map<String, dynamic> json)
      : tagLine = json['tagline'],
        overview = json['overview'],
        originalLanguage = json['original_language'],
        backdropPath = json['backdrop_path'],
        releaseDate = json['release_date'],
        runtime = json['runtime'],
        genres = json['genres'];
}
