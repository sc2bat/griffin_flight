// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/book/books/books_viewmodel.dart';
import 'package:griffin/presentation/book/books/widgets/flight_icon_widget.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../../common/common_button.dart';
import '../../common/flight_card.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  @override
  void initState() {
    Future.microtask(() {
      final booksViewModel = context.read<BooksViewModel>();
      booksViewModel.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<BooksViewModel>();
    final state = viewModel.state;

    int totalFare = (state.arrivalFlightResultModel?.payAmount ??
            0.0 + state.departureFlightResultModel?.payAmount ??
            0.0)
        .floor();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Flight Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const FlightIconWidget(),
                Expanded(
                  child: Column(children: [
                    ListTile(
                      title: Text(widget
                          .departureFlightResultModel.departureAirportName),
                      subtitle: const Text('Departure'),
                    ),
                    FlightDetailsCard(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.15,
                        departureAirportCode: state.departureFlightResultModel
                                ?.departureAirportCode ??
                            '',
                        arrivalAirportCode:
                            state.departureFlightResultModel.arrivalAirportCode,
                        price: state.departureFlightResultModel.payAmount,
                        departureTime:
                            state.departureFlightResultModel.departureTime,
                        arrivalTime:
                            state.departureFlightResultModel.arrivalTime,
                        airlineName: 'United Airlines',
                        direct: 'direct'),
                    ListTile(
                      title: Text(
                          state.departureFlightResultModel.arrivalAirportName),
                      subtitle: const Text('Arrival'),
                    ),
                  ]),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                const FlightIconWidget(),
                Expanded(
                  child: Column(children: [
                    ListTile(
                      title: Text(state
                              .arrivalFlightResultModel?.departureAirportName ??
                          ''),
                      subtitle: const Text('Departure'),
                    ),
                    FlightDetailsCard(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.15,
                        flightResultModel: state.arrivalFlightResultModel,
                        airlineName: 'United Airlines',
                        direct: 'direct'),
                    ListTile(
                      title: Text(
                          state.arrivalFlightResultModel?.arrivalAirportName ??
                              ''),
                      subtitle: const Text('Arrival'),
                    ),
                  ]),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('TOTAL FARE',
                            style: TextStyle(color: AppColors.greyText)),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.attach_money),
                            Text('$totalFare',
                                style: const TextStyle(
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),
                    ),
                    CommonButton(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.12,
                      text: state.isLoading ? 'Loading...' : 'Continue',
                      onTap: state.isLoading
                          ? () {}
                          : () async {
                              if (state.departureFlightResultModel != null &&
                                  state.arrivalFlightResultModel != null) {
                                await viewModel.postBookData();

                                if (state.departureBookList.isNotEmpty &&
                                    state.arrivalBookList.isNotEmpty &&
                                    mounted) {
                                  context.push(
                                    '/book/passport',
                                    extra: {
                                      "departure_flight_result_model":
                                          state.departureBookList,
                                      "arrival_flight_result_model":
                                          state.arrivalBookList
                                    },
                                  );
                                }
                              }
                            },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
