// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:griffin/data/core/result.dart';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/domain/repositories/airport_repository.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';

class SearchUseCase {
  final AirportRepository _airportRepository;
  SearchUseCase({
    required AirportRepository airportRepository,
  }) : _airportRepository = airportRepository;

  Future<Result<List<AirportModel>>> execute() async {
    final result = await _airportRepository.getAirportDataApi();
    return result.when(
      success: (data) {
        return Result.success(data);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
