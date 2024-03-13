import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/book/seat/widgets/column_number_widget.dart';
import 'package:griffin/presentation/book/seat/widgets/first_class_widget.dart';
import 'package:griffin/presentation/book/seat/widgets/seat_label_widget.dart';

import '../../common/colors.dart';
import '../../common/common_button.dart';

class SeatScreen extends StatefulWidget {
  const SeatScreen({super.key});

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  final int _numberOfPeople = 2;
  final List<String> selectedSeatList = [];

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Select Seats'),
        ),
        body: Padding(
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
                        return FirstClass(
                          color: AppColors.orangeColor,
                          isSelected: selectedSeatList.length < _numberOfPeople,
                          index: index,
                          list: selectedSeatList,
                        );
                      } else if (adjustedIndex < 21) {
                        // return BusinessClass();
                        return FirstClass(
                          color: AppColors.greenColor,
                          isSelected: selectedSeatList.length < _numberOfPeople,
                          list: selectedSeatList,
                          index: index,
                        );
                      } else {
                        // return EconomyClass();
                        return FirstClass(
                          color: Colors.blue,
                          isSelected: selectedSeatList.length < _numberOfPeople,
                          list: selectedSeatList,
                          index: index,
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
                  const Expanded(
                    child: ListTile(
                      title: Text('TOTAL FARE',
                          style: TextStyle(color: AppColors.greyText)),
                      subtitle: Row(
                        children: [
                          Icon(Icons.attach_money),
                          Text('금액정보'),
                        ],
                      ),
                    ),
                  ),
                  CommonButton(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.12,
                    text: 'Continue',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
