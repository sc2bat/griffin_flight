import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/user_dto.dart';

abstract interface class UserRepository {
  Future<Result<UserDTO>> getUserInfo(int userId);
}
