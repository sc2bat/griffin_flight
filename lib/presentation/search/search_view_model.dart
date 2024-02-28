import 'package:flutter/foundation.dart';

import '../../data/repositories/sample_repository_impl.dart';

class SearchViewModel extends ChangeNotifier {
  final repository = SampleRepositoryImpl();


}