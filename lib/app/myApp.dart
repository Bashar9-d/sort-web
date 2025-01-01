import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'enter_values.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> sortName = [
    "Selection Sort",
    "Insertion Sort",
    "Bubble Sort",
  ];
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MySort(),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<MySort>(
            builder: (context, s, child) => Text(
              s.selectSort,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: [
            Consumer<MySort>(
              builder: (context, s, child) => DropdownButton<String>(
                value: s.selectSort,
                items: sortName.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? val) {
                  s.changedValue(val.toString());
                },
              ),
            ),
            Form(
              key: key,
              child: TextFormField(
                validator: (val) {
                  if (val == "") {
                    return "Enter Size";
                  }
                  return null;
                },
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: "Enter Size of Array"),
              ),
            ),
    Consumer<MySort>(
    builder: (context, s, child) =>MaterialButton(
              onPressed: () {
                if (key.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EnterValues(size: int.parse(controller.text),sortType: s.selectSort,),
                    ),
                  );
                }
              },
              child: const Text("Enter"),
            )),
          ],
        ),
      ),
    );
  }
}

class MySort extends ChangeNotifier {
  String selectSort = "Selection Sort";
  List<int> listNum = [];

  void changedValue(String val) {
    selectSort = val;
    notifyListeners();
  }
}
