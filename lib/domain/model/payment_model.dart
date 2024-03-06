// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  const factory PaymentModel({
    @JsonKey(name: 'book_id') required int bookId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_name') String? userName,
    @JsonKey(name: 'flight_id') int? flightId,
    @JsonKey(name: 'class_seat') String? classSeat,
    @JsonKey(name: 'status') int? bookStatus,
    @JsonKey(name: 'pay_status') int? payStatus,
    @JsonKey(name: 'pay_amount') double? payAmount,
    @JsonKey(name: 'flight_date') String? flightDate,
    @JsonKey(name: 'passenger_name') String? passengerName,
    @JsonKey(name: 'departure_code') String? departureCode,
    @JsonKey(name: 'departure_name') String? departureName,
    @JsonKey(name: 'arrival_code') String? arrivalCode,
    @JsonKey(name: 'arrival_name') String? arrivalName,
  }) = _PaymentModel;

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);
}
