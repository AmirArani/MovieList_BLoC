class TvShowEntity {
  final int id;
  final String name;
  final String overview;
  final String originalLanguage;
  final String posterPath;
  final String backdropPath;
  final double vote;

  TvShowEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        overview = json['overview'],
        originalLanguage = json['original_language'],
        posterPath = json['poster_path'] ?? 'null',
        backdropPath = json['backdrop_path'] ?? 'null',
        vote = json['vote_average'];
}

class TvShowDetailEntity {
  final String tagline;
  final String status;
  final bool inProduction;
  final String firstAirDate;
  final String lastAirDate;
  final int seasonCount;
  final int episodeCount;
  final List<dynamic> genres;
  final List<SeasonEntity> seasons;
  final EpisodeEntity lastEpisodeToAir;

  TvShowDetailEntity.fromJson(Map<String, dynamic> json)
      : tagline = json['tagline'],
        status = json['status'],
        inProduction = json['in_production'],
        firstAirDate = json['first_air_date'],
        lastAirDate = json['last_air_date'],
        seasonCount = json['number_of_seasons'],
        episodeCount = json['number_of_episodes'],
        genres = json['genres'],
        seasons = json['seasons'],
        lastEpisodeToAir = json['last_episode_to_air'];
}

class EpisodeEntity {
  final int id;
  final int showId;
  final String airDate;
  final int episodeNumber;
  final int seasonNumber;
  final String name;
  final String overview;
  final int runtime;
  final String posterPath;
  final double vote;

  EpisodeEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        showId = json['show_id'],
        airDate = json['air_date'],
        episodeNumber = json['episode_number'],
        seasonNumber = json['season_number'],
        name = json['name'],
        overview = json['overview'],
        runtime = json['runtime'],
        posterPath = json['still_path'],
        vote = json['vote_average'];
}

class SeasonEntity {
  final int id;
  final String name;
  final String overview;
  final String airDate;
  final String posterPath;
  final int seasonNumber;
  final int episodeCount;

  SeasonEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        overview = json['overview'],
        airDate = json['air_date'],
        posterPath = json['poster_path'],
        seasonNumber = json['season_number'],
        episodeCount = json['episode_count'];
}
