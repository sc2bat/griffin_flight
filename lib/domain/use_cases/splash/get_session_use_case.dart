import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/mappers/user_mapper.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';
import 'package:griffin/domain/repositories/session_repository.dart';

class GetSessionUseCase {
  GetSessionUseCase({
    required SessionRepository sessionRepository,
  }) : _sessionRepository = sessionRepository;
  final SessionRepository _sessionRepository;

  Future<Result<UserAccountModel>> execute() async {
    final result = await _sessionRepository.getSession();
    return result.when(
      success: (data) => Result.success(UserMapper.mapDTOToModel(data)),
      error: (message) => Result.error(message),
    );
  }
}
