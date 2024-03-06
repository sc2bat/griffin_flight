import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/splash/sign_status.dart';
import 'package:griffin/presentation/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _subscription;
  @override
  void initState() {
    Future.microtask(() {
      final SplashViewModel splashViewModel = context.read();
      splashViewModel.init();
      _subscription = splashViewModel.signStatus.listen((event) {
        switch (event) {
          case SignStatus.signIn:
            context.go('/search');
          case SignStatus.signOut:
            context.go('/sign');
          case SignStatus.signUp:
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
