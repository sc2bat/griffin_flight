import 'package:griffin/data/mappers/books_mapper.dart';
import '../../../data/core/result.dart';
import '../../../data/dtos/books_dto.dart';
import '../../model/books/books_model.dart';
import '../../repositories/books_repository.dart';

class BooksUseCase {
  BooksUseCase({
    required BooksRepository booksRepository,
  }) : _booksRepository = booksRepository;

  final BooksRepository _booksRepository;

  Future<Result<BooksModel>> execute({
    required int userId,
    required int flightId,
    required double payAmount,
  }) async {
    try {
      BooksDTO booksDTO = BooksDTO(
        userId: userId,
        flightId: flightId,
        payAmount: payAmount,
        classSeat: 'none',
        status: 0,
        payStatus: 0,
        isDeleted: 0,
      );
      final result = await _booksRepository.insertBooks(booksDTO);

      switch (result) {
        case Success<BooksDTO>():
          return Result.success(BooksMapper.fromDTO(result.data));
        case Error<BooksDTO>():
          return Result.error(result.message);
      }
    } catch (e) {
      return Result.error('$e');
    }
    throw Exception('Books Usecase Error');
  }
}
