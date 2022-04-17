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


class PersonResponseEntity{
  final int page;
  final List<dynamic> moviesList;
  final int totalPages;
  final int totalResults;

  PersonResponseEntity.fromJson(Map<String, dynamic> json)
      : page = json['page'],
        moviesList = json['results'],
        totalPages = json['total_pages'],
        totalResults = json['total_results'];
}