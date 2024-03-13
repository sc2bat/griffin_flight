import 'package:flutter/material.dart';
import 'package:griffin/di/get_it.dart';

import 'presentation/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  runApp(
    const MyApp(),
  );
}
