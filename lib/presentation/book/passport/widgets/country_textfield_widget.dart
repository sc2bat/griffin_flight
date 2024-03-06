import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../../../../utils/simple_logger.dart';
import '../../../common/colors.dart';

class CountryTextFieldWidget extends StatefulWidget {
  const CountryTextFieldWidget({
    super.key,
    required this.initialCountryValue,
    required this.textStyle,
    required this.onCountrySelected,
  });

  final String initialCountryValue;
  final TextStyle textStyle;
  final void Function(String) onCountrySelected;

  @override
  State<CountryTextFieldWidget> createState() => _CountryTextFieldWidgetState();
}

class _CountryTextFieldWidgetState extends State<CountryTextFieldWidget> {
  String? countryValue;
  TextStyle? currentTextStyle;
  bool isEmpty = true;

  @override
  void initState() {
    super.initState();
    countryValue = widget.initialCountryValue;
    currentTextStyle = widget.textStyle;
    isEmpty = true;
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
    return Center(
      child: Column(children: [
        CSCPicker(
          key: _cscPickerKey,
          showStates: false,
          dropdownDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
            color: AppColors.greyCard,
          ),
          countrySearchPlaceholder: "Search",
          countryDropdownLabel: countryValue!,
          dropdownItemStyle: const TextStyle(
            fontSize: 16,
          ),
          selectedItemStyle: currentTextStyle,
          onCountryChanged: (value) {
            logger.info('$isEmpty');
            setState(() {
              countryValue = value;
              // currentTextStyle =
              //     const TextStyle(fontSize: 16, color: Colors.white);
              // isEmpty = false;
              logger.info('$isEmpty');
            });
            widget.onCountrySelected(value);
          },
        ),
        isEmpty
            ? const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nationality is required.',
                  style: TextStyle(fontSize: 12, color: Color(0xFFE5ACA6)),
                ),
              )
            : const Text('')
      ]),
    );
  }
}
