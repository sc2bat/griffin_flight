import 'package:flutter/foundation.dart';
import '../../../domain/use_cases/detail_use_case.dart';

class BookViewModel with ChangeNotifier {
  final DetailUseCase _detailUseCase;

  BookViewModel({required DetailUseCase detailUseCase})
      : _detailUseCase = detailUseCase;
}
