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
      required this.onDatedSelected,
      this.showRequiredText = false});

  final String title;
  final TextStyle selectedTextStyle;
  final TextStyle defaultTextStyle;
  final AlignmentGeometry textAlign;
  final DateTime? initialDate;
  final DateTime lastDate;
  final DateTime firstDate;
  final void Function(DateTime) onDatedSelected;
  final bool showRequiredText;

  @override
  State<DatePickButtonWidget> createState() => _DatePickButtonWidgetState();
}

class _DatePickButtonWidgetState extends State<DatePickButtonWidget> {
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    TextStyle effectiveTextStyle =
        date != null ? widget.selectedTextStyle : widget.defaultTextStyle;

    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.greyCard,
            borderRadius: BorderRadius.circular(3),
            border: Border(
              bottom: BorderSide(
                color: date == null && widget.showRequiredText
                    ? const Color(0xFFE5ACA6)
                    : Colors.transparent,
              ),
            ),
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
                if (date != null) {
                  widget.onDatedSelected(date!);
                }
              }
            },
            child: Align(
              alignment: widget.textAlign,
              child: Column(
                children: [
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
        ),
      ],
    );
  }
}
