import 'dart:async';

import 'package:flutter/material.dart';
import 'package:griffin/domain/use_cases/sign/save_session_use_case.dart';
import 'package:griffin/domain/use_cases/sign/sign_in_use_case.dart';
import 'package:griffin/domain/use_cases/sign/sign_up_use_case.dart';
import 'package:griffin/presentation/sign/sign_state.dart';
import 'package:griffin/presentation/sign/sign_ui_event.dart';
import 'package:griffin/presentation/splash/sign_status.dart';

class SignViewModel with ChangeNotifier {
  SignViewModel({
    required SignUpUseCase signUpUseCase,
    required SignInUseCase signInUseCase,
    required SaveSessionUseCase saveSessionUseCase,
  })  : _signUpUseCase = signUpUseCase,
        _signInUseCase = signInUseCase,
        _saveSessionUseCase = saveSessionUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignInUseCase _signInUseCase;
  final SaveSessionUseCase _saveSessionUseCase;

  SignState _signState = const SignState();
  SignState get signState => _signState;

  // ui event
  final _searchUiEventStreamController = StreamController<SignUiEvent>();
  Stream<SignUiEvent> get getSignUiEventStreamController =>
      _searchUiEventStreamController.stream;

  // sign Status
  final StreamController<SignStatus> _signStatus = StreamController();
  Stream<SignStatus> get signStatus => _signStatus.stream;

  void init() {
    _signState = signState.copyWith(isLoading: true);
    notifyListeners();
    _signState = signState.copyWith(isLoading: false);
    notifyListeners();
  }

  Future<void> signUp(
      String email, String userName, String password1, String password2) async {
    final result =
        await _signUpUseCase.execute(email, userName, password1, password2);

    result.when(
      success: (_) {
        _searchUiEventStreamController
            .add(const SignUiEvent.showSnackBar('Sign Up Success!'));
        _signState = signState.copyWith(isSignUp: true);
        notifyListeners();
        _signStatus.add(SignStatus.signUp);
      },
      error: (message) {
        _searchUiEventStreamController.add(SignUiEvent.showSnackBar(message));
      },
    );
  }

  Future<void> signIn(String userName, String password) async {
    _signState = signState.copyWith(isLoading: true);
    notifyListeners();
    final result = await _signInUseCase.execute(userName, password);

    result.when(
      success: (data) async {
        await _saveSessionUseCase.execute(data);
        _signStatus.add(SignStatus.signIn);
      },
      error: (message) =>
          _searchUiEventStreamController.add(SignUiEvent.showSnackBar(message)),
    );
    _signState = signState.copyWith(isLoading: false);
    notifyListeners();
  }
}
