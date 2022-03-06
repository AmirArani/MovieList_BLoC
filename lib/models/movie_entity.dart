class MovieEntity {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final int voteCount;
  final double voteAverage;

  MovieEntity(this.id, this.title, this.posterPath, this.releaseDate, this.runtime,
      this.voteCount, this.voteAverage);

  MovieEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['original_title'],
        posterPath = json['poster_path'],
        releaseDate = json['release_date'],
        voteAverage = json['vote_average'],
        voteCount = json['vote_count'],
        runtime = json['runtime'];
}
