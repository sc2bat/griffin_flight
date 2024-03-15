import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/book/passport/passport_state.dart';
import 'package:griffin/presentation/book/passport/passport_view_model.dart';
import 'package:griffin/presentation/book/passport/widgets/country_textfield_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/custom_textfield_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/gender_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/phone_textfield_widget.dart';
import 'package:griffin/presentation/common/colors.dart';
import 'package:griffin/presentation/common/common_button.dart';

class PassportFormWidget extends StatefulWidget {
  const PassportFormWidget({
    super.key,
    required List<GlobalKey<FormState>> formKeyList,
    required this.viewModel,
    required this.state,
    required this.mounted,
  }) : _formKeyList = formKeyList;

  final List<GlobalKey<FormState>> _formKeyList;
  final PassportViewModel viewModel;
  final PassportState state;
  final bool mounted;

  @override
  State<PassportFormWidget> createState() => _PassportFormWidgetState();
}

class _PassportFormWidgetState extends State<PassportFormWidget> {
  late TextEditingController firstNameController;

  late TextEditingController lastNameController;

  late TextEditingController emailController;

  late TextEditingController phoneNumberController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      // key: _formKeys[index],
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          GenderSelectionWidget(
            onGenderSelected: (Gender gender) {
              widget.viewModel.changeGender(gender);
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
                  validator: widget.viewModel.firstNameValidate,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CustomTextFieldWidget(
                  hintText: 'LAST NAME',
                  controller: lastNameController,
                  keyboardType: TextInputType.text,
                  validator: widget.viewModel.lastNameValidate,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          CustomTextFieldWidget(
            hintText: 'EMAIL',
            controller: emailController,
            validator: widget.viewModel.emailValidate,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CountryTextFieldWidget(
                  onCountrySelected: (country) {
                    widget.viewModel.changeNationality(country);
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.greyCard,
                        borderRadius: BorderRadius.circular(3),
                        border: Border(
                          bottom: BorderSide(
                            color: widget.viewModel.state.selectedDate == null
                                ? const Color(0xFFE5ACA6)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await showDatePicker(
                            context: context,
                            lastDate: DateTime.now(),
                            firstDate: DateTime(1800),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                          ).then((date) {
                            if (date != null) {
                              widget.viewModel.changeDob(date);
                            }
                          });
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.viewModel.state.selectedDate != null
                                ? '${widget.viewModel.state.selectedDate!.year.toString()}-${widget.viewModel.state.selectedDate!.month.toString().padLeft(2, '0')}-${widget.viewModel.state.selectedDate!.day.toString().padLeft(2, '0')}'
                                : 'DOB',
                            style: TextStyle(
                                fontSize: 16,
                                color:
                                    widget.viewModel.state.selectedDate == null
                                        ? AppColors.greyText
                                        : Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    widget.viewModel.state.selectedDate == null
                        ? const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'DOB is required.',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFFE5ACA6)),
                            ),
                          )
                        : const Text('')
                  ],
                ),
              )
            ],
          ),
          const Spacer(),
          Column(
            children: [
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('TOTAL FARE',
                          style: TextStyle(color: AppColors.greyText)),
                      subtitle: Row(
                        children: [
                          const Icon(Icons.attach_money),
                          Text('${widget.state.totalFare}',
                              style: const TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                  CommonButton(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.12,
                    text: widget.state.isLoading
                        ? 'Loading...'
                        : widget.state.numberOfPeople !=
                                widget.state.passportDTOList.length
                            ? 'Save'
                            : 'Continue',
                    onTap: widget.state.isLoading
                        ? () {}
                        : widget.state.numberOfPeople !=
                                widget.state.passportDTOList.length
                            ? () {
                                widget.viewModel.savePassport(
                                  firstName: firstNameController.text,
                                  lastName: lastNameController.text,
                                  email: emailController.text,
                                  phone: phoneNumberController.text,
                                );
                                firstNameController.clear();
                                lastNameController.clear();
                                emailController.clear();
                                phoneNumberController.clear();
                              }
                            : () async {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  await widget.viewModel.postPassportData();
                                  if (widget.mounted) {
                                    context.push(
                                      '/book/passport/seat',
                                      extra: {
                                        "departure_flight":
                                            widget.state.departureBookList,
                                        "arrival_flight":
                                            widget.state.arrivalBookList
                                      },
                                    );
                                  }
                                }
                              },
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
