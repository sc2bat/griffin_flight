import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../../common/colors.dart';

class PhoneTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final void Function(PhoneNumber) onPhoneNumberChanged;

  const PhoneTextFieldWidget({
    super.key,
    required this.controller,
    required this.onPhoneNumberChanged,
  });

  @override
  State<PhoneTextFieldWidget> createState() => _PhoneTextFieldWidgetState();
}

class _PhoneTextFieldWidgetState extends State<PhoneTextFieldWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String initialCountry = 'KOR';
  PhoneNumber number = PhoneNumber(isoCode: 'KOR');
  bool isPhoneEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              border: Border(
                bottom: BorderSide(
                  color: isPhoneEmpty
                      ? const Color(0xFFE5ACA6)
                      : Colors.transparent,
                ),
              ),
              color: AppColors.greyCard,
            ),
            child: InternationalPhoneNumberInput(
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN,
              ),
              textFieldController: widget.controller,
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.white),
              initialValue: number,
              hintText: '',
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              inputBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              onSaved: (PhoneNumber number) {},
              onInputChanged: (PhoneNumber number) {
                setState(() {
                  isPhoneEmpty = false;
                });
              },
            ),
          ),
          const SizedBox(height: 6),
          isPhoneEmpty
              ? const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '     Phone number is required.',
                    style: TextStyle(fontSize: 12, color: Color(0xFFE5ACA6)),
                  ),
                )
              : const Text('')
        ],
      ),
    );
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'KOR');
    setState(() {
      this.number = number;
    });
  }
}
