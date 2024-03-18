import 'dart:convert';

import 'package:griffin/data/http.dart';

import '../../../env/env.dart';
import '../../core/result.dart';
import '../../dtos/airplanes_dto.dart';

class AirplanesApi {
  Future<Result<List<AirplanesDTO>>> getAirplanesData() async {
    final Result airPlanesDataResult =
    await fetchHttp('${Env.griffinGetUrl}/airplanes/');
    return airPlanesDataResult.when(success: (response) {
      List<AirplanesDTO> airplanesList = [];
      try {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        airplanesList = jsonResponse.map((e) => AirplanesDTO.fromJson(e)).toList();
        return Result.success(airplanesList);
      } catch (e) {
        return Result.error('getAirplaneData: $e');
      }
    }, error: (message) {
      return Result.error(message);
    });
  }
}
