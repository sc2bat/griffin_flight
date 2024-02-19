import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:griffin/data/core/observers.dart';
import 'package:griffin/di/get_it.dart';

import 'presentation/my_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupDependencies();

  runApp(
    ProviderScope(
      observers: [
        Observers(),
      ],
      child: const MyApp(),
    ),
  );
}
