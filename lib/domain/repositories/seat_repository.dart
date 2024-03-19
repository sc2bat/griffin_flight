
import 'package:griffin/data/dtos/books_dto.dart';
import '../../data/core/result.dart';

abstract interface class SeatRepository {
  Future<Result<BooksDTO>> updateSeat(BooksDTO booksDTO);
}

