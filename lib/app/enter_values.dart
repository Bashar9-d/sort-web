import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'myApp.dart';
import 'show.dart';

class EnterValues extends StatefulWidget {
  final int size;
final String sortType;
  const EnterValues({super.key, required this.size, required this.sortType});

  @override
  State<EnterValues> createState() => _EnterValuesState();
}

class _EnterValuesState extends State<EnterValues> {
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  List<int> list = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MySort(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: ListView(
          children: [
            Form(
              key: key,
              child: TextFormField(
                validator: (val) {
                  if (val == "") {
                    return "Enter value";
                  }
                  return null;
                },
                controller: controller,
                keyboardType: TextInputType.number,
                decoration:
                const InputDecoration(hintText: "Enter Values of Array"),
              ),
            ),
             MaterialButton(
                onPressed: () {
                  if (key.currentState!.validate()) {
                    list.add(int.parse(controller.text));
                    controller.text = "";

                    setState(() {});
                  }
                  if (list.length == widget.size) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            Show(list: list, sortType:widget.sortType ),
                      ),
                    );
                  }
                },
                child: const Text("ADD"),
              ),

          ],
        ),
      ),
    );
  }
}
