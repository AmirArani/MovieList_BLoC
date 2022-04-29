class CastEntity {
  final int id;
  final String name;
  final String profilePath;
  final String character;

  CastEntity.fromJsom(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        profilePath = json['profile_path'],
        character = json['character'];
}

class CrewEntity {
  final int id;
  final String name;
  final String profilePath;
  final String job;

  CrewEntity.fromJsom(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        profilePath = json['profile_path'],
        job = json['job'];
}

class CastAndCrewEntity{
  final List<CastEntity> cast;
  final List<CrewEntity> crew;

  CastAndCrewEntity({required this.cast,required this.crew});
}