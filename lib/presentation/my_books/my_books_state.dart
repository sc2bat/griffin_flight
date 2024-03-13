import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/payment/payment_model.dart';
import '../../domain/model/user/user_account_model.dart';

part 'my_books_state.freezed.dart';
part 'my_books_state.g.dart';

@freezed
class MyBooksState with _$MyBooksState {
  const factory MyBooksState({
    @Default([]) List<PaymentModel> myBooksList,
    UserAccountModel? userAccountModel,
    @Default(false) bool isLoading,
  }) = _MyBooksState;

  factory MyBooksState.fromJson(Map<String, dynamic> json) =>
      _$MyBooksStateFromJson(json);
}
