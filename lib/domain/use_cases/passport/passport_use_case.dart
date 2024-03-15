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
    required List<int> arrivalbookId,
    required List<int> departurebookId,
    required List<PassportDTO> passportDTOList,
  }) async {
    try {
      final List<PassportModel> list = [];
      for (int i = 0; i < passportDTOList.length; i++) {
        PassportDTO departurePassportDTO = PassportDTO(
          gender: passportDTOList[i].gender,
          firstName: passportDTOList[i].firstName,
          lastName: passportDTOList[i].lastName,
          birthday: passportDTOList[i].birthday,
          email: passportDTOList[i].email,
          phone: passportDTOList[i].phone,
          bookId: departurebookId[i],
          isDeleted: 0,
        );
        final departureResult =
            await _passportRepository.insertPassport(departurePassportDTO);

        switch (departureResult) {
          case Success<PassportDTO>():
            list.add(PassportMapper.fromDTO(departureResult.data));
          case Error<PassportDTO>():
            return Result.error(departureResult.message);
        }
        PassportDTO arrivalPassportDTO = PassportDTO(
          gender: passportDTOList[i].gender,
          firstName: passportDTOList[i].firstName,
          lastName: passportDTOList[i].lastName,
          birthday: passportDTOList[i].birthday,
          email: passportDTOList[i].email,
          phone: passportDTOList[i].phone,
          bookId: arrivalbookId[i],
          isDeleted: 0,
        );
        final arrivalResult =
            await _passportRepository.insertPassport(arrivalPassportDTO);

        switch (arrivalResult) {
          case Success<PassportDTO>():
            list.add(PassportMapper.fromDTO(arrivalResult.data));
          case Error<PassportDTO>():
            return Result.error(arrivalResult.message);
        }
      }
      return Result.success(list);
    } catch (e) {
      return Result.error('$e');
    }
  }
}
