import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/flight_api.dart';
import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/data/dtos/search_dto.dart';
import 'package:griffin/data/http.dart';
import 'package:griffin/data/mappers/flight_mapper.dart';
import 'package:griffin/domain/model/flights/flights_model.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/env/env.dart';

class FlightRepositoryImpl implements FlightRepository {
  @override
  Future<Result<List<FlightsModel>>> getFlightDataApi() async {
    final result = await FlightApi().getFlightData();

    return result.when(
      success: (data) {
        try {
          List<FlightsModel> flightModelList =
              data.map((e) => FlightMapper.fromDTO(e)).toList();
          return Result.success(flightModelList);
        } catch (e) {
          return Result.error('FlightRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  @override
  Future<Result<Map<String, dynamic>>> searchFlightResult(
      SearchDTO searchDTO) async {
    String url = '${Env.griffinGetUrl}/flights/search';

    try {
      final response =
          await fetchHttpWithParam(url: url, paramData: searchDTO.toJson());
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final Map<String, dynamic> result = {};
        if (jsonData.containsKey('from_flight')) {
          final List<FlightDTO> fromSearchResult =
              (jsonData['from_flight'] as List<dynamic>)
                  .map((e) => FlightDTO.fromJson(e))
                  .toList();
          result['from_flight_result'] = fromSearchResult;
        }
        if (jsonData.containsKey('to_flight')) {
          final List<FlightDTO> toSearchResult =
              (jsonData['to_flight'] as List<dynamic>)
                  .map((e) => FlightDTO.fromJson(e))
                  .toList();
          result['to_flight_result'] = toSearchResult;
        }
        return Result.success(result);
      } else {
        return Result.error('Http error => ${response.statusCode}');
      }
    } catch (e) {
      return Result.error('$e');
    }
  }
}
