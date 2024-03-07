import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import '../../../common/colors.dart';

class CountryTextFieldWidget extends StatefulWidget {
  const CountryTextFieldWidget({
    super.key,
    required this.onCountrySelected,
  });

  final void Function(String) onCountrySelected;

  @override
  State<CountryTextFieldWidget> createState() => _CountryTextFieldWidgetState();
}

class _CountryTextFieldWidgetState extends State<CountryTextFieldWidget> {
  String countryValue = "NATIONALITY";
  TextStyle currentTextStyle =
      const TextStyle(fontSize: 16, color: AppColors.greyText);
  bool isCountryEmpty = true;
  final GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CSCPicker(
        key: _cscPickerKey,
        showStates: false,
        flagState: CountryFlag.DISABLE,
        dropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(3),
          ),
          color: AppColors.greyCard,
          border: Border(
            bottom: BorderSide(
              color:
                  isCountryEmpty ? const Color(0xFFE5ACA6) : Colors.transparent,
            ),
          ),
        ),
        countrySearchPlaceholder: "Search",
        countryDropdownLabel: countryValue,
        dropdownItemStyle: const TextStyle(
          fontSize: 16,
        ),
        selectedItemStyle: currentTextStyle,
        onCountryChanged: (value) {
          setState(() {
            countryValue = value;
            currentTextStyle =
                const TextStyle(fontSize: 16, color: Colors.white);
            isCountryEmpty = false;
          });
          widget.onCountrySelected(value);
        },
      ),
      isCountryEmpty
          ? const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Nationality is required.',
                style: TextStyle(fontSize: 12, color: Color(0xFFE5ACA6)),
              ),
            )
          : const Text('')
    ]);
  }
}
