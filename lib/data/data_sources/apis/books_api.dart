import 'dart:convert';

import 'package:griffin/data/http.dart';

import '../../../env/env.dart';
import '../../core/result.dart';
import '../../dtos/books_dto.dart';

class BooksApi {
  Future<Result<List<BooksDTO>>> getBooksData(int userId) async {
    final Result booksDataResult =
        await fetchHttp('${Env.griffinGetUrl}/books/');
    return booksDataResult.when(success: (response) {
      List<BooksDTO> booksList = [];
      List<BooksDTO> myBooksList = [];
      try {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        booksList = jsonResponse.map((e) => BooksDTO.fromJson(e)).toList();
        myBooksList = booksList.where((e) => e.userId == userId).toList();
        return Result.success(myBooksList);
      } catch (e) {
        return Result.error('getBooksData: $e');
      }
    }, error: (message) {
      return Result.error(message);
    });
  }
}
