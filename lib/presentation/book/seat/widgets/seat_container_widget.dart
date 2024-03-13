import 'package:flutter/material.dart';

import '../../../../utils/simple_logger.dart';

class SeatContainer extends StatefulWidget {
  final Color color;
  final bool isSelected;
  final int index;
  final List<String> list;
  final int bookIdListLength;

  const SeatContainer(
      {super.key,
      required this.color,
      required this.isSelected,
      required this.index,
      required this.list,
      required this.bookIdListLength});

  @override
  State<SeatContainer> createState() => _SeatContainerState();
}

class _SeatContainerState extends State<SeatContainer> {
  bool isFirstSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isFirstSelected ? Colors.red.shade200 : widget.color,
              width: 3,
            ),
            color: isFirstSelected ? Colors.red.shade200 : Colors.transparent,
          ),
          height: 10,
          width: 10,
        ),
        onTap: () {
          if (widget.list.length < widget.bookIdListLength ~/ 2 &&
              isFirstSelected) {
            String selectedSeat = returnSeatString(widget.index);
            logger.info(returnSeatString(widget.index));
            setState(() {
              isFirstSelected = !isFirstSelected;
              isFirstSelected
                  ? widget.isSelected
                      ? widget.list.add(selectedSeat)
                      : null
                  : widget.list
                      .removeWhere((element) => element == selectedSeat);
            });
            logger.info(widget.list);
          }
        });
  }

  String returnSeatString(int index) {
    String result = '';
    switch (index % 7) {
      case 0:
        result += 'A';
        break;
      case 1:
        result += 'B';
        break;
      case 2:
        result += 'C';
        break;
      case 4:
        result += 'D';
        break;
      case 5:
        result += 'E';
        break;
      case 6:
        result += 'F';
        break;
      default:
    }
    return result += (index ~/ 7).toString();
  }
}
