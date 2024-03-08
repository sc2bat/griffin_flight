import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

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
    String calculateDuration(String startTime, String endTime) {
      int startHour = int.parse(startTime.substring(0, 2));
      int startMinute = int.parse(startTime.substring(2));
      int endHour = int.parse(endTime.substring(0, 2));
      int endMinute = int.parse(endTime.substring(2));

      int totalStartMinutes = startHour * 60 + startMinute;
      int totalEndMinutes = endHour * 60 + endMinute;

      if (totalEndMinutes < totalStartMinutes) {
        totalEndMinutes += 24 * 60;
      }

      int diffMinutes = totalEndMinutes - totalStartMinutes;

      int hours = diffMinutes ~/ 60;
      int minutes = diffMinutes % 60;

      String result = '${hours}시간 ${minutes}분';
      return result;
    }

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
