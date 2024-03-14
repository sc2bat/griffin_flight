import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:griffin/domain/model/airport/airport_model.dart';

class AirportMapWidget extends StatefulWidget {
  const AirportMapWidget({
    super.key,
    required this.goResultFunction,
    required this.fromAirport,
    required this.toAirport,
    required this.isFlightAvailable,
  });
  final Function(BuildContext context) goResultFunction;
  final AirportModel fromAirport;
  final AirportModel toAirport;
  final bool isFlightAvailable;

  @override
  State<AirportMapWidget> createState() => _AirportMapWidgetState();
}

class _AirportMapWidgetState extends State<AirportMapWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Polyline> _polylines = {};
  late Timer timer;
  int _timerSeconds = 10;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    if (widget.isFlightAvailable) {
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _timerSeconds--;
        });
        if (_timerSeconds == 0) {
          timer.cancel();
          context.pop();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng startLocation =
        LatLng(widget.fromAirport.latitude, widget.fromAirport.longitude);
    final LatLng endLocation =
        LatLng(widget.toAirport.latitude, widget.toAirport.longitude);

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: startLocation,
                zoom: 5,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _startFlightAnimation(startLocation, endLocation);
              },
              polylines: _polylines,
              markers: {
                Marker(
                  markerId: const MarkerId('start'),
                  position: startLocation,
                  infoWindow: const InfoWindow(title: 'Start'),
                ),
                Marker(
                  markerId: const MarkerId('end'),
                  position: endLocation,
                  infoWindow: const InfoWindow(title: 'End'),
                ),
              },
            ),
            Positioned(
              bottom: 16.0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        final GoogleMapController controller =
                            await _controller.future;
                        await controller.animateCamera(
                          CameraUpdate.newLatLng(startLocation),
                        );
                      },
                      child: const Icon(Icons.flight_takeoff_rounded)),
                  const SizedBox(
                    width: 24.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final GoogleMapController controller =
                            await _controller.future;
                        await controller.animateCamera(
                          CameraUpdate.newLatLng(endLocation),
                        );
                      },
                      child: const Icon(Icons.flight_land_rounded)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm'),
                          content: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('검색을 취소하고 이전 화면으로 돌아가시겠습니까?'),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text('취소'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                                context.pop();
                              },
                              child: const Text('확인'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 32.0,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => widget.isFlightAvailable
                      ? {}
                      : widget.goResultFunction(context),
                  child: Center(
                    child: Text(
                      widget.isFlightAvailable
                          ? 'There are no flights Return to Search'
                          : 'View Search Results',
                      style: const TextStyle(
                          fontSize: 20.0, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
              ),
              widget.isFlightAvailable
                  ? Text(
                      '$_timerSeconds',
                      style: TextStyle(
                        color: Colors.lightGreen[600],
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : InkWell(
                      onTap: () => widget.goResultFunction(context),
                      child: Icon(
                        Icons.check,
                        color: Colors.lightGreen[600],
                        size: 32.0,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _startFlightAnimation(LatLng startLocation, LatLng endLocation) async {
    Polyline polyline = Polyline(
      polylineId: const PolylineId('flightPath'),
      color: Colors.blue,
      width: 2,
      points: [startLocation, endLocation],
    );

    setState(() {
      _polylines.add(polyline);
    });

    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newLatLng(startLocation),
    );
    await controller.animateCamera(
      CameraUpdate.zoomTo(12),
    );
  }
}
