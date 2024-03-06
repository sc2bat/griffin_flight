import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/mappers/user_mapper.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';
import 'package:griffin/domain/repositories/user_repository.dart';

class SplashGetUserInfoUseCase {
  SplashGetUserInfoUseCase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;
  final UserRepository _userRepository;

  Future<Result<UserAccountModel>> execute(int userId) async {
    final result = await _userRepository.getUserInfo(userId);
    return result.when(
      success: (data) => Result.success(UserMapper.mapDTOToModel(data)),
      error: (message) => Result.error(message),
    );
  }
}
