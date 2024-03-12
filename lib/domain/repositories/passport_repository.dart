import '../../data/dtos/passport_dto.dart';
import '../../data/core/result.dart';

abstract interface class PassportRepository {
  Future<Result<PassportDTO>> insertPassport(PassportDTO passport);
}

