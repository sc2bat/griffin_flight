import 'package:flutter/material.dart';
import 'package:griffin/domain/use_cases/passport/passport_use_case.dart';
import 'package:griffin/presentation/book/passport/passport_state.dart';
import 'package:griffin/presentation/book/passport/widgets/gender_widget.dart';
import '../../../data/core/result.dart';
import '../../../data/dtos/passport_dto.dart';
import '../../../domain/model/books/books_model.dart';
import '../../../domain/model/passport/passport_model.dart';
import '../../../domain/model/user/user_account_model.dart';
import '../../../domain/use_cases/splash/get_session_use_case.dart';
import '../../../utils/simple_logger.dart';

class PassportViewModel extends ChangeNotifier {
  PassportViewModel(
      {required GetSessionUseCase getSessionUseCase,
      required PassportUsecase passportUsecase})
      : _getSessionUseCase = getSessionUseCase,
        _passportUsecase = passportUsecase;

  final GetSessionUseCase _getSessionUseCase;
  final PassportUsecase _passportUsecase;

  PassportState _state = PassportState();

  PassportState get state => _state;

  void init() async {
    await getSession();
  }

//get userID
  Future<void> getSession() async {
    final result = await _getSessionUseCase.execute();
    switch (result) {
      case Success<UserAccountModel>():
        _state = state.copyWith(userAccountModel: result.data);
        notifyListeners();
        break;
      case Error<UserAccountModel>():
        logger.info(result.message);
        notifyListeners();
        break;
    }
  }

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

  //post
  Future<void> postPassportData(
      PassportDTO passportDTO, List<BooksModel> booksModel) async {
    final result = await _passportUsecase.execute(
      bookIdList: booksModel.map((e) => e.bookId).toList(),
      paramPassportDTO: passportDTO,
    );
    switch (result) {
      case Success<List<PassportModel>>():
        logger.info(result.data);
      case Error<List<PassportModel>>():
        throw Exception(result.message);
    }
  }

  //gender change 함수
  void changeGender(Gender gender) {
    _state = state.copyWith(selectedGender: gender);
    notifyListeners();
  }

//nationality change 함수
  void changeNationality(String country) {
    _state = state.copyWith(selectedCountry: country);
    notifyListeners();
  }

//dob change 함수
  void changeDob(DateTime date) {
    _state = state.copyWith(selectedDate: date);
    notifyListeners();
  }
}
