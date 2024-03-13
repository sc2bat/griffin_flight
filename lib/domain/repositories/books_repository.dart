
import 'package:griffin/domain/model/books/books_model.dart';
import '../../data/core/result.dart';
import '../../data/dtos/books_dto.dart';

abstract interface class BooksRepository {
  Future<Result<List<BooksModel>>> getMyBooksDataApi(int userId);
  Future<Result<BooksDTO>> insertBooks(BooksDTO books);
}
