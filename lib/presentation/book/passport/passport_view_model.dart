import 'package:flutter/material.dart';
import 'package:griffin/domain/use_cases/passport/passport_use_case.dart';
import 'package:griffin/presentation/book/passport/passport_state.dart';
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

  void init(List<BooksModel> departureBookList,
      List<BooksModel> arrivalBookList) async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    await getSession();

    setBookList(departureBookList, arrivalBookList);

    setTotalFare();

    setNumberOfPeople();

    _state = state.copyWith(isLoading: false);
    notifyListeners();
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

  //post
  Future<void> postPassportData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    final result = await _passportUsecase.execute(
      arrivalbookId: state.arrivalBookList.map((e) => e.bookId).toList(),
      departurebookId: state.departureBookList.map((e) => e.bookId).toList(),
      passportDTOList: state.passportDTOList,
    );
    switch (result) {
      case Success<List<PassportModel>>():
        logger.info(result.data);
      case Error<List<PassportModel>>():
        throw Exception(result.message);
    }
  }

  void setBookList(
      List<BooksModel> departureBookList, List<BooksModel> arrivalBookList) {
    _state = state.copyWith(
      departureBookList: departureBookList,
      arrivalBookList: arrivalBookList,
    );
    notifyListeners();
  }

  void setTotalFare() {
    double totalFare = 0.0;
    for (var item in state.departureBookList) {
      totalFare += item.payAmount ?? 0.0;
    }
    for (var item in state.arrivalBookList) {
      totalFare += item.payAmount ?? 0.0;
    }
    _state = state.copyWith(totalFare: totalFare);
    notifyListeners();
  }

  void setNumberOfPeople() {
    _state = state.copyWith(numberOfPeople: state.departureBookList.length);
    notifyListeners();
  }

  void savePassport(PassportDTO passportDTO) {
    List<PassportDTO> passportDTOList = List.from(state.passportDTOList);
    passportDTOList.add(passportDTO);
    _state = state.copyWith(passportDTOList: passportDTOList);
    logger.info(passportDTOList);
    notifyListeners();

  }
}
