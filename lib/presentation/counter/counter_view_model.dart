import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterViewModel extends StateNotifier<int> {
  CounterViewModel() : super(0);

  void increment() => state++;
  void decrement() => state--;
}
