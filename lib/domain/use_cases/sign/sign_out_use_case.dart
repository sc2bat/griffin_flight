import '../../../data/core/result.dart';
import '../../repositories/sign_repository.dart';

class SignOutUseCase {
  SignOutUseCase({
    required SignRepository signRepository,
  }) : _signRepository = signRepository;
  final SignRepository _signRepository;

  Future<Result<void>> execute() async {
    final result = await _signRepository.signOut();

    return result.when(
      success: (data) => const Result.success(null),
      error: (message) => Result.error(message),
    );
  }
}
