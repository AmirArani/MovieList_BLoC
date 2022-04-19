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

class TvShowDetailEntity {
  final int id;
  final List<dynamic> lastEpisodeDetail;

  TvShowDetailEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        lastEpisodeDetail = json['last_episode_to_air'];
}

class TvShowLastEpisodeToAirEntity {
  final int id;
  final String name;
  final String overview;
  final int seasonNumber;
  final int episodeNumber;
  final String posterPath;

  TvShowLastEpisodeToAirEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        overview = json['overview'],
        seasonNumber = json['season_number'],
        episodeNumber = json['episode_number'],
        posterPath = json['still_path'];
}
