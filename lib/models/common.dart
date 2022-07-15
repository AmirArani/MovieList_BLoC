class BackdropEntity {
  final String backdropPath;

  BackdropEntity.fromJson(Map<String, dynamic> json)
      : backdropPath = json['backdrop_path'] ?? 'null';
}
