import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/http.dart';
import 'package:griffin/env/env.dart';

import '../../dtos/payment_data_dto.dart';

class PaymentApi {
  Future<Result<List<PaymentData>>> getMyBooksForPayDataFromGit(int userId) async {
    final Result paymentDataFromGitResult = await fetchHttp('${Env.griffinGetUrl}/payment/');
    return paymentDataFromGitResult.when(
      success: (response) {
        List<PaymentData> paymentDataList = [];
        try {
          final List<dynamic> jsonResponse = jsonDecode(response.body)['result'];
          List<PaymentData> jsonList =
              jsonResponse.map((e) => PaymentData.fromJson(e)).toList();
          paymentDataList = jsonList.where((e) => e.userId == userId).toList();
          return Result.success(paymentDataList);
        } catch (e) {
          return Result.error('getPaymentDataListFromGit $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );

  }
}
