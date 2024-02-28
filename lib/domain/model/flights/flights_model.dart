
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flights_model.freezed.dart';
part 'flights_model.g.dart';

@freezed
abstract class FlightsModel with _$FlightsModel {
  factory FlightsModel({
    @JsonKey(name: 'flight_id') required int flightId,
    @JsonKey(name: 'airplane_id') int? airplaneId,
    @JsonKey(name: 'flight_date') String? flightDate,
    @JsonKey(name: 'departure_time') String? departureTime,
    @JsonKey(name: 'arrival_time') String? arrivalTime,
    @JsonKey(name: 'departure_loc') int? departureLoc,
    @JsonKey(name: 'departure_name') String? departureName,
    @JsonKey(name: 'arrival_loc') int? arrivalLoc,
    @JsonKey(name: 'arrival_name') String? arrivalName,
  }) = _FlightsModel;

  factory FlightsModel.fromJson(Map<String, dynamic> json) =>
      _$FlightsModelFromJson(json);
}