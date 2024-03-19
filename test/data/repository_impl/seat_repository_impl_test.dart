import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/dtos/books_dto.dart';
import 'package:griffin/data/repositories/seat_repository_impl.dart';

void main() {
  test('seat repository impl post book dto test', () async {
    SeatRepositoryImpl seatRepositoryImpl = SeatRepositoryImpl();
    BooksDTO booksDTO = BooksDTO(
      bookId: 133,
      classSeat: 'A8',
      status: 1,
      payAmount: 200,
    );

    await seatRepositoryImpl.updateSeat(booksDTO);
  });
}
