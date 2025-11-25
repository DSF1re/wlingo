class Word {
  final int id;
  final String word;
  final String transcription;
  final String russian;
  final int wordTypeId;
  final String? image;

  Word({
    required this.id,
    required this.word,
    required this.transcription,
    required this.russian,
    required this.wordTypeId,
    this.image,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      word: json['word'],
      transcription: json['transcription'],
      russian: json['russian'],
      wordTypeId: json['word_type_id'] is int
          ? json['word_type_id']
          : int.parse(json['word_type_id'].toString()),
      image: json['image'],
    );
  }
}
