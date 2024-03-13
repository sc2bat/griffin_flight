// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'passport_model.freezed.dart';

part 'passport_model.g.dart';

@freezed
abstract class PassportModel with _$PassportModel {
  const factory PassportModel({
    @JsonKey(name: 'passport_id') required int passportId,
    int? gender,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    String? email,
    String? phone,
    String? birthday,
    @JsonKey(name: 'book_id') int? bookId,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'is_deleted') int? isDeleted,
  }) = _PassportModel;

  factory PassportModel.fromJson(Map<String, dynamic> json) =>
      _$PassportModelFromJson(json);
}
