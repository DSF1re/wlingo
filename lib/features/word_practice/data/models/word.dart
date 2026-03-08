class Word {
  final int id;
  final String word;
  final String transcription;
  final String russian;
  final int languageId;
  final String? image;

  Word({
    required this.id,
    required this.word,
    required this.transcription,
    required this.russian,
    required this.languageId,
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
      image: json['image'],
    );
  }
}
