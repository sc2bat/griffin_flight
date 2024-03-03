import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class DatePIckButtonWidget extends StatefulWidget {
  const DatePIckButtonWidget({super.key, required this.title});

  final String title;

  @override
  State<DatePIckButtonWidget> createState() => _DatePIckButtonWidgetState();
}

class _DatePIckButtonWidgetState extends State<DatePIckButtonWidget> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.greyCard,
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextButton(
        onPressed: () async {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: date ?? DateTime.now(),
            //달력 초기 날짜
            firstDate: DateTime(1800),
            lastDate: DateTime.now(),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
          );
          if (selectedDate != null) {
            setState(() {
              date = selectedDate;
            });
          }
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            date != null
                ? '${date!.year.toString()}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}'
                : widget.title,
            style: TextStyle(
                fontSize: 16,
                color: date != null ? Colors.white : AppColors.greyText),
          ),
        ),
      ),
    );
  }
}
