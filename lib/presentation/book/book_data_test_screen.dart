import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookDataTestScreen extends StatelessWidget {
  const BookDataTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('test screen'),
              ElevatedButton(
                  onPressed: () {
                    context.go('/book_data_test/book');
                  },
                  child: const Text('button'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
