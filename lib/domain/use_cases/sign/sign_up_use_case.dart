import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/sign_dto.dart';
import 'package:griffin/domain/repositories/sign_repository.dart';

class SignUpUseCase {
  SignUpUseCase({
    required SignRepository signRepository,
  }) : _signRepository = signRepository;
  final SignRepository _signRepository;

  Future<Result<void>> execute(
      String email, String userName, String password1, String password2) async {
    SignUpDTO signUpDTO = SignUpDTO(
      email: email,
      userName: userName,
      password1: password1,
      password2: password2,
    );
    final result = await _signRepository.signUp(signUpDTO);

    return result.when(
      success: (data) {
        if (data['status'] != 0) {
          return const Result.success(null);
        } else {
          return Result.error(data['case']);
        }
      },
      error: (message) => Result.error(message),
    );
  }
}
