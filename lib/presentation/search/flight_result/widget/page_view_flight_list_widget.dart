import 'package:flutter/material.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/presentation/common/common.dart';
import 'package:griffin/utils/simple_logger.dart';

class PageViewFlightListWidget extends StatelessWidget {
  const PageViewFlightListWidget({
    super.key,
    required this.flightList,
    this.selectFlight,
    required this.selectFunction,
  });
  final List<FlightResultModel> flightList;
  final Function(FlightResultModel flightResultModel) selectFunction;
  final FlightResultModel? selectFlight;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: flightList.length,
        itemBuilder: (context, index) {
          final flightModel = flightList[index];
          bool isSelected = isSelectedFunction(flightModel, selectFlight);
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: InkWell(
              onTap: () {
                logger.info('flightModel click $index');
                logger.info('flightModel click ${flightModel.flightId}');
                selectFunction(flightModel);
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                height: MediaQuery.of(context).size.height * 0.18,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[850],
                  border: Border.all(
                    color: isSelected ? Colors.green : Colors.grey,
                    width: isSelected ? 4.0 : 2.0,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${flightModel.departureAirportCode} - ${flightModel.arrivalAirportCode}',
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(index == 0 ? 'FASTEST' : ''),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${flightModel.departureTime} - ${flightModel.arrivalTime}${int.parse(flightModel.departureTime) > int.parse(flightModel.arrivalTime) ? ' +1' : ''}',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    '${calculateDuration(flightModel.departureTime, flightModel.arrivalTime)} - Direct',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                numberWithCommas(flightModel.payAmount, true),
                                style: const TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

bool isSelectedFunction(
    FlightResultModel flightResultModel, FlightResultModel? selectFlight) {
  return (selectFlight != null &&
          flightResultModel.flightId == selectFlight.flightId)
      ? true
      : false;
}
