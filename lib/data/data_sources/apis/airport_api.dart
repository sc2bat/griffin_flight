import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/data/http.dart';

import '../../../env/env.dart';
import '../../core/result.dart';

class AirportApi {
  Future<Result<List<AirportDTO>>> getAirportData() async {
    final Result airportDataResult = await fetchHttp(Env.sampleAirportUrl);
    return airportDataResult.when(
      success: (response) {
        List<AirportDTO> airportList = [];
        try {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          airportList = jsonResponse.map((e) => AirportDTO.fromJson(e)).toList();
          return Result.success(airportList);
        } catch (e) {
          return Result.error('getAirportData: $e');
        }
      },
      error: (message) {
        return Result.error(message);
      }
    );
  }
}