class ReviewEntity {
  final String id;
  final String author;
  final String content;
  final String url;
  final String avatar;

  ReviewEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        author = json['author'],
        content = json['content'],
        avatar = json['author_details']['avatar_path'] ?? '',
        url = json['url'];
}
