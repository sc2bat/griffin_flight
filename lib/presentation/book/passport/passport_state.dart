import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:griffin/data/dtos/passport_dto.dart';
import 'package:griffin/domain/model/books/books_model.dart';
import 'package:griffin/domain/model/passport/passport_model.dart';
import '../../../domain/model/user/user_account_model.dart';

part 'passport_state.freezed.dart';
part 'passport_state.g.dart';

@freezed
class PassportState with _$PassportState {
  factory PassportState({
    @Default(false) bool isLoading,
    @Default(0) int numberOfPeople,
    @Default(0.0) double totalFare,
    PassportModel? passportModel,
    UserAccountModel? userAccountModel,
    @Default([]) List<BooksModel> departureBookList,
    @Default([]) List<BooksModel> arrivalBookList,
    @Default([]) List<PassportDTO> passportDTOList,
  }) = _PassportState;

  factory PassportState.fromJson(Map<String, dynamic> json) =>
      _$PassportStateFromJson(json);
}
