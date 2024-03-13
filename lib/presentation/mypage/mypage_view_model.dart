import 'dart:async';

import 'package:flutter/material.dart';
import 'package:griffin/domain/use_cases/sign/delete_session_use_case.dart';
import 'package:griffin/domain/use_cases/sign/sign_out_use_case.dart';
import 'package:griffin/presentation/mypage/mypage_state.dart';

import '../sign/sign_ui_event.dart';
import '../splash/sign_status.dart';

class MypageViewModel with ChangeNotifier {
  MypageViewModel({
    required DeleteSessionUseCase deleteSessionUseCase,
    required SignOutUseCase signOutUseCase,
  })  : _deleteSessionUseCase = deleteSessionUseCase,
        _signOutUseCase = signOutUseCase;
  final DeleteSessionUseCase _deleteSessionUseCase;
  final SignOutUseCase _signOutUseCase;
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

  Future<void> init() async {
    _mypageState = mypageState.copyWith(isLoading: true);
    notifyListeners();

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
    final upcomingList = List.generate(10, (index) {
      return {
        'fromAirportCode': 'DEL',
        'toAirportCode': 'JFK',
        'fromCountry': 'New Delhi',
        'toCountry': 'Jhon F.Kennedy',
        'fromCountryCode': 'India',
        'toCountryCode': 'Ny',
        'fromTime': '23:45, Thu 15 Oct',
        'toTime': '04:30, Fri 16 Oct',
      };
    });
    _mypageState = mypageState.copyWith(upcomingList: upcomingList);
    notifyListeners();
  }

  void getPastList() {
    final pastList = List.generate(10, (index) {
      return {
        'fromAirportCode': 'JFK',
        'toAirportCode': 'DEL',
        'fromCountry': 'Jhon F.Kennedy',
        'toCountry': 'New Delhi',
        'toCountryCode': 'India',
        'fromCountryCode': 'Ny',
        'fromTime': '23:45, Thu 15 Oct',
        'toTime': '04:30, Fri 16 Oct',
      };
    });
    _mypageState = mypageState.copyWith(pastList: pastList);
    notifyListeners();
  }

  Future<void> signOut() async {
    _mypageState = mypageState.copyWith(isLoading: true);
    notifyListeners();
    final result = await _signOutUseCase.execute();

    result.when(
      success: (_) async {
        final sessionResult = await _deleteSessionUseCase.execute();

        sessionResult.when(
          success: (_) => _signStatus.add(SignStatus.signOut),
          error: (message) {
            _searchUiEventStreamController
                .add(SignUiEvent.showSnackBar(message));
            _mypageState = mypageState.copyWith(isLoading: false);
            notifyListeners();
          },
        );
      },
      error: (message) {
        _searchUiEventStreamController.add(SignUiEvent.showSnackBar(message));

        _mypageState = mypageState.copyWith(isLoading: false);
        notifyListeners();
      },
    );
  }
}
