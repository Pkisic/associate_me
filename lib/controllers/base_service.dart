import 'package:associate_me/enums/tags.dart';
import 'package:associate_me/models/word.dart';
import 'package:associate_me/models/word_column.dart';

class BaseService {
  String test() {
    Word pr = Word('pr');
    Word res = Word('text');
    List<Word> lista = [pr];
    const tag = Tags.A;
    WordColumn column = WordColumn(lista, 'res', tag);
    return column.toString();
  }
}
