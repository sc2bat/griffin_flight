import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/data/repositories/flight_repository_impl.dart';
import 'package:griffin/domain/model/flights_model.dart';
import 'package:griffin/presentation/book/book_screen_viewmodel.dart';
import '../../data/core/result.dart';
import '../../utils/simple_logger.dart';
import '../common/flight_card.dart';
import 'package:provider/provider.dart';

class BookDataTestScreen extends StatefulWidget {
  const BookDataTestScreen({super.key});

  @override
  State<BookDataTestScreen> createState() => _BookDataTestScreenState();
}

class _BookDataTestScreenState extends State<BookDataTestScreen> {
  List<FlightsModel> list = [];

  void getData() async {
    final result = await FlightRepositoryImpl().getFlightDataApi();
    result.when(
      success: (data) {
        logger.info(data.length);
        list = data;
        // logger.info(list);
        // logger.info(list[0].departureTime);
      },
      error: (error) => logger.info(error),
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
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
              context.go('/');
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
                departureTime: list[0].departureTime,
                arrivalTime: list[0].arrivalTime,

              ),
              ElevatedButton(
                onPressed: () {
                  context.go('/book_data_test/book');
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
