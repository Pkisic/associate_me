import 'package:associate_me/models/word_column.dart';

class Association {
  final List<WordColumn> columns;
  final String finalAns;
  Association(this.columns, this.finalAns);

  Map<String, dynamic> toMap() {
    return {
      'columns': columns.map((column) => column.toMap()).toList(),
      'finalAns': finalAns,
    };
  }
}
