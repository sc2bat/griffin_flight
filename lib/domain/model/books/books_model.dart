// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'books_model.freezed.dart';

part 'books_model.g.dart';


@freezed
abstract class BooksModel with _$BooksModel {
  const factory BooksModel({
    @JsonKey(name: 'book_id') required int bookId,
    @JsonKey(name: 'class_seat') String? classSeat,
    @JsonKey(name: 'status') int? status,
    @JsonKey(name: 'pay_status') int? payStatus,
    @JsonKey(name: 'pay_amount') double? payAmount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'is_deleted') int? isDeleted,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'flight_id') int? flightId,
  }) = _BooksModel;

  factory BooksModel.fromJson(Map<String, dynamic> json) =>
      _$BooksModelFromJson(json);
}
