import 'package:griffin/domain/repositories/passport_repository.dart';

class PassportUsecase {
  final PassportRepository _passportRepository;

  PassportUsecase({
    required PassportRepository passportRepository,
  }) : _passportRepository = passportRepository;
}
