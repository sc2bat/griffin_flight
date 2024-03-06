import 'package:flutter/material.dart';
import 'package:griffin/domain/use_cases/passport_use_case.dart';

class PassportViewModel extends ChangeNotifier {
  final PassportUsecase _passportUsecase;

  PassportViewModel({required PassportUsecase passportUsecase})
      : _passportUsecase = passportUsecase;

// FirstName 유효성 검사
  String? firstNameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required.';
    }
    return null;
  }

// LastName 유효성 검사
  String? lastNameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required.';
    }
    return null;
  }

// Email 유효성 검사
  String? emailValidate(String? value) {
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    if (!emailRegExp.hasMatch(value)) {
      return 'Please match the requested format.';
    }
    return null;
  }

  // phoneNumber 유효성 검사
  String? phoneNumberValidate(String? number) {
    if (number == null || number.isEmpty) {
      return 'Phone number is required.';
    }
    return null;
  }
}
