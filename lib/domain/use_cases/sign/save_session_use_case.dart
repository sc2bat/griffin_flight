import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/mappers/user_mapper.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';
import 'package:griffin/domain/repositories/session_repository.dart';

class SaveSessionUseCase {
  SaveSessionUseCase({
    required SessionRepository sessionRepository,
  }) : _sessionRepository = sessionRepository;
  final SessionRepository _sessionRepository;

  Future<Result<void>> execute(UserAccountModel userAccountModel) async {
    final result = await _sessionRepository
        .storeSession(UserMapper.mapModelToDTO(userAccountModel));
    return result.when(
      success: (_) => const Result.success(null),
      error: (message) => Result.error(message),
    );
  }
}
