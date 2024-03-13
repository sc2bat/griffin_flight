// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'flight_model.freezed.dart';
part 'flight_model.g.dart';

@freezed
abstract class FlightModel with _$FlightModel {
  factory FlightModel({
    @JsonKey(name: 'flight_id') required int flightId,
    @JsonKey(name: 'airplane_id') required int airplaneId,
    @JsonKey(name: 'flight_date') required String flightDate,
    @JsonKey(name: 'departure_time') required String departureTime,
    @JsonKey(name: 'arrival_time') required String arrivalTime,
    @JsonKey(name: 'departure_loc') required int departureLoc,
    @JsonKey(name: 'arrival_loc') required int arrivalLoc,
  }) = _FlightModel;

  factory FlightModel.fromJson(Map<String, dynamic> json) =>
      _$FlightModelFromJson(json);
}
