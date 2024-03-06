import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';

part 'mypage_state.freezed.dart';

@freezed
class MypageState with _$MypageState {
  const factory MypageState({
    @Default(false) bool isLoading,
    @Default([true, false]) List<bool> selectedPage,
    UserAccountModel? userAccountModel,
    @Default([]) List<Map<String, dynamic>> upcomingList,
    @Default([]) List<Map<String, dynamic>> pastList,
  }) = _MypageState;
}
