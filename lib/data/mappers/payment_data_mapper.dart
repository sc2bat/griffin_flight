import '../../domain/model/payment/payment_model.dart';
import '../dtos/payment_data_dto.dart';

extension PaymentDataMapper on PaymentData{
  static PaymentModel fromDTO(PaymentData dto) {
    return PaymentModel(
      bookId: dto.bookId ?? 0,
      userId: dto.userId ?? 0,
      userName: dto.userName,
      flightId: dto.flightId,
      flightDate: dto.flightDate,
      flightTime: dto.departureTime,
      classSeat: dto.classSeat,
      bookStatus: dto.status,
      payStatus: dto.payStatus,
      payAmount: dto.payAmount,
      passengerName: '${dto.firstName ?? ''} ${dto.lastName ?? ''}',
      departureCode: dto.departureCode,
      departureName: dto.departureName,
      arrivalCode: dto.arrivalCode,
      arrivalName: dto.arrivalName,
    );
  }
}
