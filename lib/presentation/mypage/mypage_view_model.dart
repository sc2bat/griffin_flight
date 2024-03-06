import 'package:flutter/material.dart';
import 'package:griffin/presentation/mypage/mypage_state.dart';

class MypageViewModel with ChangeNotifier {
  // MypageViewModel({});

  MypageState _mypageState = const MypageState();
  MypageState get mypageState => _mypageState;

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
}
