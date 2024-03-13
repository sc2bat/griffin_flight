import 'dart:convert';
import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/env/env.dart';

import '../../http.dart';

class FlightApi {
  Future<Result<List<FlightDTO>>> getFlightData() async {
    final Result flightDataResult = await fetchHttp(Env.dumpFlightUrl);
    return flightDataResult.when(
      success: (response) {
        List<FlightDTO> flightList = [];
        try {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          flightList = jsonResponse.map((e) => FlightDTO.fromJson(e)).toList();
          return Result.success(flightList);
        } catch (e) {
          return Result.error('getFlightData: $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
