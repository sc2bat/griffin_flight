import 'package:flutter/foundation.dart';
import 'package:griffin/data/repositories/flight_repository_impl.dart';

import '../../../domain/use_cases/detail_use_case.dart';

class DetailViewModel with ChangeNotifier {
  final DetailUseCase _detailUseCase;

  DetailViewModel({required DetailUseCase detailUseCase})
      : _detailUseCase = detailUseCase;
}
