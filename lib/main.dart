import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:griffin/di/get_it.dart';

import 'presentation/my_app.dart';

void main() {
  setupDependencies();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
