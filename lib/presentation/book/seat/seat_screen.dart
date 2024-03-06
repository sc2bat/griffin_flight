import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SeatScreen extends StatelessWidget {
  const SeatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar:  AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.go('/book/passport');
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('Select Seats'),
        ),
        body: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                },
                  child: Container(height: 30, width: 30, color: Colors.blue));
            }),
      ),
    );
  }
}
