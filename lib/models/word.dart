class Word {
  final String text;

  Word(this.text);

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  @override
  String toString() {
    return 'Text: $text';
  }
}
