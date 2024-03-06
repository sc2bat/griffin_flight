import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/sign_dto.dart';
import 'package:griffin/data/dtos/user_dto.dart';
import 'package:griffin/domain/repositories/sign_repository.dart';
import 'package:griffin/env/env.dart';
import 'package:http/http.dart' as http;

class SignRepositoryImpl implements SignRepository {
  @override
  Future<Result<Map<String, dynamic>>> signUp(SignUpDTO signUpDTO) async {
    String url = '${Env.griffinAccountUrl}/signup/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: signUpDTO.toJson(),
      );

      return Result.success(jsonDecode(response.body));
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<UserDTO>> signIn(String userName, String password) async {
    String url = '${Env.griffinAccountUrl}/login/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'username': userName,
          'password': password,
        },
      );
      return Result.success(UserDTO.fromJson(jsonDecode(response.body)[0]));
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> signOut() async {
    String url = '${Env.griffinAccountUrl}/logout/';
    try {
      final response = await http.post(Uri.parse(url));
      return Result.success(jsonDecode(response.body));
    } catch (e) {
      return Result.error('$e');
    }
  }
}
