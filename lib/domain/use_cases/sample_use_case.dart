// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:griffin/data/core/result.dart';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/domain/repositories/sample_repository.dart';

class SampleUseCase {
  final SampleRepository _sampleRepository;
  SampleUseCase({
    required SampleRepository sampleRepository,
  }) : _sampleRepository = sampleRepository;

  Future<Result<List<AirportModel>>> execute() async {
    final result = await _sampleRepository.getSampleDataApi();
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
