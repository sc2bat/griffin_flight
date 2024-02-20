
import 'package:freezed_annotation/freezed_annotation.dart';
part 'flights_model.freezed.dart';
part 'flights_model.g.dart';

@freezed
abstract class FlightsModel with _$FlightsModel {
  factory FlightsModel({
    @JsonKey(name: 'flight_id') int? flightId,
    @JsonKey(name: 'flight_date') required String flightDate,
    @JsonKey(name: 'departure_time') required String departureTime,
    @JsonKey(name: 'arrival_time') required String arrivalTime,
    @JsonKey(name: 'departure_loc') required int departureLoc,
    @JsonKey(name: 'arrival_loc') required int arrivalLoc,
    @JsonKey(name: 'airplane_id') int? airplaneId,
    @JsonKey(name: 'created_at') int? createdAt,
    @JsonKey(name: 'is_deleted') bool? isDeleted,
  }) = _FlightsModel;

  factory FlightsModel.fromJson(Map<String, dynamic> json) =>
      _$FlightsModelFromJson(json);
}