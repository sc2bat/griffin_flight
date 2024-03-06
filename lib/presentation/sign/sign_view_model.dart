import 'package:flutter/material.dart';
import 'package:griffin/presentation/sign/sign_state.dart';

class SignViewModel with ChangeNotifier {
  SignState _signState = const SignState();
  SignState get signState => _signState;
  void init() {
    _signState = signState.copyWith(isLoading: true);
    notifyListeners();
    _signState = signState.copyWith(isLoading: false);
    notifyListeners();
  }
}
