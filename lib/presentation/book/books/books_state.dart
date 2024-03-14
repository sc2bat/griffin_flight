import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/books/books_model.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';

import '../../../domain/model/user/user_account_model.dart';

part 'books_state.freezed.dart';
part 'books_state.g.dart';

@freezed
class BooksState with _$BooksState {
  factory BooksState({
    @Default(false) bool isLoading,
    FlightResultModel? arrivalFlightResultModel,
    FlightResultModel? departureFlightResultModel,
    @Default(0) int numberOfPeople,
    @Default('') String seatClass,
    @Default([]) List<BooksModel> departureBookList,
    @Default([]) List<BooksModel> arrivalBookList,
    UserAccountModel? userAccountModel,
  }) = _BooksState;

  factory BooksState.fromJson(Map<String, dynamic> json) =>
      _$BooksStateFromJson(json);
}
