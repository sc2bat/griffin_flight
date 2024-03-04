import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/airport_model.dart';

part 'search_state.freezed.dart';

part 'search_state.g.dart';

@freezed
class SearchState with _$SearchState {
  factory SearchState({
    @Default([]) List<AirportModel> airportList,

  }) = _SearchState;

  factory SearchState.fromJson(Map<String, dynamic> json) => _$SearchStateFromJson(json);
}