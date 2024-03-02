import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/mybooks/my_books_view_model.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyBooksViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        leading: const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            '나의 예약',
          ),
        ),
      ),
      body: (state.isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: (state.myBooksList.isEmpty)
                      ? const Center(child: Text('예약 내역이 없습니다.'))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.myBooksList.length,
                          itemBuilder: (context, index) {
                            final myBookItem = state.myBooksList[index];
                            return GestureDetector(
                              onTap: (myBookItem.payStatus! == 1)
                                  ? () {}
                                  : () {
                                      viewModel
                                          .forPaymentCheckBoxTap(myBookItem);
                                    },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '예약번호: ${myBookItem.bookId}',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      myBookItem.departureCode!,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Icon(
                                                        Icons.flight_takeoff,
                                                        color: Colors.pink,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        myBookItem.arrivalCode!,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '탑승일: ${myBookItem.flightDate}',
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black),
                                                ),
                                                Text(
                                                  '탑승자명: ${myBookItem.passengerName}',
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.black),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.15),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('결제',
                                              style: TextStyle(
                                                  color:
                                                      (myBookItem.payStatus! ==
                                                              1)
                                                          ? Colors.grey
                                                          : Colors.black)),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          (myBookItem.payStatus! == 1)
                                              ? const Text('완료',
                                                  style: TextStyle(
                                                      color: Colors.grey))
                                              : RoundCheckBox(
                                                  isRound: false,
                                                  checkedWidget: const Icon(
                                                      Icons.check,
                                                      size: 14),
                                                  uncheckedColor: Colors.grey,
                                                  checkedColor: Colors.green,
                                                  size: 14,
                                                  isChecked: (viewModel
                                                          .forPaymentList
                                                          .contains(myBookItem))
                                                      ? true
                                                      : false,
                                                  onTap: (selected) {
                                                    viewModel
                                                        .forPaymentCheckBoxTap(
                                                            myBookItem);
                                                  },
                                                )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (viewModel.forPaymentList.isNotEmpty) {
                      context.go('/pay', extra: viewModel.forPaymentList);
                    }
                  },
                  style: ButtonStyle(
                    //테두리 모양 조절
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                  ),
                  child: const Text('선택 완료',
                      style: TextStyle(color: Colors.white)),
                )
              ],
            ),
    );
  }
}
