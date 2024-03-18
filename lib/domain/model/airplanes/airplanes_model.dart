import 'package:freezed_annotation/freezed_annotation.dart';

part 'airplanes_model.freezed.dart';
part 'airplanes_model.g.dart';

@freezed
abstract class AirplanesModel with _$AirplanesModel {
  const factory AirplanesModel({
    @JsonKey(name: 'airplane_id') required int airplaneId,
    @JsonKey(name: 'first_class_seat') required int firstClassSeat,
    @JsonKey(name: 'business_class_seat') required int businessClassSeat,
    @JsonKey(name: 'economy_class_seat') required int economyClassSeat,
    @JsonKey(name: 'is_deleted') required int isDeleted,
  }) = _AirplanesModel;

  factory AirplanesModel.fromJson(Map<String, dynamic> json) => _$AirplanesModelFromJson(json);
}
