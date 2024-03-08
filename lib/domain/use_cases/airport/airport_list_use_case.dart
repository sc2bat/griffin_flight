import 'package:griffin/data/core/result.dart';
import 'package:griffin/data/dtos/airport_dto.dart';
import 'package:griffin/data/mappers/airport_mapper.dart';
import 'package:griffin/domain/model/airport/airport_model.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';

class AirportListUseCase {
  AirportListUseCase({required AirportRepository airportRepository})
      : _airportRepository = airportRepository;
  final AirportRepository _airportRepository;

  Future<Result<List<AirportModel>>> execute() async {
    final result = await _airportRepository.getAirportListData();
    switch (result) {
      case Success<List<AirportDTO>>():
        final List<AirportModel> airportList =
            result.data.map((e) => AirportMapper.fromDTO(e)).toList();
        return Result.success(airportList);
      case Error<List<AirportDTO>>():
        return Result.error(result.message);
    }
    return const Result.error('error');
  }
}
