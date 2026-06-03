class Word {
  final int id;
  final String word;
  final String transcription;
  final String russian;
  final int languageId;
  final int levelId;
  final int categoryId;
  final String? image;

  Word({
    required this.id,
    required this.word,
    required this.transcription,
    required this.russian,
    required this.languageId,
    required this.levelId,
    required this.categoryId,
    this.image,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      word: json['word'],
      transcription: json['transcription'],
      russian: json['russian'],
      languageId: json['language_id'] is int
          ? json['language_id']
          : int.parse(json['language_id'].toString()),
      levelId: json['level_id'] is int ? json['level_id'] : int.parse(json['level_id'].toString()),
      categoryId: json['category_id'] is int ? json['category_id'] : int.parse(json['category_id'].toString()),
      image: json['image'],
    );
  }
}
