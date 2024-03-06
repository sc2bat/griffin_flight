import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:griffin/data/dtos/sign_dto.dart';
import 'package:griffin/env/env.dart';
import 'package:griffin/utils/simple_logger.dart';
import 'package:http/http.dart' as http;

void main() {
  test('SignRepository', () async {
    String url = '${Env.griffinAccountUrl}/signup/';
    SignUpDTO signUpDTO = SignUpDTO(
      email: 'qwer0001',
      userName: 'qwer0001',
      password1: Env.sampleAccountPassword,
      password2: Env.sampleAccountPassword,
    );
    try {
      final response = await http.post(
        Uri.parse(url),
        body: signUpDTO.toJson(),
      );

      logger.info(jsonDecode(response.body));
      logger.info(response.statusCode);
    } catch (e) {
      logger.info(e);
    }
  });

  test('login test', () async {
    String url = '${Env.griffinAccountUrl}/login/';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'username': 'qwer0000',
          'password': Env.sampleAccountPassword,
        },
      );

      logger.info(jsonDecode(response.body));
      logger.info(response.statusCode);
    } catch (e) {
      logger.info(e);
    }
  });

  test('logout test', () async {
    String url = '${Env.griffinAccountUrl}/logout/';
    try {
      final response = await http.post(Uri.parse(url));

      logger.info(jsonDecode(response.body));
      logger.info(response.statusCode);
    } catch (e) {
      logger.info(e);
    }
  });
}
