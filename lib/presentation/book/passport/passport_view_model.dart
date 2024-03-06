import 'package:flutter/material.dart';
import 'package:griffin/domain/use_cases/passport_use_case.dart';

class PassportViewModel extends ChangeNotifier {
  final PassportUsecase _passportUsecase;

  PassportViewModel({required PassportUsecase passportUsecase})
      : _passportUsecase = passportUsecase;
}
