import 'package:griffin/domain/model/books/books_model.dart';

import '../../data/core/result.dart';

abstract interface class BooksRepository {
  Future<Result<List<BooksModel>>> getMyBooksDataApi(int userId);
}
