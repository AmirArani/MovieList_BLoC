class MovieEntity {
  final int id;
  final String title;
  final String overview;
  final String originalLanguage;
  final String posterPath;
  final String releaseDate;

  MovieEntity(this.id, this.title, this.posterPath, this.releaseDate, this.overview,
      this.originalLanguage);

  MovieEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        overview = json['overview'],
        title = json['title'],
        originalLanguage = json['original_language'],
        posterPath = json['poster_path'] ?? 'null',
        releaseDate = json['release_date'];
}

class MovieResponseEntity {
  final int page;
  final List<dynamic> moviesList;
  final int totalPages;
  final int totalResults;

  MovieResponseEntity.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        moviesList = json['results'],
        totalPages = json['total_pages'],
        totalResults = json['total_results'];
}
