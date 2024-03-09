import 'package:griffin/domain/model/payment/payment_model.dart';

import '../../../data/core/result.dart';

/* 예약페이지에서 예약된 티켓정보를 List<Map<String, dynamic>>형태(혹은 다른 형태)로 전달받아서 List<PaymentModel> 로 변환.
   my_book_screen에서 pay_screen로 전달되는 결제정보 타입으로 맞추기 위한 작업임.
 */
class DirectPayUseCase {
  Result<List<PaymentModel>> execute(
      List<Map<String, dynamic>> bookedItemsList) {
    try {
      List<PaymentModel> directPayList = [];
      for (var bookedItem in bookedItemsList) {
        PaymentModel directPayItem = PaymentModel(
            bookId: bookedItem[''],
            userId: bookedItem[''],
            departureCode: bookedItem[''],
            arrivalCode: bookedItem[''],
            passengerName: bookedItem[''],
            flightDate: bookedItem[''],
            flightId: bookedItem[''],
            classSeat: bookedItem['']);
        directPayList.add(directPayItem);
      }
      return Result.success(directPayList);
    } catch (e) {
      return Result.error('directPayData error => $e');
    }
  }
}
