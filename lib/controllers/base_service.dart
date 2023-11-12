import 'package:associate_me/enums/tags.dart';
import 'package:associate_me/models/association.dart';
import 'package:associate_me/models/word.dart';
import 'package:associate_me/models/word_column.dart';

class BaseService {
  String makeAssociationFromForm(Map mapOfText) {
    List<Word> listOfWords = makeListOfWords(mapOfText);
    List<WordColumn> listOfColumns = makeColumn(listOfWords);
    var association = Association(listOfColumns, mapOfText['FINAL'].text);
    return association.toString();
  }

  List<Word> makeListOfWords(mapOfText) {
    List<Word> listOfWords = [];
    mapOfText.forEach((key, value) {
      var split = key.split('');
      var splitLen = split.length;
      Tags tag = Tags.values.firstWhere(
        (element) => split[0] == element.name,
        orElse: () => Tags.A,
      );
      if (splitLen == 2) {
        var word = Word(
          value.text,
          false,
          tag: tag,
          numOfLevel: int.parse(split[1]),
        );
        listOfWords.add(word);
      } else if (splitLen == 1) {
        var word = Word(
          value.text,
          true,
          tag: tag,
        );
        listOfWords.add(word);
      }
    });
    return listOfWords;
  }

  List<WordColumn> makeColumn(List<Word> words) {
    List<WordColumn> listOfColumns = [];
    for (var value in Tags.values) {
      var tmpList = words.where((element) => element.tag == value).toList();
      var column = WordColumn(tmpList, value);
      listOfColumns.add(column);
    }
    return listOfColumns;
  }
}
