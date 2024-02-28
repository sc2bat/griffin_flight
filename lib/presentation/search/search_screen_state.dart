import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:griffin/domain/model/airport_model.dart';



part 'search_screen_state.freezed.dart';

part 'search_screen_state.g.dart';

@freezed
class SearchScreenState with _$SearchScreenState {
  const factory SearchScreenState({
    @Default([]) List<AirportModel> airportData,
    @Default(false) bool isLoading,

  }) = _SearchScreenState;

  factory SearchScreenState.fromJson(Map<String, Object?> json)
  => _$SearchScreenStateFromJson(json);
}