class FirebaseModel {
  String id;
  String text;
  String word;

  FirebaseModel({
    required this.id,
    required this.text,
    required this.word,
  });

  FirebaseModel copyWith({
    String? id,
    String? text,
    String? word,
  }) {
    return FirebaseModel(
      text: text ?? this.text,
      word: word ?? this.word,
      id: id ?? this.id,
    );
  }
}
