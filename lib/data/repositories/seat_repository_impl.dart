import 'dart:convert';
import 'package:griffin/data/core/result.dart';
import 'package:http/http.dart' as http;
import '../../domain/repositories/seat_repository.dart';
import '../../env/env.dart';
import '../../utils/simple_logger.dart';
import '../dtos/books_dto.dart';

class SeatRepositoryImpl implements SeatRepository {
  @override
  Future<Result<BooksDTO>> updateSeat(BooksDTO booksDTO) async {
    logger.info(Env.griffinPostUrl);

    final url = Uri.parse('${Env.griffinGetUrl}/books/update/');
    logger.info(url);
    String jsonData = jsonEncode(booksDTO);

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
        return Result.success(BooksDTO.fromJson(jsonString[0]));
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
