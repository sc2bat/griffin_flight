import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/flight_card.dart';

class BookDataTestScreen extends StatefulWidget {
  const BookDataTestScreen({super.key});

  @override
  State<BookDataTestScreen> createState() => _BookDataTestScreenState();
}

class _BookDataTestScreenState extends State<BookDataTestScreen> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.go('/book_data_test', extra: '뒤로 돌아갔다');
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('testscreen'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlightDetailsCard(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.18,
              ),
              ElevatedButton(
                onPressed: () {
                  final text = _textController.text;
                  if (text.isNotEmpty) {
                    context.go('/book_data_test/book', extra: text);
                  }
                },
                child: const Text('완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
