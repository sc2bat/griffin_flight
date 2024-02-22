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

// from을 누를 때 마다
// AppManager 싱글턴 클래스
/*
Class AppManager {
  List<AirportDTO> airportDTOModels = <AirportDTO>[];

  getAirport() async {
    airportDTOModels.claer();
    airportDTOModels = await SampleApi.getSampleAirportFromGit();

    for (int i = 0; i <= airportDTOModels.length; i++) {
      airportDTOModels[i].
    }
  }

  getAirport(); // 데이터를 받아오기.
  // 데이터를 받아오면 정보가 airportDTOModels에 들어가있어요.
}*/


// 0. sliding up panel이 올라가는 순간 또는 검색을 하는 순간
// InkWell
// 검색을 하라고 누른 순간
// 1. getSampleAirportFromGit() 목업 데이터를 받아와서 "내부에 저장"
// 2. 저장된 데이터를 가지고
