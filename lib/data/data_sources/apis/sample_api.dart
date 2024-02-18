import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/data/http.dart';
import 'package:griffin/env/env.dart';

class SampleApi {
  Future<Result<List<AirportDTO>>> getSampleAirportFromGit() async {
    final Result sampleAirportFromGitResult =
        await fetchHttp(Env.sampleAirportUrl);
    return sampleAirportFromGitResult.when(
      success: (response) {
        List<AirportDTO> airportList = [];

        try {
          final List<dynamic> jsonResponse = jsonDecode(response.body);
          airportList =
              jsonResponse.map((e) => AirportDTO.fromJson(e)).toList();
          return Result.success(airportList);
        } catch (e) {
          return Result.error('getSampleAirportFromGit $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
