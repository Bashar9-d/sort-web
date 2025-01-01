import 'package:flutter/cupertino.dart';

mixin SortingAlgorithms<T extends State> {
  late List<int> list;
  int? currentIndex;
  int? compareIndex;
  String conditionText = "";
  String swapText = "";

  late Function setStateCallback;
  late Function updateStepCallback;

  void setStateWrapper(Function fn, Function updateStepFn) {
    setStateCallback = fn;
    updateStepCallback = updateStepFn;
  }

  void resetState() {
    setStateCallback(() {
      currentIndex = null;
      compareIndex = null;
      conditionText = "";
      swapText = "";
    });
  }

  Future<void> bubbleSort() async {
    for (int i = 0; i < list.length - 1; i++) {
      for (int j = 0; j < list.length - i - 1; j++) {
        setStateCallback(() {
          currentIndex = j;
          compareIndex = j + 1;
          conditionText =
          "${list[j]} > ${list[j + 1]} ${list[j] > list[j + 1] ? '✔️' : '❌'}";
          swapText = "";
        });

        await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني

        if (list[j] > list[j + 1]) {
          int temp = list[j];
          list[j] = list[j + 1];
          list[j + 1] = temp;

          setStateCallback(() {
            swapText = "Swapping ${list[j]} and ${list[j + 1]}";
          });

          await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني
        }

        // استدعاء دالة تحديث المرحلة هنا
        updateStepCallback(); // تحديث المرحلة داخل الـ State
      }
    }
    resetState();
  }

  Future<void> selectionSort() async {
    for (int i = 0; i < list.length - 1; i++) {
      int minIndex = i;

      for (int j = i + 1; j < list.length; j++) {
        setStateCallback(() {
          currentIndex = i;
          compareIndex = j;
          conditionText =
          "${list[j]} < ${list[minIndex]} ${list[j] < list[minIndex] ? '✔️' : '❌'}";
          swapText = "";
        });

        await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني

        if (list[j] < list[minIndex]) {
          minIndex = j;
        }
      }

      if (minIndex != i) {
        int temp = list[i];
        list[i] = list[minIndex];
        list[minIndex] = temp;

        setStateCallback(() {
          swapText = "Swapping ${list[i]} and ${list[minIndex]}";
        });

        await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني
      }

      // استدعاء دالة تحديث المرحلة هنا
      updateStepCallback(); // تحديث المرحلة داخل الـ State
    }
    resetState();
  }

  Future<void> insertionSort() async {
    for (int i = 1; i < list.length; i++) {
      int key = list[i];
      int j = i - 1;

      while (j >= 0 && list[j] > key) {
        setStateCallback(() {
          currentIndex = j + 1;
          compareIndex = j;
          conditionText =
          "${list[j]} > $key ${list[j] > key ? '✔️' : '❌'}";
          swapText = "Shifting ${list[j]} to index ${j + 1}";
        });

        await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني

        list[j + 1] = list[j];  // تحريك العنصر للأمام
        j--;

        setStateCallback(() {
          swapText = "Shifting ${list[j + 1]} to index ${j + 1}";
        });

        await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني
      }

      list[j + 1] = key;

      setStateCallback(() {
        swapText = "Inserting $key at index ${j + 1}";
      });

      await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني

      // استدعاء دالة تحديث المرحلة هنا
      updateStepCallback(); // تحديث المرحلة داخل الـ State
    }
    resetState();
  }

  Future<void> quickSort(int low, int high) async {
    if (low < high) {
      int pivotIndex = await partition(low, high);

      await quickSort(low, pivotIndex - 1);
      await quickSort(pivotIndex + 1, high);
    }
  }

  Future<int> partition(int low, int high) async {
    int pivot = list[high];
    int i = low - 1;

    for (int j = low; j < high; j++) {
      setStateCallback(() {
        currentIndex = j;
        compareIndex = high;
        conditionText =
        "${list[j]} <= $pivot ${list[j] <= pivot ? '✔️' : '❌'}";
        swapText = "";
      });

      await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني

      if (list[j] <= pivot) {
        i++;
        int temp = list[i];
        list[i] = list[j];
        list[j] = temp;

        setStateCallback(() {
          swapText = "Swapping ${list[i]} and ${list[j]}";
        });

        await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني
      }
    }

    int temp = list[i + 1];
    list[i + 1] = list[high];
    list[high] = temp;

    setStateCallback(() {
      swapText = "Moving pivot $pivot to index ${i + 1}";
    });

    await Future.delayed(const Duration(seconds: 3));  // تأخير 3 ثواني

    // استدعاء دالة تحديث المرحلة هنا
    updateStepCallback(); // تحديث المرحلة داخل الـ State

    return i + 1;
  }
}
