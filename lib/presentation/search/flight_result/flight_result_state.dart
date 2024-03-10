import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';

part 'flight_result_state.freezed.dart';
part 'flight_result_state.g.dart';

@freezed
class FlightResultState with _$FlightResultState {
  factory FlightResultState({
    @Default(false) bool isLoading,
    @Default([true, false]) List<bool> selectedPage,
    @Default([]) List<FlightResultModel> fligthSelectList,
    @Default([]) List<FlightResultModel> fromFlightResultList,
    @Default([]) List<FlightResultModel> toFlightResultList,
    FlightResultModel? selectFromFlight,
    FlightResultModel? selectToFlight,
    UserAccountModel? userAccountModel,
  }) = _FlightResultState;

  factory FlightResultState.fromJson(Map<String, dynamic> json) =>
      _$FlightResultStateFromJson(json);
}
