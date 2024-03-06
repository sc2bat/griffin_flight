import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/mappers/user_mapper.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';
import 'package:griffin/domain/repositories/sign_repository.dart';

class SignInUseCase {
  SignInUseCase({
    required SignRepository signRepository,
  }) : _signRepository = signRepository;
  final SignRepository _signRepository;

  Future<Result<UserAccountModel>> execute(
      String userName, String password) async {
    final result = await _signRepository.signIn(userName, password);

    return result.when(
      success: (data) => Result.success(UserMapper.mapDTOToModel(data)),
      error: (message) => Result.error(message),
    );
  }
}
