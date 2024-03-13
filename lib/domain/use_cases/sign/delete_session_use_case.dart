import 'package:griffin/data/core/result.dart';
import 'package:griffin/domain/repositories/session_repository.dart';

class DeleteSessionUseCase {
  DeleteSessionUseCase({
    required SessionRepository sessionRepository,
  }) : _sessionRepository = sessionRepository;
  final SessionRepository _sessionRepository;

  Future<Result<void>> execute() async {
    final result = await _sessionRepository.deleteSession();
    return result.when(
      success: (_) => const Result.success(null),
      error: (message) => Result.error(message),
    );
  }
}
