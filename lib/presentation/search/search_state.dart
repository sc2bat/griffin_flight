import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';

import '../../domain/model/airport/airport_model.dart';

part 'search_state.freezed.dart';

@freezed
class SearchState with _$SearchState {
  factory SearchState({
    @Default([]) List<AirportModel> airportList,
    @Default([]) List<String> selectedClassList,
    @Default('Economy') String selectClass,
    @Default(false) bool isLoading,
    @Default(false) bool isSelected,
    @Default(1) int currentPersonValue,
    @Default(0) int fromAirportId,
    @Default(0) int toAirportId,
    @Default('') String travelDate,
    @Default('') String returnDate,
    @Default({}) Map<String, dynamic> searchResult,
    UserAccountModel? userAccountModel,
  }) = _SearchState;
}
