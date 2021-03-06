class TvShowEntity {
  final int id;
  final String name;
  final String overview;
  final String originalLanguage;
  final String posterPath;
  final String firstAirDate;

  TvShowEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        overview = json['overview'],
        name = json['name'],
        originalLanguage = json['original_language'],
        posterPath = json['poster_path'] ?? 'null',
        firstAirDate = json['first_air_date'];
}

class TvShowResponseEntity {
  final int page;
  final List<dynamic> results;
  final int totalPages;
  final int totalResults;

  TvShowResponseEntity.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        results = json['results'],
        totalPages = json['total_pages'],
        totalResults = json['total_results'];
}

class TvShowDetailEntity {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final int episodeNumber;

  TvShowDetailEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        seasonNumber = json['last_episode_to_air']['season_number'],
        episodeNumber = json['last_episode_to_air']['episode_number'];
}
