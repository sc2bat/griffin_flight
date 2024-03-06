import 'dart:convert';

import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/data_sources/apis/airport_api.dart';
import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/data/mappers/airport_mapper.dart';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/env/env.dart';
import 'package:http/http.dart' as http;

class AirportRepositoryImpl implements AirportRepository {
  @override
  Future<Result<List<AirportModel>>> getAirportData() async {
    // AirportApi 클래스의 getAirportFromGit 함수를 호출해서 Aiport들의 정보를 받아옴.
    // AirportDTO 객체의 리스트를 줌.
    final result = await AirportApi().getAirportData();

    return result.when(
      success: (data) {
        try {
          List<AirportModel> airportModelList =
              data.map((e) => AirportMapper.fromDTO(e)).toList();

          // List<AirportModel> tempList = [];
          // // data는 List<AirportDTO> 다.
          // for (int i = 0; i < data.length; i++) {
          //   // AirportMapper의 fromDTO 함수 기능을 통해서 데이터를 AirportModel로 변환.
          //   AirportModel tempAirportModel = AirportMapper.fromDTO(data[i]);
          //
          //   // 우리가 넘겨줄 tempList에다가 추가.
          //   tempList.add(tempAirportModel);
          // }

          return Result.success(airportModelList);
        } catch (e) {
          return Result.error('airportRepositoryImpl $e');
        }
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  @override
  Future<Result<List<AirportDTO>>> getAirportListData() async {
    try {
      String url = '${Env.griffinGetUrl}/airports/';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        List<AirportDTO> airportDTOList =
            jsonData.map((e) => AirportDTO.fromJson(e)).toList();

        return Result.success(airportDTOList);
      } else {
        return Result.error('response.statusCode => ${response.statusCode}');
      }
    } catch (e) {
      return Result.error('getAirportListData error => $e');
    }
  }
}
