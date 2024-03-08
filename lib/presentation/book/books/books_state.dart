import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/fligth_result/flight_result_model.dart';
import '../../../domain/model/user/user_account_model.dart';

part 'books_state.freezed.dart';
part 'books_state.g.dart';

@freezed
class BooksState with _$BooksState {
   factory BooksState({
     FlightResultModel? flightResultModel,
     UserAccountModel? userAccountModel,
  }) = _BooksState;

  factory BooksState.fromJson(Map<String, dynamic> json) =>
      _$BooksStateFromJson(json);
}
