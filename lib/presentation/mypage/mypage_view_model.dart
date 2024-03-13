import 'dart:async';

import 'package:flutter/material.dart';
import 'package:griffin/domain/use_cases/sign/delete_session_use_case.dart';
import 'package:griffin/domain/use_cases/sign/sign_out_use_case.dart';
import 'package:griffin/presentation/mypage/mypage_state.dart';

import '../../data/core/result.dart';
import '../../domain/model/payment/payment_model.dart';
import '../../domain/model/user/user_account_model.dart';
import '../../domain/use_cases/my_books/my_books_for_pay_use_case.dart';
import '../../domain/use_cases/splash/get_session_use_case.dart';
import '../../utils/simple_logger.dart';
import '../sign/sign_ui_event.dart';
import '../splash/sign_status.dart';

class MypageViewModel with ChangeNotifier {
  final SignOutUseCase _signOutUseCase;
  final DeleteSessionUseCase _deleteSessionUseCase;
  final GetSessionUseCase _getSessionUseCase;
  final MyBooksForPayUseCase _myBooksUseCase;

  MypageViewModel({
    required SignOutUseCase signOutUseCase,
    required DeleteSessionUseCase deleteSessionUseCase,
    required GetSessionUseCase getSessionUseCase,
    required MyBooksForPayUseCase myBooksUseCase,
  })  : _signOutUseCase = signOutUseCase,
        _deleteSessionUseCase = deleteSessionUseCase,
        _getSessionUseCase = getSessionUseCase,
        _myBooksUseCase = myBooksUseCase;

  // MypageViewModel({});

  MypageState _mypageState = const MypageState();

  MypageState get mypageState => _mypageState;

  // ui event
  final _searchUiEventStreamController = StreamController<SignUiEvent>();

  Stream<SignUiEvent> get getSignUiEventStreamController =>
      _searchUiEventStreamController.stream;

  // sign Status
  final StreamController<SignStatus> _signStatus = StreamController();

  Stream<SignStatus> get signStatus => _signStatus.stream;

  Future<void> getSession() async {
    final result = await _getSessionUseCase.execute();
    switch (result) {
      case Success<UserAccountModel>():
        _mypageState = mypageState.copyWith(userAccountModel: result.data);
        notifyListeners();
        break;
      case Error<UserAccountModel>():
        logger.info(result.message);
        notifyListeners();
        break;
    }
  }

  Future<void> fetchData() async {
    _mypageState = mypageState.copyWith(isLoading: true);
    notifyListeners();

    try {
      await getSession();
      if (_mypageState.userAccountModel != null) {
        final userId = _mypageState.userAccountModel!.userId;
        final result = await _myBooksUseCase.execute(userId);
        switch (result) {
          case Success<List<PaymentModel>>():
            _mypageState = mypageState.copyWith(
              isLoading: false,
              myPaidBooksList:
                  result.data.where((e) => e.payStatus == 1).toList(),
            );
            logger.info(_mypageState.myPaidBooksList);
          case Error<List<PaymentModel>>():
            _mypageState = mypageState.copyWith(
              isLoading: false,
            );
        }
        notifyListeners();
      }
    } catch (error) {
      // 에러 처리
      logger.info('Error fetching data: $error');
    } finally {
      _mypageState = mypageState.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> init() async {
    _mypageState = mypageState.copyWith(isLoading: true);
    notifyListeners();

    await fetchData();
    // TODO mypage upcomingList
    getUpcomingList();
    // TODO mypage pastList
    getPastList();

    _mypageState = mypageState.copyWith(isLoading: false);
    notifyListeners();
  }

  void updateToggle(int index) {
    List<bool> selectedPage = List.from(mypageState.selectedPage);
    for (int i = 0; i < selectedPage.length; i++) {
      selectedPage[i] = i == index;
    }
    _mypageState = mypageState.copyWith(selectedPage: selectedPage);
    notifyListeners();
  }

  void getUpcomingList() {
    final today = DateTime.now();
    logger.info(_mypageState.myPaidBooksList);
    if (_mypageState.myPaidBooksList.isNotEmpty) {
      final myPaidBooksUpcomingList = _mypageState.myPaidBooksList
          .where((e) => DateTime.parse(e.flightDate!).isAfter(today))
          .toList();
      final upcomingList =
          List.generate(myPaidBooksUpcomingList.length, (index) {
        return {
          'fromAirportCode': myPaidBooksUpcomingList[index].departureCode,
          'toAirportCode': myPaidBooksUpcomingList[index].arrivalCode,
          'fromCountry': myPaidBooksUpcomingList[index].departureName,
          'toCountry': myPaidBooksUpcomingList[index].arrivalName,
          'FlightId': myPaidBooksUpcomingList[index].flightId,
          'SeatNumber': myPaidBooksUpcomingList[index].classSeat,
          'fromDate': myPaidBooksUpcomingList[index].flightDate,
          'fromTime': myPaidBooksUpcomingList[index].flightTime,
        };
      });
      _mypageState = mypageState.copyWith(upcomingList: upcomingList);
      notifyListeners();
    }
  }

  void getPastList() {
    final today = DateTime.now();
    if (_mypageState.myPaidBooksList.isNotEmpty) {
      final myPaidBooksPastList = _mypageState.myPaidBooksList
          .where((e) => DateTime.parse(e.flightDate!).isBefore(today))
          .toList();
      final pastList = List.generate(myPaidBooksPastList.length, (index) {
        return {
          'fromAirportCode': myPaidBooksPastList[index].departureCode,
          'toAirportCode': myPaidBooksPastList[index].arrivalCode,
          'fromCountry': myPaidBooksPastList[index].departureName,
          'toCountry': myPaidBooksPastList[index].arrivalName,
          'FlightId': myPaidBooksPastList[index].flightId,
          'SeatNumber': myPaidBooksPastList[index].classSeat,
          'fromTime': myPaidBooksPastList[index].flightDate,
        };
      });
      _mypageState = mypageState.copyWith(pastList: pastList);
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    _mypageState = mypageState.copyWith(isLoading: true);
    notifyListeners();
    final result = await _signOutUseCase.execute();

    result.when(
      success: (_) async {
        final sessionResult = await _deleteSessionUseCase.execute();

        sessionResult.when(
          success: (_) {
            _signStatus.add(SignStatus.signOut);
            _searchUiEventStreamController
                .add(const SignUiEvent.showSnackBar('로그아웃 성공'));
          },
          error: (message) {
            _searchUiEventStreamController
                .add(SignUiEvent.showSnackBar(message));
          },
        );
      },
      error: (message) {
        _searchUiEventStreamController.add(SignUiEvent.showSnackBar(message));
      },
    );
    _mypageState = mypageState.copyWith(isLoading: false);
    notifyListeners();
  }
}
