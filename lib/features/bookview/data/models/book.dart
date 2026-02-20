class Book {
  final int id;
  final String title;
  final String author;
  final String url;
  final int languageId;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.url,
    required this.languageId,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      url: json['file_path'] as String,
      languageId: json['language_id'] as int,
    );
  }

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, url: $url)';
  }
}
