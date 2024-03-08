import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/books_api.dart';
import 'package:griffin/domain/model/books/books_model.dart';

import '../../domain/repositories/books_repository.dart';
import '../mappers/books_mapper.dart';

class BooksRepositoryImpl implements BooksRepository {
  @override
  Future<Result<List<BooksModel>>> getMyBooksDataApi(int userId) async {
    final result = await BooksApi().getBooksData(userId);

    return result.when(
      success: (data) {
        try {
          List<BooksModel> booksModelList =
              data.map((e) => BooksMapper.fromDTO(e)).toList();

          return Result.success(booksModelList);
        } catch (e) {
          return Result.error('booksRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
