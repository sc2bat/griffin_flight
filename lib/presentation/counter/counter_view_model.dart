import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:griffin/utils/simple_logger.dart';

class CounterViewModel extends StateNotifier<int> {
  CounterViewModel() : super(0);

  void increment() {
    state++;
    logger.info('increment => $state');
  }

  void decrement() {
    state--;
    logger.info('decrement => $state');
  }
}
