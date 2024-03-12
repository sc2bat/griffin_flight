import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/passport/passport_model.dart';
import '../../../domain/model/user/user_account_model.dart';
part 'passport_state.freezed.dart';
part 'passport_state.g.dart';

@freezed
class PassportState with _$PassportState {
  factory PassportState({
    PassportModel? passportModel,
    UserAccountModel? userAccountModel,
  }) = _PassportState;

  factory PassportState.fromJson(Map<String, dynamic> json) =>
      _$PassportStateFromJson(json);
}
