import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import '../../../domain/model/books/books_model.dart';
import '../../../domain/model/user/user_account_model.dart';

part 'seat_state.freezed.dart';
part 'seat_state.g.dart';

@freezed
class SeatState with _$SeatState {
  factory SeatState({
    FlightResultModel? arrivalFlightResultModel,
    FlightResultModel? departureFlightResultModel,
    UserAccountModel? userAccountModel,
    @Default(0) int numberOfPeople,
    @Default(0.0) double totalFare,
    @Default([]) List<BooksModel> departureBookList,
    @Default([]) List<BooksModel> arrivalBookList,
    @Default([]) List<String> departureSelectedSeats,
    @Default([]) List<String> returnSelectedSeats,
  }) = _SeatState;

  factory SeatState.fromJson(Map<String, dynamic> json) =>
      _$SeatStateFromJson(json);
}
