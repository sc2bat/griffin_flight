import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/book/seat/seat_view_model.dart';
import 'package:griffin/presentation/book/seat/widgets/column_number_widget.dart';
import 'package:griffin/presentation/book/seat/widgets/seat_container_widget.dart';
import 'package:griffin/presentation/book/seat/widgets/seat_label_widget.dart';
import 'package:provider/provider.dart';

import '../../../domain/model/books/books_model.dart';
import '../../common/colors.dart';
import '../../common/common_button.dart';

class SeatScreen extends StatefulWidget {
  final List<BooksModel> departureBookList;
  final List<BooksModel> arrivalBookList;

  const SeatScreen({
    super.key,
    required this.departureBookList,
    required this.arrivalBookList,
  });

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
  final int _numberOfPeople = 2;
  final List<String> selectedSeatList = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final seatViewModel = context.read<SeatViewModel>();
      seatViewModel.init();
    });
    _tabController = TabController(
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SeatViewModel>();
    final state = viewModel.state;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/book/passport');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Departure Seat'),
            Tab(text: 'Return Seat'),
          ],
          isScrollable: true,
          indicatorColor: Colors.red[200],
          labelColor: Colors.red[200],
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          labelPadding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
          unselectedLabelColor: AppColors.greyText,
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: 98,
                      itemBuilder: (BuildContext context, int index) {
                        //인덱스 0~6 : 알파벳 행
                        if (index < 7) {
                          //통로 알파벳 비우고, 건너뛰기
                          if (index == 3) return const Text('');
                          int charCode = 'A'.codeUnitAt(0) +
                              (index > 3 ? index - 1 : index);
                          return Center(
                            child: Text(
                              String.fromCharCode(charCode),
                            ),
                          );
                        }
                        //인덱스 7개 제외
                        int adjustedIndex = index - 7;
                        //인덱스 3은 통로
                        if (index % 7 == 3) {
                          //행넘버 계산
                          int rowNumber = (adjustedIndex / 7).floor() + 1;
                          return ColumnNumber(number: rowNumber);
                        }
                        if (adjustedIndex < 7) {
                          return SeatContainer(
                            color: AppColors.orangeColor,
                            isSelected:
                                selectedSeatList.length < _numberOfPeople,
                            index: index,
                            list: selectedSeatList,
                            bookIdListLength: widget.departureBookList.length,
                            isDeparture: _tabController.index == 0,
                          );
                        } else if (adjustedIndex < 21) {
                          // return BusinessClass();
                          return SeatContainer(
                            color: AppColors.greenColor,
                            isSelected:
                                selectedSeatList.length < _numberOfPeople,
                            list: selectedSeatList,
                            index: index,
                            bookIdListLength: widget.departureBookList.length,
                            isDeparture: _tabController.index == 0,
                          );
                        } else {
                          // return EconomyClass();
                          return SeatContainer(
                            color: Colors.blue,
                            isSelected:
                                selectedSeatList.length < _numberOfPeople,
                            list: selectedSeatList,
                            index: index,
                            bookIdListLength: widget.departureBookList.length,
                            isDeparture: _tabController.index == 0,
                          );
                        }
                      }),
                ),
                const SizedBox(height: 20),
                const SeatLabelWidget(),
                const SizedBox(height: 10),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('TOTAL FARE',
                            style: TextStyle(color: AppColors.greyText)),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.attach_money),
                            Text('${state.totalFare}',
                                style: const TextStyle(
                                  fontSize: 20,
                                )),
                          ],
                        ),
                      ),
                    ),
                    CommonButton(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.12,
                      text: 'Continue',
                      onTap: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text(
                                  'Proceed to payment?',
                                  style: TextStyle(fontSize: 20),
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text('NO'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // if (mounted) {
                                        //   context.push('/book/passport/seat',
                                        //       extra: {
                                        //         "bookIdList": widget.bookIdList
                                        //       });
                                        // }
                                      },
                                      child: const Text('YES'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
