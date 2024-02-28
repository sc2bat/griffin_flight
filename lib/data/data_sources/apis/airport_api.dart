import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/data/http.dart';
import 'package:griffin/env/env.dart';

class AirportApi {
  Future<Result<List<AirportDTO>>> getAirportApi() async {
    final Result airportapi =
    await fetchHttp(Env.dumpAirportUrl);
    return airportapi.when(
      success: (response) {
        List<AirportDTO> airportList = [];

        try {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          airportList =
              jsonResponse.map((e) => AirportDTO.fromJson(e)).toList();
          return Result.success(airportList);
        } catch (e) {
          return Result.error('getAirportFromGit $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}