import 'package:flutter/material.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/presentation/common/colors.dart';
import 'package:griffin/presentation/common/common.dart';

class FlightDetailsCard extends StatelessWidget {
  const FlightDetailsCard({
    super.key,
    required this.width,
    required this.height,
    required this.flightResultModel,
    required this.direct,
    required this.airlineName,
  });

  final double width;
  final double height;
  final FlightResultModel? flightResultModel;
  final String direct;
  final String airlineName;

  @override
  Widget build(BuildContext context) {
    if (flightResultModel != null) {}
    return flightResultModel != null
        ? Card(
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
                          Text(
                              '${flightResultModel!.departureAirportCode} - ${flightResultModel!.arrivalAirportCode}'),
                        ],
                      ),
                      Expanded(
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                              '${convertTime(flightResultModel!.departureTime)} - ${convertTime(flightResultModel!.arrivalTime)}'),
                          subtitle: Text(
                              '${calculateDuration(flightResultModel!.departureTime, flightResultModel!.arrivalTime)}. $direct'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.attach_money),
                              Text(
                                '${flightResultModel!.payAmount.floor()}',
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
            ),
          )
        : const Card();
  }

  String convertTime(String time) {
    return '${time.substring(0, 2)}:${time.substring(2)}';
  }
}
