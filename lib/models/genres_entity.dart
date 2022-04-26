class GenresEntity {
  final int id;
  final String name;

  GenresEntity(this.id, this.name);

  GenresEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}

class GenresResponseEntity {
  final List<dynamic> genresList;

  GenresResponseEntity(this.genresList);

  GenresResponseEntity.fromJson(Map<String, dynamic> json)
      : genresList = json['genres'];
}
