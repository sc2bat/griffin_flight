import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class FlightDetailsCard extends StatelessWidget {
  const FlightDetailsCard(
      {super.key,
      required this.width,
      required this.height,
      this.departureAirportCode,
      this.arrivalAirportCode,
      this.departureTime,
      this.arrivalTime,
      this.flightTime,
      this.direct,
      this.price,
      this.airlineName});

  final double width;
  final double height;
  final String? departureAirportCode;
  final String? arrivalAirportCode;
  final String? departureTime;
  final String? arrivalTime;
  final String? flightTime;
  final String? direct;
  final int? price;
  final String? airlineName;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.greyCard,
        child: Container(
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
                      title: Text('$departureTime - $arrivalTime'),
                      subtitle: Text('$flightTime . $direct'),
                      trailing: Text(
                        '$price',
                        style: const TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text('$airlineName'),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
