import 'package:griffin/data/dtos/passport_dto.dart';
import 'package:griffin/domain/model/passport/passport_model.dart';
import 'package:griffin/domain/repositories/passport_repository.dart';

import '../../../data/core/result.dart';
import '../../../data/mappers/passport_mapper.dart';

class PassportUsecase {
  PassportUsecase({
    required PassportRepository passportRepository,
  }) : _passportRepository = passportRepository;

  final PassportRepository _passportRepository;

  Future<Result<List<PassportModel>>> execute({
    required List<int> bookIdList,
    required PassportDTO paramPassportDTO,
  }) async {
    try {
      final List<PassportModel> list = [];
      for (int value in bookIdList) {
        PassportDTO passportDTO = PassportDTO(
          gender: paramPassportDTO.gender,
          firstName: paramPassportDTO.firstName,
          lastName: paramPassportDTO.lastName,
          birthday: paramPassportDTO.birthday,
          email: paramPassportDTO.email,
          phone: paramPassportDTO.phone,
          bookId: value,
          isDeleted: 0,
        );
        final result = await _passportRepository.insertPassport(passportDTO);

        switch (result) {
          case Success<PassportDTO>():
            list.add(PassportMapper.fromDTO(result.data));
          case Error<PassportDTO>():
            return Result.error(result.message);
        }
      }
      return Result.success(list);
    } catch (e) {
      return Result.error('$e');
    }
  }
}
