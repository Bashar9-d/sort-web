import 'package:flutter/material.dart';
import 'sorting_algorithms.dart';

class Show extends StatefulWidget {
  final List<int> list;
  final String sortType;

  const Show({super.key, required this.list, required this.sortType});

  @override
  State<Show> createState() => _ShowState();
}

class _ShowState extends State<Show> with SortingAlgorithms {
  int currentStep = 1; // الرقم الذي يمثل المرحلة الحالية في عملية الترتيب

  @override
  void initState() {
    super.initState();
    list = List.from(widget.list);
    setStateWrapper(setState, updateStep); // Pass both setState and updateStep functions
    sortList();
  }

  Future<void> sortList() async {
    if (widget.sortType == "Bubble Sort") {
      await bubbleSort();
    } else if (widget.sortType == "Selection Sort") {
      await selectionSort();
    } else if (widget.sortType == "Insertion Sort") {
      await insertionSort();
    } else if (widget.sortType == "Quick Sort") {
      await quickSort(0, list.length - 1);
    }
    setState(() {
      swapText = "Sorting Complete!";
    });
  }

  // دالة لتحديث رقم المرحلة
  void updateStep() {
    setState(() {
      currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("${widget.sortType} Animation"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // إضافة نص رقم المرحلة فوق الأريه
          Text(
            "Step: $currentStep",  // رقم المرحلة الحالي
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,  // enable horizontal scroll
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(list.length, (index) {
                return Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      margin: const EdgeInsets.all(4),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: index == currentIndex
                            ? Colors.green
                            : index == compareIndex
                            ? Colors.blue
                            : Colors.white,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          "${list[index]}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (index == currentIndex || index == compareIndex)
                      Text(
                        index == compareIndex ? conditionText : "",
                        style: TextStyle(
                          color: index == compareIndex
                              ? conditionText.contains("✔️")
                              ? Colors.green
                              : Colors.red
                              : Colors.black,
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            swapText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
