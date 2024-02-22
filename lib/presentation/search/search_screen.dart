import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  PanelController panelController = PanelController();
  double _panelHeightOpen = 700;
  double _panelHeightClosed = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SlidingUpPanel(
        controller: panelController,
        panel: Center(
          child: Text('sliding widget'),
        ),
        isDraggable: false,
        backdropEnabled: false,
        maxHeight: _panelHeightOpen,
        minHeight: _panelHeightClosed,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  children: [
                    Text('hi samanda'),
                    Text('where are you'),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text('Round Trip'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Text('From'),
                                      InkWell(
                                        onTap: () {
                                          panelController.isPanelOpen
                                              ? panelController.close()
                                              : panelController.open();
                                          // context.go('/search/citySelectPage');
                                          //Select City를 눌렀을 때 수행할 동작
                                        },
                                        child: Text('Select City'),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.airplane_ticket),
                                Container(
                                  child: Column(
                                    children: [
                                      Text('To'),
                                      InkWell(
                                        onTap: () {
                                          panelController.isPanelOpen
                                              ? panelController.close()
                                              : panelController.open();
                                        },
                                        child: Text('Select City'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('TRAVEL DATE'),
                            Text('Sun, 4 Oct'),
                          ],
                        ),
                        Column(
                          children: [
                            Text('RETURN'),
                            Text('Select Date'),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Text('Traveller'),
                                InkWell(
                                  onTap: () {
                                    print('인원 선택 페이지');
                                  },
                                  child: Text('1 Adult'),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text('CLASS'),
                                InkWell(
                                  onTap: () {
                                    print('좌석 선택 페이지');
                                  },
                                  child: Text('Economy'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Show direct flights only'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Search Flights'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
