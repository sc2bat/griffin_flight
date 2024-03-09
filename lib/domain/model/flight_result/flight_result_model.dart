// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'flight_result_model.freezed.dart';
part 'flight_result_model.g.dart';

@freezed
abstract class FlightResultModel with _$FlightResultModel {
  factory FlightResultModel({
    required int flightId,
    required int airplaneId,
    required String flightDate,
    required int departureLoc,
    required String departureAirportCode,
    required String departureAirportName,
    required int arrivalLoc,
    required String arrivalAirportCode,
    required String arrivalAirportName,
    required String departureTime,
    required String arrivalTime,
    required String classLevel,
    required double payAmount,
  }) = _FlightResultModel;

  factory FlightResultModel.fromJson(Map<String, dynamic> json) =>
      _$FlightResultModelFromJson(json);
}
