class TvShowEntity{
  final int id;
  final String name;
  final String overview;
  final String originalLanguage;
  final String posterPath;
  final String firstAirDate;

  TvShowEntity(this.id, this.name, this.posterPath, this.firstAirDate, this.overview,
      this.originalLanguage);

  TvShowEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        overview = json['overview'],
        name = json['name'],
        originalLanguage = json['original_language'],
        posterPath = json['poster_path'],
        firstAirDate = json['first_air_date'];
}

class TvShowResponseEntity {
  final int page;
  final List<dynamic> moviesList;
  final int totalPages;
  final int totalResults;

  TvShowResponseEntity.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        moviesList = json['results'],
        totalPages = json['total_pages'],
        totalResults = json['total_results'];
}