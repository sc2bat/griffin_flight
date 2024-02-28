import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

@freezed
abstract class BookModel with _$BookModel {
  const factory BookModel({
    @JsonKey(name: 'book_id') required int bookId,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'flight_id') required int flightId,
    @JsonKey(name: 'flight_class') required String flightClass,
    required int status,
    @JsonKey(name: 'pay_status') required int payStatus,
    @JsonKey(name: 'pay_amount') required double payAmount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'is_deleted') required bool isDeleted,
  }) = _BookModel;

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
}