import 'package:associate_me/enums/tags.dart';

class Word {
  int? id;
  final String text;
  final bool isAns;
  int? columnId;
  Tags? tag;
  int? numOfLevel;

  Word(
    this.text,
    this.isAns, {
    this.id,
    this.columnId,
    this.tag,
    this.numOfLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'isAns': isAns,
      'columnId': columnId,
      'id': id,
      'tag': tag,
      'num level': numOfLevel
    };
  }

  @override
  String toString() {
    return 'Text: $text, isA: $isAns, col:$columnId, numL:$numOfLevel';
  }
}
