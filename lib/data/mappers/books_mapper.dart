import 'package:griffin/domain/model/books_model.dart';

import '../dtos/books_dto.dart';

class BooksMapper {
  static BooksDTO toDTO(BooksModel model) {
    return BooksDTO(
        bookId: model.bookId,
        classSeat: model.classSeat,
        status: model.status,
        payStatus: model.payStatus,
        payAmount: model.payAmount,
        createdAt: model.createdAt,
        isDeleted: model.isDeleted,
        userId: model.userId,
        flightId: model.flightId);
  }

  static BooksModel fromDTO(BooksDTO dto) {
    return BooksModel(
        bookId: dto.bookId ?? 0,
        userId: dto.userId ?? 0,
        flightId: dto.flightId ?? 0,
        classSeat: dto.classSeat ?? '',
        status: dto.status ?? 0,
        payStatus: dto.payStatus ?? 0,
        payAmount: dto.payAmount ?? 0.0,
        createdAt: dto.createdAt ?? '',
        isDeleted: dto.isDeleted ?? 0);
  }
}
