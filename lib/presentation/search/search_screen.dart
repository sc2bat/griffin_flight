import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:math' as math;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  PanelController panelController = PanelController();
  bool isSelected = false;

  double _panelHeightClosed = 0.0;

  @override
  Widget build(BuildContext context) {
    double _panelHeightOpen = MediaQuery.of(context).size.height * 0.8;

    return SafeArea(
      child: SlidingUpPanel(
        color: Colors.grey[850]!,
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
                            isSelected = false;
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
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.airplane_ticket,
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
        body: Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          body: SingleChildScrollView(
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
                                                  fontWeight: FontWeight.bold),
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                              fontSize: 15, color: Colors.grey),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'SUN 4, oct',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
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
                                              fontSize: 15, color: Colors.grey),
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
                                              fontSize: 15, color: Colors.grey),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '1 Adult',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
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
                                              fontSize: 15, color: Colors.grey),
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
    );
  }
}
