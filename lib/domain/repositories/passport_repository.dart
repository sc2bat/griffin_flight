import '../model/passport/passport_model.dart';
import '../../data/core/result.dart';

abstract interface class PassportRepository {
  Future<Result<void>> getPassport(PassportModel passport);
  Future<Result<void>> insertPassport(PassportModel passport);
  Future<Result<void>> updatePassport(PassportModel passport);
  Future<Result<void>> deletePassport(PassportModel passport);
}