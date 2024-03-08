import 'package:griffin/domain/repositories/books_repository.dart';

import '../../../data/core/result.dart';
import '../../model/books_model.dart';

class TotalMyBooksUseCase {
  TotalMyBooksUseCase({
    required BooksRepository booksRepository,
  }) : _booksRepository = booksRepository;

  final BooksRepository _booksRepository;

  Future<Result<List<BooksModel>>> execute(int userId) async {
    final result = await _booksRepository.getMyBooksDataApi(userId);

    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }
}
