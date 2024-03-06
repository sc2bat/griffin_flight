import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/common/colors.dart';
import 'package:griffin/presentation/mybooks/my_books_view_model.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({super.key});

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyBooksViewModel>();
    final state = viewModel.state;
    final beforePayList =
        state.myBooksList.where((e) => e.payStatus == 0).toList();
    final afterPayList =
        state.myBooksList.where((e) => e.payStatus == 1).toList();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text('나의 예약'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 53,
              width: MediaQuery.of(context).size.width * 0.5,
              child: AnimatedButtonBar(
                radius: 24.0,
                padding: const EdgeInsets.all(3.0),
                backgroundColor: Colors.white,
                foregroundColor: AppColors.greyCard,
                elevation: 24,
                borderColor: Colors.white,
                borderWidth: 3,
                innerVerticalPadding: 5,
                children: [
                  ButtonBarEntry(
                      onTap: () => _pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: const Text('결제 전',
                          style: TextStyle(color: Colors.white))),
                  ButtonBarEntry(
                      onTap: () => _pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut),
                      child: const Text('결제 완료',
                          style: TextStyle(color: Colors.white))),
                ],
              ),
            ),
            (state.isLoading)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: (beforePayList.isEmpty)
                                  ? const Center(child: Text('예약 내역이 없습니다.'))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: beforePayList.length,
                                      itemBuilder: (context, index) {
                                        final myBookItem = beforePayList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            viewModel.forPaymentCheckBoxTap(
                                                myBookItem);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  myBookItem
                                                                      .departureCode!,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .flight_takeoff,
                                                                    color: Colors
                                                                        .pink,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0),
                                                                  child: Text(
                                                                    myBookItem
                                                                        .arrivalCode!,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              '탑승일: ${myBookItem.flightDate}',
                                                              style: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            Text(
                                                              '탑승자명: ${myBookItem.passengerName}',
                                                              style: const TextStyle(
                                                                  fontSize: 13,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.15),
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text('결제',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black)),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      RoundCheckBox(
                                                        isRound: false,
                                                        checkedWidget:
                                                            const Icon(
                                                                Icons.check,
                                                                size: 14),
                                                        uncheckedColor:
                                                            Colors.grey,
                                                        checkedColor:
                                                            Colors.green,
                                                        size: 14,
                                                        isChecked: (viewModel
                                                                .forPaymentList
                                                                .contains(
                                                                    myBookItem))
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
                                  context.go('/pay',
                                      extra: viewModel.forPaymentList);
                                }
                              },
                              style: ButtonStyle(
                                //테두리 모양 조절
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              child: const Text('선택 완료',
                                  style: TextStyle(color: Colors.white)),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: (afterPayList.isEmpty)
                                  ? const Center(child: Text('결제완료 내역이 없습니다.'))
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: afterPayList.length,
                                      itemBuilder: (context, index) {
                                        final myBookItem = afterPayList[index];
                                        return Container(
                                          margin: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(12.0),
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
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                myBookItem
                                                                    .departureCode!,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .flight_takeoff,
                                                                  color: Colors
                                                                      .pink,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                  myBookItem
                                                                      .arrivalCode!,
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .black,
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
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            '탑승일: ${myBookItem.flightDate}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          Text(
                                                            '탑승자명: ${myBookItem.passengerName}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ]),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.15),
                                              const Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('결제',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.grey)),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('완료',
                                                        style: TextStyle(
                                                            color: Colors.grey))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ],
        ));
  }
}
