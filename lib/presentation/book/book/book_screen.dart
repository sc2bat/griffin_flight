import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/book/book/widgets/flight_icon_widget.dart';

import '../../common/flight_card.dart';
import '../../common/total_fare_bar_widget.dart';

class BookScreen extends StatefulWidget {
  const BookScreen(
      {super.key});


  @override
  State<BookScreen> createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  @override
  Widget build(BuildContext context) {
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
                    const ListTile(
                      title: Text('DEL'),
                      subtitle: Text('Departure'),
                    ),
                    FlightDetailsCard(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    const ListTile(
                      title: Text('JFK'),
                      subtitle: Text('Arrival'),
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
                    const ListTile(
                      title: Text('JFK'),
                      subtitle: Text('Departure'),
                    ),
                    FlightDetailsCard(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    const ListTile(
                      title: Text('DEL'),
                      subtitle: Text('Arrival'),
                    ),
                  ]),
                ),
              ],
            ),
            const Spacer(),
            TotalFareBarWidget(
              onTap: () {
              context.go('/book/passport');
              },
            ),
          ],
        ),
      ),
    );
  }
}
