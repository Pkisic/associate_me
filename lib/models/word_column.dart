import 'package:associate_me/enums/tags.dart';
import 'package:associate_me/models/word.dart';

class WordColumn {
  final List<Word> words;
  final String finalAns;
  final Tags tag;
  WordColumn(this.words, this.finalAns, this.tag);

  Map<String, dynamic> toMap() {
    return {
      'words': words.map((word) => word.toMap()).toList(),
      'finalAns': finalAns,
    };
  }

  @override
  String toString() {
    return 'Words: $words, FinalAns: $finalAns, Tag: $tag';
  }
}
