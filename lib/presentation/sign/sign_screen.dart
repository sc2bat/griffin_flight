import 'package:flutter/material.dart';
import 'package:griffin/presentation/sign/sign_view_model.dart';
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
  @override
  void initState() {
    Future.microtask(() {
      final signViewModel = context.read<SignViewModel>();
      signViewModel.init();
    });

    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          children: const [
            SignInCard(),
            SignUpCard(),
          ],
        ),
      ),
    );
  }
}
