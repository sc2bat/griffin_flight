import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/passport/passport_model.dart';
import 'package:griffin/presentation/book/passport/widgets/gender_widget.dart';
import '../../../domain/model/user/user_account_model.dart';
part 'passport_state.freezed.dart';
part 'passport_state.g.dart';

@freezed
class PassportState with _$PassportState {
  factory PassportState({
    @Default(false) bool isLoading,
    PassportModel? passportModel,
    UserAccountModel? userAccountModel,
    Gender? selectedGender,
    String? selectedCountry,
    DateTime? selectedDate,
  }) = _PassportState;

  factory PassportState.fromJson(Map<String, dynamic> json) =>
      _$PassportStateFromJson(json);
}
