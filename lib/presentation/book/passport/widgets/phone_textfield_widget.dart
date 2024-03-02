import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../common/colors.dart';

class PhoneTextFieldWidget extends StatefulWidget {
  const PhoneTextFieldWidget({super.key, required this.controller});

  final TextEditingController controller;

  @override
  State<PhoneTextFieldWidget> createState() => _PhoneTextFieldWidgetState();
}

class _PhoneTextFieldWidgetState extends State<PhoneTextFieldWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String initialCountry = 'KOR';
  PhoneNumber number = PhoneNumber(isoCode: 'KOR');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: AppColors.greyCard,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InternationalPhoneNumberInput(
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN,
              ),
              //phone number 입력
              onInputChanged: (PhoneNumber number) {},
              onInputValidated: (bool value) {},
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: const TextStyle(color: Colors.white),
              initialValue: number,
              textFieldController: widget.controller,
              hintText: '',
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              inputBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              onSaved: (PhoneNumber number) {},
            ),
          ],
        ),
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
