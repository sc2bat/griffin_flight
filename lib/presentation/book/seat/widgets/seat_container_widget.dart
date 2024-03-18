import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/simple_logger.dart';
import '../seat_view_model.dart';

class SeatContainer extends StatefulWidget {
  final Color color;
  final int index;
  final int bookIdListLength;
  final bool isDeparture;
  final bool isAllSeatsSelected;


  const SeatContainer(
      {super.key,
      required this.color,
      required this.index,
      required this.bookIdListLength,
      required this.isDeparture,
        required this.isAllSeatsSelected,});

  @override
  State<SeatContainer> createState() => _SeatContainerState();
}

class _SeatContainerState extends State<SeatContainer> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SeatViewModel>();
    bool isSelected = viewModel.isSeatSelected(
        returnSeatString(widget.index), widget.isDeparture);
    return GestureDetector(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected ? Colors.red.shade200 : widget.color,
                width: 3,
              ),
              color: isSelected ? Colors.red.shade200 : Colors.transparent,
            ),
            height: 10,
            width: 10,
            child: widget.isAllSeatsSelected && !isSelected
                ? const Center(
                    child: Icon(Icons.close)
                  )
                : null),
        onTap: () {
          String selectedSeat = returnSeatString(widget.index);
          if (!isSelected) {
            viewModel.selectSeat(selectedSeat, widget.isDeparture);
            viewModel.updateFare(widget.index, true);
          } else {
            viewModel.removeSeat(selectedSeat, widget.isDeparture);
          }
          logger.info(widget.isDeparture
              ? viewModel.state.departureSelectedSeats
              : viewModel.state.arrivalSelectedSeats);
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
