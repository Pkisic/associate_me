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
  final _formKey = GlobalKey<FormState>();
  bool _changesView = true;
  bool _enableButton = true;
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
      formKey: _formKey,
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
                  setState(() {
                    _changesView = !_changesView;
                    _enableButton = !_enableButton;
                  });
                },
                icon: const Icon(Icons.app_registration),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {
                  if (!_enableButton) {
                    return;
                  }
                  if (!_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Fill missing fields...'),
                      ),
                    );
                    return;
                  }
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
        body: SafeArea(
          child: CreateNewAssociationForm(
            switchesView: _changesView,
          ),
        ),
      ),
    );
  }
}

class CreateNewAssociationForm extends StatefulWidget {
  final bool switchesView;
  const CreateNewAssociationForm({super.key, required this.switchesView});

  @override
  State<CreateNewAssociationForm> createState() =>
      _CreateNewAssociationFormState();
}

class _CreateNewAssociationFormState extends State<CreateNewAssociationForm> {
  final PageController _pageController = PageController();
  final List<bool> _pageValidation = List.filled(5, false);
  final Map<int, GlobalKey<FormState>> formKeys = {};
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    Map textEditingControllers = MyInheritedWidget.of(context).map;
    var lastPage = createColumnsForInput(textEditingControllers).length;
    return Center(
      child: (widget.switchesView)
          ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Form(
                key: MyInheritedWidget.of(context).formKey,
                child: Column(
                  children: createColumnsForInput(textEditingControllers),
                ),
              ),
            )
          : PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                var page = value - 1;
                if (formKeys[page] != null && _pageValidation[page] == false) {
                  if (formKeys[page]!.currentState!.validate()) {
                    setState(() {
                      _pageValidation[page] = true;
                    });
                  } else {
                    _pageController.animateToPage(
                      page,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                    return;
                  }
                }
                if ((lastPage - 1) == value) {
                  setState(() {
                    isLastPage = true;
                  });
                } else {
                  setState(() {
                    isLastPage = false;
                  });
                }
              },
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: createColumnsForInput(textEditingControllers).length,
              itemBuilder: (context, index) {
                formKeys[index] = GlobalKey<FormState>();
                return Column(
                  children: [
                    Form(
                      key: formKeys[index],
                      child:
                          createColumnsForInput(textEditingControllers)[index],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: returnTheAnswers(textEditingControllers),
                    )
                  ],
                );
                // return createColumnsForInput(textEditingControllers)[index];
              },
            ),
    );
  }

  List<Widget> returnTheAnswers(textEditingControllers) {
    List<Widget> columns = [];
    for (var entry in textEditingControllers.entries) {
      for (var tag in Tags.values) {
        if (entry.key == tag.name) {
          columns.add(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    entry.key + " : ",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    entry.value.text,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          );
        }
      }
    }
    return columns;
  }
}

List<Widget> createColumnsForInput(textEditingControllers) {
  List<Widget> columns = [];

  Widget returnField(String hintText, int? i, bool isAns) {
    var key = (isAns) ? hintText : "$hintText$i";
    if (!textEditingControllers.containsKey(key)) {
      textEditingControllers[key] = TextEditingController();
    }
    var textEditingController = textEditingControllers[key];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
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
    required this.formKey,
  }) : super(key: key, child: child);

  @override
  final Widget child;
  final Map map;
  final GlobalKey<FormState> formKey;
  static MyInheritedWidget of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;

  @override
  bool updateShouldNotify(covariant MyInheritedWidget oldWidget) => true;
}
