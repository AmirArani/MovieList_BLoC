class GenreEntity {
  final int id;
  final String name;

  GenreEntity(this.id, this.name);

  GenreEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}

class GenresResponseEntity {
  final List<dynamic> genresList;

  GenresResponseEntity(this.genresList);

  GenresResponseEntity.fromJson(Map<String, dynamic> json)
      : genresList = json['genres'];
}
