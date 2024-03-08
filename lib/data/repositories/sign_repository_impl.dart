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
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        if (jsonData.containsKey('status')) {
          if (jsonData['status'] == 1) {
            return Result.success(jsonData);
          } else if (jsonData.containsKey('case')) {
            Map<String, dynamic> caseMap = jsonData['case'];
            for (String key in caseMap.keys) {
              if (caseMap.containsKey(key)) {
                return Result.error('${jsonData['case'][key][0]}');
              }
            }
            return const Result.error('signUp Unknown case error');
          } else {
            return Result.error('signUp error => ${jsonData['status']}');
          }
        } else {
          return const Result.error('signUp error');
        }
      } else {
        return Result.error('http error => ${response.statusCode}');
      }
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
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        if (jsonData is Map<String, dynamic> &&
            jsonData.containsKey('status')) {
          return const Result.error('Please verify your signIn information');
        } else {
          return Result.success(UserDTO.fromJson(jsonData[0]));
        }
      } else {
        return Result.error('http error => ${response.statusCode}');
      }
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<Map<String, dynamic>>> signOut() async {
    String url = '${Env.griffinAccountUrl}/logout/';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        return Result.success(jsonDecode(response.body));
      } else {
        return Result.error('http error => ${response.statusCode}');
      }
    } catch (e) {
      return Result.error('$e');
    }
  }
}
