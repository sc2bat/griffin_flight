import 'package:flutter/material.dart';
import 'package:griffin/presentation/book/flight_details_card.dart';
import 'package:griffin/presentation/book/flight_icon_widget.dart';
import 'package:griffin/presentation/common/colors.dart';
import 'package:griffin/presentation/common/common_button.dart';
import 'package:griffin/presentation/common/colors.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Flight Details'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                const FlightIconWidget(),
                Expanded(
                  child: Column(children: [
                    const ListTile(
                      title: Text('출발지'),
                      subtitle: Text('출발지정보'),
                    ),
                    FlightDetailsCard(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.18,
                    ),
                    const ListTile(
                      title: Text('도착지'),
                      subtitle: Text('도착지정보'),
                    ),
                  ]),
                ),
              ],
            ),
            const Spacer(),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 16),
               child: Row(
                children: [
                  const Expanded(
                    child: ListTile(
                      title: Text('TOTAL FARE',
                          style: TextStyle(color: AppColors.greyText)),
                      subtitle: Row(
                        children: [
                          Icon(Icons.attach_money),
                          Text('금액정보'),
                        ],
                      ),
                    ),
                  ),
                  CommonButton(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.12,
                    text: 'Continue',
                    onTap: () {},)
                ],
                           ),
             ),
          ],
        ),
      ),
    );
  }
}
