import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:griffin/presentation/counter/counter_view_model.dart';

final counterProvider = StateProvider((ref) => CounterViewModel());

// class CounterState {
//   int _counter = 0;

//   int get counter => _counter;

//   void increment() {
//     _counter++;
//   }

//   void decrement() {
//     _counter--;
//   }
// }
// 