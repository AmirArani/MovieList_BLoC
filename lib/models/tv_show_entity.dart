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
  final lastEpisodeDetail;

  TvShowDetailEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        lastEpisodeDetail = json['last_episode_to_air'];
}

class EpisodeEntity {
  final int seasonNumber;
  final int episodeNumber;

  EpisodeEntity.fromJson(Map<String, dynamic> json)
      : seasonNumber = json['season_number'],
        episodeNumber = json['episode_number'];
}

class EpisodeDetailEntity {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final int episodeNumber;

  EpisodeDetailEntity(
      {required this.id,
      required this.name,
      required this.overview,
      required this.posterPath,
      required this.seasonNumber,
      required this.episodeNumber});
}
