import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/passport_dto.dart';
import 'package:griffin/data/repositories/passport_repository_impl.dart';
import 'package:griffin/utils/simple_logger.dart';

void main() {
  test('passport repository impl post airport dto test', () async {
    PassportRepositoryImpl passportRepositoryImpl = PassportRepositoryImpl();
    PassportDTO passportDTO = PassportDTO(
      gender: 0,
      firstName: 'a',
      lastName: 'b',
      email: 'ddd.com',
      birthday: '20240312',
      phone: '0',
      bookId: 36,
      isDeleted: 0,
    );

    final result = await passportRepositoryImpl.insertPassport(passportDTO);
    switch (result) {
      case Success<PassportDTO>():
         logger.info(result.data);
        break;
      case Error<PassportDTO>():
        logger.info(result.message);
        break;
    }

  });
}
