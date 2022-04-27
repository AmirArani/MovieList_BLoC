class GenreEntity {
  final int id;
  final String name;

  GenreEntity(this.id, this.name);

  GenreEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}

class GenreResponseEntity {
  final List<dynamic> genresList;

  GenreResponseEntity(this.genresList);

  GenreResponseEntity.fromJson(Map<String, dynamic> json)
      : genresList = json['genres'];
}
