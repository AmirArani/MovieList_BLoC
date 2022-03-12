class MovieEntity {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  // final int voteCount;
  // final double voteAverage;

  MovieEntity(
      this.id, this.title, this.posterPath, this.releaseDate);

  MovieEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        posterPath = json['poster_path'],
        releaseDate = json['release_date'];
        // voteCount = json['vote_count'];
        // voteAverage = json['vote_average'];
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
