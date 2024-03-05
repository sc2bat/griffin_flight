import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/splash/splash_view_model.dart';
import 'package:provider/provider.dart';

class SplashScree extends StatefulWidget {
  const SplashScree({super.key});

  @override
  State<SplashScree> createState() => _SplashScreeState();
}

class _SplashScreeState extends State<SplashScree> {
  @override
  void initState() {
    Future.microtask(() {
      final splashViewModel = context.read<SplashViewModel>();
      final splashState = splashViewModel.splashState;
      splashViewModel.init();
      if (splashState.isRedirect) {
        context.go('/search');
      } else {
        context.go('/sign');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
