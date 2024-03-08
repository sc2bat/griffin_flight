import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/sign/sign_view_model.dart';
import 'package:griffin/presentation/splash/sign_status.dart';
import 'package:provider/provider.dart';

import 'widget/sign_in_card.dart';
import 'widget/sign_up_card.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  StreamSubscription? _streamSubscription;
  StreamSubscription? _signStatusSubscription;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );

    Future.microtask(() {
      final signViewModel = context.read<SignViewModel>();

      _streamSubscription =
          signViewModel.getSignUiEventStreamController.listen((event) {
        event.when(showSnackBar: (message) {
          final snackBar = SnackBar(
            content: Text(message),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        });
      });
      _signStatusSubscription = signViewModel.signStatus.listen((event) {
        switch (event) {
          case SignStatus.signIn:
            context.go('/splash');
            break;
          case SignStatus.signOut:
            context.go('/sign');
            break;
          case SignStatus.signUp:
            tabController.animateTo(0);
            break;
        }
      });

      signViewModel.init();
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _signStatusSubscription?.cancel();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signViewModel = context.watch<SignViewModel>();
    final signState = signViewModel.signState;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('SignScreen'),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.login_rounded),
              ),
              Tab(
                icon: Icon(Icons.logout_rounded),
              ),
            ],
            controller: tabController,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            SignInCard(
                isLoading: signState.isLoading,
                signInFunction: (userName, password) async =>
                    await signViewModel.signIn(userName, password)),
            SignUpCard(
                // tabAnimateTo: () => tabController.animateTo(0),
                signUpFunction: (email, userName, password1, password2) async =>
                    await signViewModel.signUp(
                        email, userName, password1, password2)),
          ],
        ),
      ),
    );
  }
}
