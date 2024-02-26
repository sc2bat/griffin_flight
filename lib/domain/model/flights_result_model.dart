import 'package:freezed_annotation/freezed_annotation.dart';

part 'flights_result_model.freezed.dart';

part 'flights_result_model.g.dart';

@freezed
abstract class FlightsResultModel with _$FlightsResultModel {
  factory FlightsResultModel({
      required double width,
      required double height,
      String? departureAirportCode,
      String? arrivalAirportCode,
      String? departureTime,
      String? arrivalTime,
      String? flightTime,
      String? direct,
      int? price,
      String? airlineName
  }) = _FlightsResultModel;

  factory FlightsResultModel.fromJson(Map<String, dynamic> json) =>
      _$FlightsResultModelFromJson(json);
}
