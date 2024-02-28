import 'dart:developer';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/utils/simple_logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/search/search_view_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:math' as math;

import '../../data/dtos/airport_dto.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<AirportModel> searchAirport = [];

  //검색 결과 저장 리스트

  PanelController panelController = PanelController();

  TextEditingController textEditingController = TextEditingController();

  bool isLoading = false;
  bool isSelected = false;

  double _panelHeightClosed = 0.0;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();
    final state = viewModel.state;

    double _panelHeightOpen = MediaQuery
        .of(context)
        .size
        .height * 0.8;

    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
          color: Colors.black,
          controller: panelController,
          panel: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              panelController.close();
                              //상위 위젯의 상태를 변경하기 위한 컨트롤러 호출
                            });
                          },
                          icon: Icon(Icons.close)),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            'FLYING FROM',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.deepOrange,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Transform.rotate(
                    angle: 90 * math.pi / 180, //아이콘 90도 회전
                    child: Icon(
                      Icons.airplanemode_active,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            'FLYING TO',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 15,
              ),
              Gap(20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        height: 50,
                        width: 350,
                        child: TextField(

                          controller: textEditingController,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 10.0),
                            //필드내 전체적인 정렬
                            hintText: 'Search Depature Airport/City',
                            prefixIcon: IconButton(
                              onPressed: () {
                                viewModel
                                    .searchAirport(textEditingController.text);
                                logger.info(state.airportData);
                                //검색
                              },
                              icon: Icon(Icons.search),
                            ),
                            Consumer<SearchViewModel>(
                              builder: (context, viewModel, child) {
                                return Expanded(
                                  child: ListView.builder(
                                  itemCount: viewModel.searchAirport(airportName),
                                  itemBuilder: (context, index) {
                                    final airport = viewModel
                                        .searchAirport[index];
                                    return ListTile(
                                      title: Text(airport),
                                    ),

                                  }),),


                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(32.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(32.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Column(
                    children: searchAirport.map((airport) {
                      return Container(
                        child: Text(airport.airportName),
                      );
                    }).toList(),
                  ),
                ],
              ),
              //도시 검색 결과 리스트 코드
            ],
          ),
          isDraggable: true,
          backdropEnabled: true,
          maxHeight: _panelHeightOpen,
          minHeight: _panelHeightClosed,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          body: Container(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white,
                        //boxdecoration이 있으면 color는 내부에다가
                      ),
                      child: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    const Gap(30),
                    Text(
                      'Hi samanda',
                      style: TextStyle(fontSize: 30),
                    ),
                    const Gap(10),
                    Text(
                      'where are you flying to?',
                      style: TextStyle(fontSize: 30),
                    ),
                    const Gap(20),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[850],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            'Round trip',
                            style: TextStyle(fontSize: 20),
                          ),
                          Gap(10),
                          Divider(
                            color: Colors.white12,
                            height: 0.2,
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          'FROM',
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              panelController
                                                  .animatePanelToPosition(1.0);
                                              log('From select city');
                                            },
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Select City',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: 90 * math.pi / 180, //아이콘 90도 회전
                                  child: Icon(
                                    Icons.flight,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          'TO',
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              log('To select city');
                                            },
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text('Select City',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                      ],
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.white12,
                            height: 0.2,
                          ),
                          Container(
                            height: 80,
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: InkWell(
                              onTap: () {
                                log('Travel Date round trip');
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            'TRAVEL DATE',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'SUN 4, oct',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            'RETURN',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text('Select Date',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.white12,
                            height: 0.2,
                          ),
                          Container(
                            height: 90,
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      log('Adult');
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          const Gap(10),
                                          const Text(
                                            'TRAVELLER',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                '1 Adult',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: double.infinity,
                                  alignment: Alignment.center,
                                  color: Colors.white12,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      log('CLASS');
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          const Gap(10),
                                          Text(
                                            'CLASS',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text('Economy',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.white12,
                            height: 0.2,
                          ),
                          InkWell(
                            onTap: () {
                              isSelected = !isSelected;
                              // 라디오버튼 기능 변수 변경
                              // isSelected = isSelected == true ? false : true;
                              //
                              // if (isSelected == true) {
                              //   isSelected = false;
                              // } else {
                              //   isSelected = true;
                              // }

                              setState(() {});

                              log('isSelectd : $isSelected');
                            },
                            child: Container(
                              height: 60,
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                children: [
                                  isSelected == true
                                      ? ShaderMask(
                                    child: Icon(Icons.circle),
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                          colors: [
                                            Color(0xFFF88264),
                                            Color(0xFFFFE3C5)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)
                                          .createShader(bounds);
                                    },
                                  )
                                      : Icon(Icons.circle_outlined),
                                  // if (isSelected == false)
                                  //   Icon(Icons.circle_outlined),
                                  // if (isSelected == true)
                                  //   Icon(Icons.circle),
                                  // 라디오 버튼 ui가 값이 변하는 구문
                                  const Gap(10),
                                  Text(
                                    'Show direct flight only',
                                    style: TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    InkWell(
                      onTap: () {
                        context.go('/search/flightResults');
                        log('search flight');
                      },
                      child: Container(
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFF88264),
                              Color(0xFFFFE3C5),
                            ],
                          ),
                          //color: Colors.grey[850],
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Search Flights',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Widget _searchCity() {
//     return
// }

// Future<void> searchCity(String query) async {
//   isLoading = true;
//   notifyListeners();
}
