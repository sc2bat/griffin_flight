import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/common/common_button.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_state.dart';
import 'package:griffin/presentation/search/flight_result/flight_result_view_model.dart';
import 'package:provider/provider.dart';

import 'widget/page_view_flight_list_widget.dart';

class FlightResultScreen extends StatefulWidget {
  const FlightResultScreen({
    super.key,
    required this.searchResult,
  });
  final Map<String, dynamic> searchResult;

  @override
  State<FlightResultScreen> createState() => _FlightResultScreenState();
}

class _FlightResultScreenState extends State<FlightResultScreen>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  StreamSubscription? _streamSubscription;

  List<Widget> pages = <Widget>[
    const Text('From Flight'),
    const Text('To Flight'),
  ];

  @override
  void initState() {
    Future.microtask(() {
      final FlightResultViewModel flightResultViewModel =
          context.read<FlightResultViewModel>();
      flightResultViewModel.init(widget.searchResult);
      _streamSubscription = flightResultViewModel.setStream(context);
    });

    _pageViewController = PageController();

    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );

    _pageViewController.addListener(
      () {},
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController.dispose();
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final FlightResultViewModel flightResultViewModel =
        context.watch<FlightResultViewModel>();
    final FlightResultState flightResultState =
        flightResultViewModel.flightResultState;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          child: const Icon(Icons.close),
        ),
        actions: const [],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    16.0,
                  ),
                ),
                color: Colors.white30,
              ),
              child: ToggleButtons(
                direction: Axis.horizontal,
                onPressed: (int index) {
                  flightResultViewModel.updateToggle(index);
                  _updateCurrentPageIndex(index);
                },
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: Colors.red[700],
                selectedColor: Colors.white,
                fillColor: Colors.red[200],
                color: Colors.red[400],
                constraints: BoxConstraints(
                  minHeight: 48.0,
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                ),
                isSelected: flightResultState.selectedPage,
                children: pages,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PageView(
                  controller: _pageViewController,
                  onPageChanged: (index) {
                    flightResultViewModel.updateToggle(index);
                    _updateCurrentPageIndex(index);
                  },
                  children: flightResultState.isLoading
                      ? [
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ]
                      : [
                          PageViewFlightListWidget(
                            flightList: flightResultState.fromFlightResultList,
                            selectFlight: flightResultState.selectFromFlight,
                            selectFunction:
                                flightResultViewModel.selectFromFlight,
                          ),
                          PageViewFlightListWidget(
                            flightList: flightResultState.toFlightResultList,
                            selectFlight: flightResultState.selectToFlight,
                            selectFunction:
                                flightResultViewModel.selectToFlight,
                          ),
                        ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.20,
              child: Column(
                children: [
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CommonButton(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.12,
                        text: 'Continue',
                        onTap: () async {
                          if (flightResultViewModel.flightSelectValid() &&
                              mounted) {
                            context.go('/book');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
