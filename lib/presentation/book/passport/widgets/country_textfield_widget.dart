import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../../../common/colors.dart';

class CountryTextFieldWidget extends StatefulWidget {
  const CountryTextFieldWidget({super.key, required this.initialCountryValue, required this.textStyle,});

  final String initialCountryValue;
  final TextStyle textStyle;

  @override
  State<CountryTextFieldWidget> createState() => _CountryTextFieldWidgetState();
}

class _CountryTextFieldWidgetState extends State<CountryTextFieldWidget> {
  String? countryValue;
  TextStyle? currentTextStyle;

  @override
  void initState() {
    countryValue = widget.initialCountryValue;
    currentTextStyle = widget.textStyle;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();

    return Center(
        child: Container(
      height: 60,
      child: Column(children: [
        CSCPicker(
          key: _cscPickerKey,
          showStates: false,
          dropdownDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(14),
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
            setState(() {
              countryValue = value;
              currentTextStyle = const TextStyle(fontSize:16, color: Colors.white);
            });
          },
        ),
      ]),
    ));
  }
}
