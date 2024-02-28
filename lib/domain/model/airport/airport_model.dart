// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'airport_model.freezed.dart';
part 'airport_model.g.dart';

@freezed
abstract class AirportModel with _$AirportModel {
  factory AirportModel({
    @JsonKey(name: 'airport_id') required String airportId,
    @JsonKey(name: 'airport_code') required String airportCode,
    @JsonKey(name: 'airport_name') required String airportName,
    double? latitude,
    double? longitude,
    String? country,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'is_deleted') bool? isDeleted,
  }) = _AirportModel;

  factory AirportModel.fromJson(Map<String, dynamic> json) =>
      _$AirportModelFromJson(json);
}
