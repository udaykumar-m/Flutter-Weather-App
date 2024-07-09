class FirebaseModel {
  String id;
  String quote;
  String word;

  FirebaseModel({
    required this.id,
    required this.quote,
    required this.word,
  });

  FirebaseModel copyWith({
    String? id,
    String? quote,
    String? word,
  }) {
    return FirebaseModel(
      quote: quote ?? this.quote,
      word: word ?? this.word,
      id: id ?? this.id,
    );
  }
}
