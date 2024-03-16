import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/data/dtos/passport_dto.dart';
import 'package:griffin/presentation/book/passport/widgets/custom_textfield_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/gender_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/phone_textfield_widget.dart';
import 'package:griffin/presentation/common/colors.dart';
import 'package:griffin/presentation/common/common_button.dart';

import '../../../../domain/model/books/books_model.dart';
import '../../../../utils/simple_logger.dart';

class PassportFormWidget extends StatefulWidget {
  final Function(PassportDTO passportDTO) savePassportData;
  final Future<void> Function() postPassportData;
  final List<BooksModel> departureBookList;
  final List<BooksModel> arrivalBookList;
  final int numberOfPeople;
  final List<PassportDTO> passportDTOList;
  final TabController tabController;

  const PassportFormWidget({
    super.key,
    required this.savePassportData,
    required this.numberOfPeople,
    required this.postPassportData,
    required this.departureBookList,
    required this.arrivalBookList,
    required this.passportDTOList,
    required this.tabController,
  });

  @override
  State<PassportFormWidget> createState() => _PassportFormWidgetState();
}

class _PassportFormWidgetState extends State<PassportFormWidget> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isSaving = false;
  Gender? selectedGender;
  String? selectedCountry;
  DateTime? date;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  // FirstName 유효성 검사
  String? firstNameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'First name is required.';
    }
    return null;
  }

// LastName 유효성 검사
  String? lastNameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Last name is required.';
    }
    return null;
  }

// Email 유효성 검사
  String? emailValidate(String? value) {
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    if (!emailRegExp.hasMatch(value)) {
      return 'Please match the requested format.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            GenderSelectionWidget(
              onGenderSelected: (Gender gender) {
                setState(() {
                  selectedGender = gender;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomTextFieldWidget(
                    hintText: 'FIRST NAME',
                    controller: firstNameController,
                    keyboardType: TextInputType.text,
                    validator: firstNameValidate,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: CustomTextFieldWidget(
                    hintText: 'LAST NAME',
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    validator: lastNameValidate,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            CustomTextFieldWidget(
              hintText: 'EMAIL',
              controller: emailController,
              validator: emailValidate,
            ),
            const SizedBox(height: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your ticket will be sent to above email',
                style: TextStyle(color: AppColors.greyText),
              ),
            ),
            const SizedBox(height: 30),
            PhoneTextFieldWidget(
              controller: phoneNumberController,
              onPhoneNumberChanged: (number) {},
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 180,
                  decoration: BoxDecoration(
                    color: AppColors.greyCard,
                    borderRadius: BorderRadius.circular(3),
                    border: Border(
                      bottom: BorderSide(
                        color: date == null
                            ? const Color(0xFFE5ACA6)
                            : Colors.transparent,
                      ),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        lastDate: DateTime.now(),
                        firstDate: DateTime(1800),
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
                            : 'DOB',
                        style: TextStyle(
                            fontSize: 16,
                            color: date == null
                                ? AppColors.greyText
                                : Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: date == null,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'DOB is required.',
                      style: TextStyle(fontSize: 12, color: Color(0xFFE5ACA6)),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CommonButton(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.12,
                        text: widget.numberOfPeople !=
                                widget.tabController.index + 1
                            ? 'Save'
                            : 'Continue',
                        onTap: widget.numberOfPeople !=
                                widget.tabController.index + 1
                            ? () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  await widget.savePassportData(PassportDTO(
                                    gender:
                                        selectedGender == Gender.male ? 0 : 1,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    birthday:
                                        '${date?.year}${date?.month.toString().padLeft(2, '0')}${date?.day.toString().padLeft(2, '0')}',
                                    email: emailController.text,
                                    phone: phoneNumberController.text,
                                  ));
                                }
                                setState(() {
                                  widget.tabController.animateTo(
                                      widget.tabController.index + 1);
                                });
                                logger.info('save button');
                              }
                            : () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  await widget.savePassportData(PassportDTO(
                                    gender:
                                        selectedGender == Gender.male ? 0 : 1,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    birthday:
                                        '${date?.year}${date?.month.toString().padLeft(2, '0')}${date?.day.toString().padLeft(2, '0')}',
                                    email: emailController.text,
                                    phone: phoneNumberController.text,
                                  ));
                                }
                                await widget.postPassportData();
                                if (mounted) {
                                  context.push(
                                    '/book/passport/seat',
                                    extra: {
                                      "departure_flight":
                                          widget.departureBookList,
                                      "arrival_flight": widget.arrivalBookList
                                    },
                                  );
                                }
                              }),
                  ],
                )
              ],
            ),
          ],
        ));
  }
}
