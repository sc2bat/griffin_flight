import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/book/seat/widgets/column_number_widget.dart';
import 'package:griffin/presentation/book/seat/widgets/seat_container_widget.dart';
import 'package:griffin/presentation/book/seat/widgets/seat_label_widget.dart';
import 'package:griffin/presentation/common/common.dart';
import '../../../../data/dtos/passport_dto.dart';
import '../../../../domain/model/books/books_model.dart';
import '../../../../domain/model/flight_result/flight_result_model.dart';
import '../../../../utils/simple_logger.dart';
import '../../../common/colors.dart';
import '../../../common/common_button.dart';

class SeatTabWidget extends StatefulWidget {
  final Function(BooksModel seatList) saveSeatData;
  final Future<void> Function(List<BooksModel> booksModelList) updateBookData;
  final List<BooksModel> departureBookList;
  final List<BooksModel> arrivalBookList;
  final int numberOfPeople;
  final double totalFare;
  final TabController tabController;
  final FlightResultModel? arrivalFlightResultModel;
  final FlightResultModel? departureFlightResultModel;
  final List<String> departureSelectedSeats;
  final List<String> arrivalSelectedSeats;
  final bool isDisabled;

  const SeatTabWidget(
      {super.key,
      required this.numberOfPeople,
      required this.tabController,
      required this.saveSeatData,
      required this.updateBookData,
      required this.departureBookList,
      required this.arrivalBookList,
      this.arrivalFlightResultModel,
      this.departureFlightResultModel,
      required this.totalFare,
      required this.departureSelectedSeats,
      required this.arrivalSelectedSeats,
      this.isDisabled = false});

  @override
  State<SeatTabWidget> createState() => _SeatTabWidgetState();
}

class _SeatTabWidgetState extends State<SeatTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: 98,
              itemBuilder: (BuildContext context, int index) {
                bool isDepartureTab = widget.tabController.index == 0;
                bool isAllSeatsSelected = isDepartureTab
                    ? widget.departureSelectedSeats.length >=
                        widget.departureBookList.length
                    : widget.arrivalSelectedSeats.length >=
                        widget.arrivalBookList.length;
                if (index < 7) {
                  //통로 알파벳 비우고, 건너뛰기
                  if (index == 3) return const Text('');
                  int charCode =
                      'A'.codeUnitAt(0) + (index > 3 ? index - 1 : index);
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
                    color: isAllSeatsSelected
                        ? Colors.grey
                        : AppColors.orangeColor,
                    index: index,
                    bookIdListLength: widget.departureBookList.length,
                    isDeparture: widget.tabController.index == 0,
                    isAllSeatsSelected: isAllSeatsSelected,
                  );
                } else if (adjustedIndex < 21) {
                  // return BusinessClass();
                  return SeatContainer(
                    color:
                        isAllSeatsSelected ? Colors.grey : AppColors.greenColor,
                    index: index,
                    bookIdListLength: widget.departureBookList.length,
                    isDeparture: widget.tabController.index == 0,
                    isAllSeatsSelected: isAllSeatsSelected,
                  );
                } else {
                  // return EconomyClass();
                  return SeatContainer(
                    color: isAllSeatsSelected ? Colors.grey : Colors.blue,
                    index: index,
                    bookIdListLength: widget.departureBookList.length,
                    isDeparture: widget.tabController.index == 0,
                    isAllSeatsSelected: isAllSeatsSelected,
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
                    Text('${(widget.totalFare).toInt().floor()}',
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
                text: widget.tabController.index == 0
                    ? 'Save'
                    : 'Continue',
                onTap: widget.tabController.index == 0
                    ? () async {
                        if (widget.departureSelectedSeats.isNotEmpty) {
                          await widget.saveSeatData;
                          setState(() {
                            widget.tabController
                                .animateTo(widget.tabController.index + 1);
                          });
                        } else {
                          showSnackBar(context, 'Please select the seat');
                        }
                      }
                    : () async {
                  List<String>
                        if (widget.arrivalSelectedSeats.isNotEmpty) {
                          await widget.saveSeatData(BooksModel(
                              bookId: ,
                            classSeat: ,

                          ),
                          );
                          await widget.updateBookData(BooksModel(
                              bookId: 3,
                            classSeat: '',

                          )
                          );
                          showDialog(
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
                                          onPressed: () {
                                            context.push('/navigation');
                                          },
                                          child: const Text('NO'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            // if (mounted) {
                                            //   context.push('/book/passport/seat',
                                            //       extra: {"bookIdList": widget.bookIdList});
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
                          );
                        } else {
                          showSnackBar(context, 'Please select the seat.');
                        }
                      })
          ],
        ),
      ],
    );
  }
}
