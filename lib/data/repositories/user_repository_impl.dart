import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/user_dto.dart';
import 'package:griffin/data/http.dart';
import 'package:griffin/domain/repositories/user_repository.dart';
import 'package:griffin/env/env.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<Result<UserDTO>> getUserInfo(int userId) async {
    const url = '${Env.griffinGetUrl}/users/';

    try {
      final response = await fetchHttpWithParam(
        url: url,
        paramData: {
          'user_id': userId,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Result.success(UserDTO.fromJson(data[0]));
      } else {
        return Result.error(
            'response.statusCode error => ${response.statusCode}');
      }
    } catch (e) {
      return Result.error('getUserInfo error => $e');
    }
  }
}
