import 'package:flutter/material.dart';

class SeatViewModel extends ChangeNotifier {
  int? selectedSeatIndex;

//좌석 선택 함수
  void selectSeat(int index) {
    // 선택된 좌석과 동일하면 true (다시 탭하면 좌석 선택 해제 가능)
    // if (selectedSeatIndex == index) {
    //   selectedSeatIndex = null;
    // }
    //아무 좌석 선택 안했거나, 선택 해제 상태는 새로운 좌석 선택 가능
    // else if (selectedSeatIndex == null) {
    //   selectedSeatIndex = index;
    // }//이미 좌석 선택된 경우 선택 불가능

    notifyListeners();
  }

  // 좌석 선택 가능 여부 체크 (선택된 좌석 없을 시 true)
  bool isSelectable() {
    return selectedSeatIndex == null;
  }
}
