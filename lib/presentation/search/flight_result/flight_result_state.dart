import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/fligth_result/flight_result_model.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';

part 'flight_result_state.freezed.dart';
part 'flight_result_state.g.dart';

@freezed
class FlightResultState with _$FlightResultState {
  factory FlightResultState({
    @Default(false) bool isLoading,
    @Default([]) List<FlightResultModel> flightResultList,
    UserAccountModel? userAccountModel,
  }) = _FlightResultState;

  factory FlightResultState.fromJson(Map<String, dynamic> json) =>
      _$FlightResultStateFromJson(json);
}
