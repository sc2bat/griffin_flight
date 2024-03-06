import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/common/colors.dart';
import 'package:griffin/presentation/common/date_pick_button_widget.dart';
import 'package:griffin/presentation/search/search_screen_view_model.dart';
import 'package:griffin/utils/simple_logger.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int currentPersonValue = 1;

  //여행객 증가, 감소 초기값

  final ValueNotifier<DateTime> _dateTimeNotifier =
      ValueNotifier<DateTime>(DateTime.now());

  //travel date 초기값 설정

  // final searchAirport = state.airportData;

  //검색 결과 저장 리스트

  PanelController panelController = PanelController();

  TextEditingController textEditingController = TextEditingController();

  bool isLoading = false;
  bool isSelected = false;

  final double _panelHeightClosed = 0.0;

  @override
  Widget build(BuildContext context) {
    final searchViewModel = context.watch<SearchScreenViewModel>();
    // final state = viewModel.state;

    double panelHeightOpen = MediaQuery.of(context).size.height * 0.8;

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
                          icon: const Icon(Icons.close)),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      child: const Column(
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
                    child: const Icon(
                      Icons.airplanemode_active,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: const Column(
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
              const Divider(
                height: 15,
              ),
              const Gap(20),
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
                          onChanged: (value) {},
                          //onSubmitted: (value) {
                          //  print(value);
                          //},
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                            //필드내 전체적인 정렬
                            hintText: 'Search Depature Airport/City',
                            prefixIcon: IconButton(
                              onPressed: () {
                                // viewModel
                                //     .searchAirport(textEditingController.text);
                                // logger.info(state.airportData);
                                //검색
                              },
                              icon: const Icon(Icons.search),
                            ),
                            // Consumer<SearchViewModel>(
                            //   builder: (context, viewModel, child) {
                            //     return Expanded(
                            //       child: ListView.builder(
                            //       itemCount: viewModel.searchAirport(airportName),
                            //       itemBuilder: (context, index) {
                            //         final airport = viewModel
                            //             .searchAirport[index];
                            //         return ListTile(
                            //           title: Text(airport),
                            //         ),
                            //
                            //       }),),
                            //
                            //
                            //   },
                            // ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Expanded(
                child: Container(
                    height: 300,
                    alignment: Alignment.center,
                    // color: Colors.amber,
                    child: Container(
                        child: Center(
                      child: Lottie.asset('assets/lottie/search_loading.json',
                          repeat: true, width: 100, fit: BoxFit.fitWidth),
                    )
                        /*: ListView.builder(
                              itemCount: 2,

                              itemBuilder: (context, index) {

                                return InkWell(
                                  onTap: () {
                                    // 선택한 값을 넣어주기.


                                    // panelController 닫기.
                                    setState(() {});
                                  },
                                  child: ListTile(
                                    title: Text('airportName'),
                                  ),
                                );
                              },
                            ),*/
                        )),
              ),
              // Column(
              //   children: [
              //     Column(
              //       children: searchAirport.map((airport) {
              //         return Container(
              //           child: Text(airport.airportName),
              //         );
              //       }).toList(),
              //     ),
              //   ],
              // ),
              //도시 검색 결과 리스트 코드
            ],
          ),
          isDraggable: true,
          backdropEnabled: true,
          maxHeight: panelHeightOpen,
          minHeight: _panelHeightClosed,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white,
                        //boxdecoration이 있으면 color는 내부에다가
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    const Gap(30),
                    const Text(
                      'Hi samanda',
                      style: TextStyle(fontSize: 30),
                    ),
                    const Gap(10),
                    const Text(
                      'where are you flying to?',
                      style: TextStyle(fontSize: 30),
                    ),
                    const Gap(20),
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      decoration: BoxDecoration(
                        color: AppColors.greyCard,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          const Text(
                            'Round trip',
                            style: TextStyle(fontSize: 20),
                          ),
                          const Gap(10),
                          const Divider(
                            color: Colors.white12,
                            height: 0.2,
                          ),
                          Container(
                            height: 90,
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'FROM',
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              panelController
                                                  .animatePanelToPosition(1.0);
                                              logger.info('From select city');
                                            },
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                '',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Transform.rotate(
                                  angle: 90 * math.pi / 180, //아이콘 90도 회전
                                  child: const Icon(
                                    Icons.flight,
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text(
                                          'TO',
                                          style: TextStyle(
                                              fontSize: 15, color: Colors.grey),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              logger.info('To select city');
                                            },
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: const Text('Select City',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Colors.white12,
                            height: 0.2,
                          ),
                          Container(
                            height: 80,
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: InkWell(
                              onTap: () {
                                logger.info('message');
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('TRAVEL DATE'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                height: 50,
                                                child: DatePickButtonWidget(
                                                  defaultTextStyle:
                                                      const TextStyle(
                                                          color: Colors.white),
                                                  selectedTextStyle:
                                                      const TextStyle(
                                                          color: Colors.white),
                                                  textAlign:
                                                      Alignment.centerLeft,
                                                  initialDate:
                                                      _dateTimeNotifier.value,
                                                  firstDate:
                                                      _dateTimeNotifier.value,
                                                  lastDate: DateTime(
                                                      _dateTimeNotifier
                                                              .value.year +
                                                          1),
                                                  title: 'Select Date',
                                                  onDatedSelected:
                                                      (selectedDate) {
                                                    setState(() {
                                                      _dateTimeNotifier.value =
                                                          selectedDate;
                                                    });
                                                  },
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.white12,
                                    height: 0.2,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const Text('TRAVEL DATE'),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: 50,
                                                child: DatePickButtonWidget(
                                                  defaultTextStyle:
                                                      const TextStyle(
                                                          color: Colors.white),
                                                  selectedTextStyle:
                                                      const TextStyle(
                                                          color: Colors.white),
                                                  textAlign:
                                                      Alignment.centerRight,
                                                  initialDate:
                                                      _dateTimeNotifier.value,
                                                  firstDate:
                                                      _dateTimeNotifier.value,
                                                  lastDate: DateTime(2025),
                                                  title: 'Select Date',
                                                  onDatedSelected:
                                                      (selectedDate) {
                                                    logger
                                                        .info('$selectedDate');
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            color: Colors.white12,
                            height: 0.2,
                          ),
                          Container(
                            height: 90,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      logger.info('Adult');
                                    },
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Gap(10),
                                          const Text(
                                            'TRAVELLER',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    //인원 감소 버튼
                                                    child: const Icon(Icons
                                                        .remove_circle_outline),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      if (currentPersonValue >
                                                          1) {
                                                        currentPersonValue--;
                                                      }
                                                    });
                                                  },
                                                ),
                                                const Gap(10),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    currentPersonValue
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const Gap(10),
                                                InkWell(
                                                  child: Container(
                                                    //인원 증가 버튼
                                                    child: const Icon(Icons
                                                        .add_circle_outline),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      currentPersonValue++;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                                      logger.info('CLASS');
                                    },
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const Gap(10),
                                          const Text(
                                            'CLASS',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: 150,
                                              height: 50,
                                              alignment: Alignment.centerRight,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  icon: const SizedBox.shrink(),
                                                  //드롭다운 밑줄/화살표 가려줌

                                                  value: searchViewModel
                                                      .selectClass,
                                                  items: searchViewModel
                                                      .selectedClassList
                                                      .map((e) {
                                                    return DropdownMenuItem<
                                                            String>(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        value: e,
                                                        child: Center(
                                                          child: Text(e),
                                                        ));
                                                  }).toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      searchViewModel
                                                              .selectedClass =
                                                          value!;
                                                    });
                                                  },
                                                  isExpanded: true,
                                                ),
                                              ),

                                              // const DropdownMenu(
                                              //
                                              //   dropdownMenuEntries: [
                                              //     DropdownMenuEntry(
                                              //         value: Colors.black,
                                              //         label: 'Economy'),
                                              //     DropdownMenuEntry(
                                              //         value: Colors.black,
                                              //         label: 'Business'),
                                              //     DropdownMenuEntry(
                                              //         value: Colors.black,
                                              //         label: 'First'),
                                              //   ],
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
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

                              logger.info('isSelectd : $isSelected');
                            },
                            child: Container(
                              height: 60,
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                children: [
                                  isSelected == true
                                      ? ShaderMask(
                                          child: const Icon(Icons.circle),
                                          shaderCallback: (Rect bounds) {
                                            return const LinearGradient(
                                                    colors: [
                                                  Color(0xFFF88264),
                                                  Color(0xFFFFE3C5)
                                                ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter)
                                                .createShader(bounds);
                                          },
                                        )
                                      : const Icon(Icons.circle_outlined),
                                  // if (isSelected == false)
                                  //   Icon(Icons.circle_outlined),
                                  // if (isSelected == true)
                                  //   Icon(Icons.circle),
                                  // 라디오 버튼 ui가 값이 변하는 구문
                                  const Gap(10),
                                  const Text(
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
                        logger.info('search flight');
                      },
                      child: Container(
                        height: 80,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
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
                        child: const Text(
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

  Widget travelPerson(VoidCallback callback) {
    return TextButton(
      onPressed: () {
        setState(() {
          callback();
        });
      },
      child: const Text(''),
    );
  }
}
