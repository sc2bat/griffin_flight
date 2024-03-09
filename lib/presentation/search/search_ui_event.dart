import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_ui_event.freezed.dart';

@freezed
sealed class SearchUiEvent<T> with _$SearchUiEvent<T> {
  const factory SearchUiEvent.showSnackBar(String message) = ShowSnackBar;
  const factory SearchUiEvent.searchSuccess() = SearchSuccess;
}
