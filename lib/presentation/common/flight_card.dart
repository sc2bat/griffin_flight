import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';
import 'package:griffin/presentation/common/common.dart';

class FlightDetailsCard extends StatelessWidget {
  const FlightDetailsCard(
      {super.key,
      required this.width,
      required this.height,
      required this.departureAirportCode,
      required this.arrivalAirportCode,
      required this.departureTime,
      required this.arrivalTime,
      required this.direct,
      required this.price,
      required this.airlineName});

  final double width;
  final double height;
  final String departureAirportCode;
  final String arrivalAirportCode;
  final String departureTime;
  final String arrivalTime;
  final String direct;
  final double price;
  final String airlineName;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.greyCard,
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('$departureAirportCode - $arrivalAirportCode'),
                    ],
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                          '${departureTime.substring(0, 2)}:${departureTime.substring(2)} - ${arrivalTime.substring(0, 2)}:${arrivalTime.substring(2)}'),
                      subtitle: Text(
                          '${calculateDuration(departureTime, arrivalTime)}. $direct'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.attach_money),
                          Text(
                            '${price.floor()}',
                            style: const TextStyle(fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(airlineName),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
