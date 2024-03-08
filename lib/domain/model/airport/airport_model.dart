// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'airport_model.freezed.dart';
part 'airport_model.g.dart';

@freezed
abstract class AirportModel with _$AirportModel {
  factory AirportModel({
    @JsonKey(name: 'airport_id') required int airportId,
    @JsonKey(name: 'airport_code') required String airportCode,
    @JsonKey(name: 'airport_name') required String airportName,
    required double latitude,
    required double longitude,
    required String country,
    @JsonKey(name: 'is_deleted') required int isDeleted,
  }) = _AirportModel;

  factory AirportModel.fromJson(Map<String, dynamic> json) =>
      _$AirportModelFromJson(json);
}
