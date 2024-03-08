import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/domain/model/books/books_model.dart';

part 'pay_state.freezed.dart';
part 'pay_state.g.dart';

@freezed
class PayState with _$PayState {
  const factory PayState({
    @Default([]) List<BooksModel> totalBookItemList,
    @Default([]) List<BooksModel> paidBookItemList,
  }) = _PayState;

  factory PayState.fromJson(Map<String, dynamic> json) =>
      _$PayStateFromJson(json);
}
