import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/user_dto.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';

abstract interface class SessionRepository {
  Future<Result<UserDTO>> getSession();
  Future<Result<void>> storeSession(UserDTO userDTO);
  Future<Result<void>> updateSession(UserAccountModel userAccountModel);
  Future<Result<void>> deleteSession();
}
