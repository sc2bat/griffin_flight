import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_ui_event.freezed.dart';

@freezed
abstract class SignUiEvent<T> with _$SignUiEvent<T> {
  const factory SignUiEvent.showSnackBar(String message) = ShowSnackBar;
}
