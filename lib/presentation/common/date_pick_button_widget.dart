import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class DatePickButtonWidget extends StatefulWidget {
  const DatePickButtonWidget(
      {super.key,
      required this.title,
      this.initialDate,
      required this.textAlign,
      required this.lastDate,
      required this.firstDate,
      required this.selectedTextStyle,
      required this.defaultTextStyle,
      required this.onDatedSelected});

  final String title;
  final TextStyle selectedTextStyle;
  final TextStyle defaultTextStyle;
  final AlignmentGeometry textAlign;
  final DateTime? initialDate;
  final DateTime lastDate;
  final DateTime firstDate;
  final void Function(DateTime) onDatedSelected;

  @override
  State<DatePickButtonWidget> createState() => _DatePickButtonWidgetState();
}

class _DatePickButtonWidgetState extends State<DatePickButtonWidget> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    TextStyle effectiveTextStyle =
        date != null ? widget.selectedTextStyle : widget.defaultTextStyle;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyCard,
        borderRadius: BorderRadius.circular(3),
      ),
      child: TextButton(
        style: TextButton.styleFrom(padding: EdgeInsets.zero),
        onPressed: () async {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: widget.initialDate,
            lastDate: widget.lastDate,
            firstDate: widget.firstDate,
            initialEntryMode: DatePickerEntryMode.calendarOnly,
          );
          if (selectedDate != null) {
            setState(() {
              date = selectedDate;
            });
            widget.onDatedSelected(selectedDate);
          }
        },
        child: Align(
          alignment: widget.textAlign,
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Text(
                date != null
                    ? '${date!.year.toString()}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}'
                    : widget.title,
                style: effectiveTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
