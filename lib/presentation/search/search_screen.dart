import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/domain/model/airport/airport_model.dart';
import 'package:griffin/presentation/common/colors.dart';
import 'package:griffin/presentation/common/date_pick_button_widget.dart';
import 'package:griffin/presentation/search/search_state.dart';
import 'package:griffin/presentation/search/search_view_model.dart';
import 'package:griffin/utils/simple_logger.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late PanelController _panelController;
  late TextEditingController _textEditingController;
  StreamSubscription? _streamSubscription;

  List<AirportModel> forSelectAirportList = [];

  final ValueNotifier<DateTime> _dateTimeNotifier =
      ValueNotifier<DateTime>(DateTime.now());

  final double _panelHeightClosed = 0.0;
  bool isFromCitySelected = true;

  @override
  void initState() {
    Future.microtask(() {
      final searchViewModel = context.read<SearchViewModel>();
      searchViewModel.init();
      _streamSubscription = searchViewModel.setStream(context);
    });
    _panelController = PanelController();
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SearchViewModel searchViewModel = context.watch<SearchViewModel>();
    final SearchState state = searchViewModel.state;

    double panelHeightOpen = MediaQuery.of(context).size.height * 0.8;

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              context.go('/mypage');
            },
            style: ButtonStyle(
              //테두리 모양 조절
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
            ),
            child: const Text('MY PAGE', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: SlidingUpPanel(
          color: AppColors.greyCard,
          controller: _panelController,
          panel: Column(
            children: [
              Row(
                children: [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          _panelController.close();
                          _textEditingController.clear();
                          forSelectAirportList = [];
                        },
                        icon: const Icon(Icons.close),
                      ),
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
                              color: isFromCitySelected
                                  ? Colors.deepOrange
                                  : Colors.grey,
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
                      child: Column(
                        children: [
                          Text(
                            'FLYING TO',
                            style: TextStyle(
                              fontSize: 15,
                              color: !isFromCitySelected
                                  ? Colors.deepOrange
                                  : Colors.grey,
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
                          controller: _textEditingController,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (value) {
                            setState(() {
                              forSelectAirportList = state.airportList
                                  .where((e) =>
                                      e.airportName
                                          .toLowerCase()
                                          .contains(value.toLowerCase()) ||
                                      e.airportCode
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                  .where(
                                      (e) => e.airportId != state.fromAirportId)
                                  .toSet()
                                  .toList();

                              if (state.toAirportId != 0) {
                                forSelectAirportList
                                    .where(
                                        (e) => e.airportId != state.toAirportId)
                                    .toList();
                              }

                              if (state.fromAirportId != 0) {
                                forSelectAirportList
                                    .where((e) =>
                                        e.airportId != state.fromAirportId)
                                    .toList();
                              }
                            });
                          },
                          onSubmitted: (value) {
                            logger.info(value);
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10.0),
                            //필드내 전체적인 정렬
                            hintText: 'Search Depature Airport/City',
                            prefixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.search),
                            ),
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
                    child: state.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                            // Lottie.asset(searchLoadingLottie, repeat: true, width: 100, fit: BoxFit.fitWidth),
                          )
                        : ListView.builder(
                            itemCount: forSelectAirportList.length,
                            itemBuilder: (context, index) {
                              final item = forSelectAirportList[index];
                              return InkWell(
                                onTap: () {
                                  isFromCitySelected
                                      ? searchViewModel.saveFromAirport(item)
                                      : searchViewModel.saveToAirport(item);

                                  _panelController.close();
                                  _textEditingController.clear();
                                  forSelectAirportList = [];
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: ListTile(
                                    title: Text(item.airportCode),
                                    subtitle: Text(item.airportName),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
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
            // padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
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
                    Text(
                      'Hi ${state.userAccountModel != null ? state.userAccountModel!.userName : ''}',
                      style: const TextStyle(fontSize: 30),
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
                                              _panelController
                                                  .animatePanelToPosition(1.0);
                                              setState(() {
                                                isFromCitySelected = true;
                                              });
                                              logger.info('From select city');
                                            },
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                (state.fromAirportId != 0
                                                    ? state.airportList
                                                        .where((e) =>
                                                            e.airportId ==
                                                            state.fromAirportId)
                                                        .map((e) =>
                                                            e.airportCode)
                                                        .first
                                                    : 'Select City'),
                                                style: const TextStyle(
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
                                              _panelController
                                                  .animatePanelToPosition(1.0);
                                              logger.info('To select city');
                                              setState(() {
                                                isFromCitySelected = false;
                                                //from 선택 값을 뺀 나머지만 있어야 함
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                  (state.toAirportId != 0
                                                      ? state.airportList
                                                          .where((e) =>
                                                              e.airportId ==
                                                              state.toAirportId)
                                                          .map((e) =>
                                                              e.airportCode)
                                                          .first
                                                      : 'Select City'),
                                                  style: const TextStyle(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'TRAVEL DATE',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DatePickButtonWidget(
                                        defaultTextStyle: const TextStyle(
                                            color: Colors.white),
                                        selectedTextStyle: const TextStyle(
                                            color: Colors.white),
                                        textAlign: Alignment.centerLeft,
                                        initialDate: _dateTimeNotifier.value,
                                        firstDate: _dateTimeNotifier.value,
                                        lastDate: DateTime(
                                            _dateTimeNotifier.value.year + 1),
                                        title: 'Select Date',
                                        onDatedSelected: (value) {
                                          searchViewModel.saveTravelDate(value);
                                          _dateTimeNotifier.value = value;
                                        }),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.white12,
                                  height: 0.2,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'RETURN DATE',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    DatePickButtonWidget(
                                      defaultTextStyle:
                                          const TextStyle(color: Colors.white),
                                      selectedTextStyle:
                                          const TextStyle(color: Colors.white),
                                      textAlign: Alignment.centerRight,
                                      initialDate: _dateTimeNotifier.value,
                                      firstDate: _dateTimeNotifier.value,
                                      lastDate: DateTime(2025),
                                      title: 'Select Date',
                                      onDatedSelected:
                                          searchViewModel.saveReturnDate,
                                    ),
                                  ],
                                ),
                              ],
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
                                                  MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    //인원 감소 버튼
                                                    child: const Icon(
                                                        Icons.remove),
                                                  ),
                                                  onTap: () {
                                                    searchViewModel
                                                        .decreasePerson();
                                                  },
                                                ),
                                                const Gap(40),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    '${state.currentPersonValue}',
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                const Gap(40),
                                                InkWell(
                                                  child: Container(
                                                    //인원 증가 버튼
                                                    child:
                                                        const Icon(Icons.add),
                                                  ),
                                                  onTap: () {
                                                    searchViewModel
                                                        .increasePerson();
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
                                                  value: state.selectClass,
                                                  items: state.selectedClassList
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
                                                    if (value != null) {
                                                      searchViewModel
                                                          .onChangeClass(value);
                                                    }
                                                  },
                                                  isExpanded: false,
                                                ),
                                              ),
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
                        ],
                      ),
                    ),
                    const Gap(30),
                    InkWell(
                      onTap: () async {
                        await searchViewModel.setNumberOfPeople();
                        await searchViewModel.searchFilght();
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
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: state.isLoading
                            ? const CircularProgressIndicator()
                            : const Text(
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
}
