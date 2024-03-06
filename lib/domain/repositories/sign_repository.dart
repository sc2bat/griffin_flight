import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/sign_dto.dart';
import 'package:griffin/data/dtos/user_dto.dart';

abstract interface class SignRepository {
  Future<Result<Map<String, dynamic>>> signUp(SignUpDTO signUpDTO);
  Future<Result<UserDTO>> signIn(String userName, String password);
  Future<Result<Map<String, dynamic>>> signOut();
}
