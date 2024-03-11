import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/books_api.dart';
import 'package:griffin/data/dtos/books_dto.dart';
import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/domain/model/books/books_model.dart';
import 'package:http/http.dart' as http;

import '../../domain/repositories/books_repository.dart';
import '../../env/env.dart';
import '../../utils/simple_logger.dart';
import '../mappers/books_mapper.dart';

class BooksRepositoryImpl implements BooksRepository {
  //get
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

//post
  @override
  Future<Result<BooksDTO>> insertBooks(BooksDTO books) async {
    logger.info(Env.griffinPostUrl);

    final url = Uri.parse('${Env.griffinGetUrl}/books/');
    logger.info(url);
    String jsonData = jsonEncode(books);

    logger.info(jsonData);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonData,
      );

      if (response.statusCode == 201) {
        logger.info('statusCode == 201');
        logger.info(response.body);
        final jsonString = jsonDecode(response.body);
        return Result.success(BooksDTO.fromJson(jsonString));
      } else {
        logger.info('response.statusCode => ${response.statusCode}');
        logger.info(response.body);
        return Result.error('response.statusCode => ${response.statusCode}');
      }
    } catch (e) {
      logger.info('error => $e');
      return Result.error('error => $e');
    }
  }
}
