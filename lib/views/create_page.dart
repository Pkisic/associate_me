import 'package:associate_me/controllers/base_service.dart';
import 'package:associate_me/enums/tags.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final service = BaseService();
  Map<String, TextEditingController> textEditingControllers = {};

  @override
  void dispose() {
    textEditingControllers.forEach((key, value) => value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      map: textEditingControllers,
      child: Scaffold(
        backgroundColor: Colors.grey[350],
        bottomNavigationBar: BottomAppBar(
          color: Colors.blueGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  var s =
                      service.makeAssociationFromForm(textEditingControllers);
                  print(s);
                },
                icon: const Icon(Icons.play_arrow_sharp),
                color: Colors.white,
              ),
            ],
          ),
        ),
        body: const SafeArea(
          child: CreateNewAssociationForm(),
        ),
      ),
    );
  }
}

class CreateNewAssociationForm extends StatefulWidget {
  const CreateNewAssociationForm({super.key});

  @override
  State<CreateNewAssociationForm> createState() =>
      _CreateNewAssociationFormState();
}

class _CreateNewAssociationFormState extends State<CreateNewAssociationForm> {
  @override
  Widget build(BuildContext context) {
    Map textEditingControllers = MyInheritedWidget.of(context).map;
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: createColumnsForInput(textEditingControllers),
        ),
      ),
    );
  }
}

List<Widget> createColumnsForInput(textEditingControllers) {
  List<Widget> columns = [];

  Widget returnField(String hintText, int? i, bool isAns) {
    var textEditingController = new TextEditingController();
    textEditingControllers.putIfAbsent(
      (isAns) ? hintText : "$hintText$i",
      () => textEditingController,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          hintText: (isAns) ? hintText : "$hintText$i",
        ),
        controller: textEditingController,
      ),
    );
  }

  Widget createFieldAroundColumn(
    String hintText, {
    String? columnText,
    int? numOfFields,
    bool isAns = false,
  }) {
    var iterations = (numOfFields == null) ? 1 : numOfFields;

    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
          ),
          child: Column(
            children: [
              for (var i = 1; i <= iterations; i++)
                returnField(hintText, i, (i == 5) ? !isAns : isAns)
            ],
          ),
        ),
        Positioned(
          left: 50,
          top: 12,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            color: Colors.grey[350],
            child: Text(
              (columnText == null) ? hintText : 'Column $columnText',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  for (var tag in Tags.values) {
    var tagName = tag.name;

    columns.add(
      createFieldAroundColumn(
        tagName,
        columnText: tagName,
        numOfFields: Tags.values.length + 1,
      ),
    );
  }

  columns.add(
    createFieldAroundColumn('FINAL', isAns: true),
  );
  return columns;
}

class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({
    Key? key,
    required this.child,
    required this.map,
  }) : super(key: key, child: child);

  @override
  final Widget child;
  final Map map;
  static MyInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;

  @override
  bool updateShouldNotify(covariant MyInheritedWidget oldWidget) => true;
}
