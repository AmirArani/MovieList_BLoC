class PersonEntity {
  final int id;
  final String name;
  final String profilePath;

  PersonEntity({required this.id, required this.name, required this.profilePath});

  PersonEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        profilePath = json['profile_path'];
}

class PersonResponseEntity {
  final int page;
  final List<dynamic> personList;
  final int totalPages;
  final int totalResults;

  PersonResponseEntity.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        personList = json['results'],
        totalPages = json['total_pages'],
        totalResults = json['total_results'];
}

class PersonDetailEntity {
  bool? adult;
  String? biography;
  String? birthday;
  String? deathday;
  int? id;
  String? knownForDepartment;
  String? name;
  String? profilePath;

  PersonDetailEntity.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    biography = json['biography'];
    birthday = json['birthday'];
    deathday = json['deathday'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    profilePath = json['profile_path'];
  }
}
