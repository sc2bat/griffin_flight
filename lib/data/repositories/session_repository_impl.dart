import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/user_dto.dart';
import 'package:griffin/domain/model/user/user_account_model.dart';
import 'package:griffin/domain/repositories/session_repository.dart';
import 'package:griffin/utils/simple_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionRepositoryImpl implements SessionRepository {
  @override
  Future<Result<void>> storeSession(UserDTO userDTO) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String session = jsonEncode(userDTO.toJson());

      await prefs.setString('session', session);
      return const Result.success(null);
    } catch (e) {
      logger.info('SessionRepositoryImpl storeSession');
      return Result.error('storeSession error => $e');
    }
  }

  @override
  Future<Result<UserDTO>> getSession() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? session = prefs.getString('session');
      if (session != null) {
        UserDTO userDTO = UserDTO.fromJson(jsonDecode(session));
        return Result.success(userDTO);
      }
      // session 이 없으면 guest 데이터 부여
      return Result.success(
        UserDTO(
            userId: 0,
            userName: 'guest',
            email: 'guest@guest.com',
            createdAt: DateTime.now(),
            isDeleted: 0),
      );
    } catch (e) {
      logger.info('SessionRepositoryImpl storeSession');
      return Result.error('getSession error => $e');
    }
  }

  @override
  Future<Result<void>> updateSession(UserAccountModel userAccountModel) {
    // TODO: implement updateSession
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteSession() {
    // TODO: implement deleteSession
    throw UnimplementedError();
  }
}
