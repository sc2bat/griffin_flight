import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';

part 'splash_state.freezed.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({
    @Default(false) bool isLoading,
    @Default(false) bool isRedirect,
    UserAccountModel? userAccountModel,
  }) = _SplashState;
}
