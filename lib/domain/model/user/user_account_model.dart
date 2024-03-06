// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_account_model.freezed.dart';
part 'user_account_model.g.dart';

@freezed
abstract class UserAccountModel with _$UserAccountModel {
  factory UserAccountModel({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'user_name') required String userName,
    required String email,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'is_deleted') required int isDeleted,
  }) = _UserAccountModel;

  factory UserAccountModel.fromJson(Map<String, dynamic> json) =>
      _$UserAccountModelFromJson(json);
}
