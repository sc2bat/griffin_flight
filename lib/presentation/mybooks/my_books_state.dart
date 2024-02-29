import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/model/payment_model.dart';


part 'my_books_state.freezed.dart';

part 'my_books_state.g.dart';

@freezed
class MyBooksState with _$MyBooksState {
  const factory MyBooksState({
    @Default([]) List<PaymentModel> myBooksList,
    @Default(false) bool isLoading,
  }) = _MyBooksState;
  
  factory MyBooksState.fromJson(Map<String, dynamic> json) => _$MyBooksStateFromJson(json); 
}