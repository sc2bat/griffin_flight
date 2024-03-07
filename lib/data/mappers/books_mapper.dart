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
}
