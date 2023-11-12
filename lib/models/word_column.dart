import 'package:associate_me/enums/tags.dart';
import 'package:associate_me/models/word.dart';

class WordColumn {
  int? id;
  final List<Word> words;
  final Tags tag;
  int? assocId;
  WordColumn(this.words, this.tag);

  Map<String, dynamic> toMap() {
    return {
      'words': words.map((word) => word.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'Words: $words, Tag: $tag';
  }
}
