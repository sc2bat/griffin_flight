import 'package:griffin/data/dtos/books_dto.dart';
import 'package:griffin/domain/model/books/books_model.dart';
import '../../../data/core/result.dart';
import '../../../data/mappers/books_mapper.dart';
import '../../../utils/simple_logger.dart';
import '../../repositories/seat_repository.dart';

class SeatUseCase {
  SeatUseCase({
    required SeatRepository seatRepository,
  }) : _seatRepository = seatRepository;

  final SeatRepository _seatRepository;

  Future<Result<List<BooksModel>>> execute(List<BooksDTO> booksDTOList) async {
    List<BooksModel> booksModelList = [];
    for (int i = 0; i < booksDTOList.length; i++) {
      logger.info(booksDTOList[i]);
      final result = await _seatRepository.updateSeat(booksDTOList[i]);

      switch (result) {
        case Success<BooksDTO>():
          booksModelList.add(BooksMapper.fromDTO(result.data));
        case Error<BooksDTO>():
          return Result.error(result.message);
      }
    }
    return Result.success(booksModelList);
  }
}
