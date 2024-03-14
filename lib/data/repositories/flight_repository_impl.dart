import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/flight_api.dart';
import 'package:griffin/data/dtos/flight_dto.dart';
import 'package:griffin/data/dtos/search_dto.dart';
import 'package:griffin/data/http.dart';
import 'package:griffin/data/mappers/flight_mapper.dart';
import 'package:griffin/domain/model/flight/flight_model.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/domain/repositories/flight_repository.dart';
import 'package:griffin/env/env.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlightRepositoryImpl implements FlightRepository {
  @override
  Future<Result<List<FlightModel>>> getFlightDataApi() async {
    final result = await FlightApi().getFlightData();

    return result.when(
      success: (data) {
        try {
          List<FlightModel> flightModelList =
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
  Future<Result<Map<String, List<FlightDTO>>>> searchFlightResult(
      SearchDTO searchDTO) async {
    String url = '${Env.griffinGetUrl}/flights/search';

    try {
      final response =
          await fetchHttpWithParam(url: url, paramData: searchDTO.toJson());
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        if (jsonData.containsKey('from_flight') &&
            jsonData.containsKey('to_flight')) {
          final List<FlightDTO> fromSearchResult =
              (jsonData['from_flight'] as List<dynamic>)
                  .map((e) => FlightDTO.fromJson(e))
                  .toList();
          final List<FlightDTO> toSearchResult =
              (jsonData['to_flight'] as List<dynamic>)
                  .map((e) => FlightDTO.fromJson(e))
                  .toList();
          final Map<String, List<FlightDTO>> result = {
            'from_flight': fromSearchResult,
            'to_flight': toSearchResult,
          };
          return Result.success(result);
        } else {
          return const Result.error('Http error => jsonKey error');
        }
      } else {
        return Result.error('Http error => ${response.statusCode}');
      }
    } catch (e) {
      return Result.error('$e');
    }
  }

  @override
  Future<Result<FlightResultModel>> getSearchFlightResult(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? result = prefs.getString(key);
      if (result != null) {
        return Result.success(FlightResultModel.fromJson(jsonDecode(result)));
      }
      return const Result.error('getSearchResult result null error');
    } catch (e) {
      return Result.error('getSearchResult error => $e');
    }
  }

  @override
  Future<Result<void>> resetSearchResult() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.remove('number_of_people');
      await prefs.remove('seat_class');
      await prefs.remove('from_flight');
      await prefs.remove('to_flight');
      return const Result.success(null);
    } catch (e) {
      return Result.error('resetSearchResult error => $e');
    }
  }

  @override
  Future<Result<void>> saveSearchResult(
      String key, FlightResultModel flightResultModel) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final result =
          await prefs.setString(key, jsonEncode(flightResultModel.toJson()));
      return result
          ? const Result.success(null)
          : const Result.error('saveSearchResult error');
    } catch (e) {
      return Result.error('saveSearchResult error => $e');
    }
  }

  @override
  Future<Result<String>> getSearchResultData(String key) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? result = prefs.getString(key);
      if (result != null) {
        return Result.success(result);
      }
      return const Result.error('getSearchResult result null error');
    } catch (e) {
      return Result.error('getSearchResult error => $e');
    }
  }

  @override
  Future<Result<void>> saveSeatClass(String seatClass) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final result = await prefs.setString('seat_class', seatClass);

      return result
          ? const Result.success(null)
          : const Result.error('saveSeatClass Error');
    } catch (e) {
      return Result.error('saveSeatClass Error => $e');
    }
  }

  @override
  Future<Result<void>> saveNumberOfPeople(int numberOfPeople) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final result =
          await prefs.setString('number_of_people', '$numberOfPeople');

      return result
          ? const Result.success(null)
          : const Result.error('saveNumberOfPeople Error');
    } catch (e) {
      return Result.error('saveNumberOfPeople Error => $e');
    }
  }
}
