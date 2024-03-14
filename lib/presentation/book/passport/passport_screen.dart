import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/data/dtos/passport_dto.dart';
import 'package:griffin/domain/model/flight_result/flight_result_model.dart';
import 'package:griffin/presentation/book/passport/passport_view_model.dart';
import 'package:griffin/presentation/book/passport/widgets/country_textfield_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/custom_textfield_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/gender_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/phone_textfield_widget.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../../common/common_button.dart';

class PassportScreen extends StatefulWidget {
  final List<FlightResultModel> departureFlightList;
  final List<FlightResultModel> arrivalFlightList;

  const PassportScreen({
    super.key,
    required this.departureFlightList,
    required this.arrivalFlightList,
  });

  @override
  State<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends State<PassportScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final int _numberOfPeople = 2;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final validationCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // List<GlobalKey<FormState>> _formKeys = [];

  @override
  void initState() {
    Future.microtask(() {
      final passportViewModel = context.read<PassportViewModel>();
      passportViewModel.init();
    });
    super.initState();
    // _tabController = TabController(
    //   length: _numberOfPeople,
    //   vsync: this,
    //   animationDuration: const Duration(milliseconds: 150),
    // );
    // _formKeys =
    //     List.generate(_numberOfPeople, (index) => GlobalKey<FormState>());

    firstNameController.text = 'test';
    lastNameController.text = 'test';
    emailController.text = 'ddd@ddd.com';
    phoneNumberController.text = '01000000';
  }

  @override
  void dispose() {
    _tabController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    validationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PassportViewModel>();
    final state = viewModel.state;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Traveller Details'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/book');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        // bottom: _numberOfPeople > 1
        //     ? TabBar(
        //         controller: _tabController,
        //         tabs: List.generate(
        //           _numberOfPeople,
        //           (index) => Tab(text: 'Person ${index + 1}'),
        //         ),
        //         isScrollable: true,
        //         indicatorColor: AppColors.greenColor,
        //         labelColor: AppColors.greenColor,
        //         labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        //         labelPadding: EdgeInsets.only(
        //             right: MediaQuery.of(context).size.width * 0.2),
        //         unselectedLabelColor: AppColors.greyText,
        //         overlayColor:
        //             const MaterialStatePropertyAll(Colors.transparent),
        //         splashFactory: NoSplash.splashFactory,
        //       )
        //     : null,
      ),
      body:
          // TabBarView(
          //   controller: _tabController,
          //   children: List.generate(
          //     _numberOfPeople,
          //     (index) =>
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          // key: _formKeys[index],
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              GenderSelectionWidget(
                onGenderSelected: (Gender gender) {
                  viewModel.changeGender(gender);
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
                      validator: viewModel.firstNameValidate,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomTextFieldWidget(
                      hintText: 'LAST NAME',
                      controller: lastNameController,
                      keyboardType: TextInputType.text,
                      validator: viewModel.lastNameValidate,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomTextFieldWidget(
                hintText: 'EMAIL',
                controller: emailController,
                validator: viewModel.emailValidate,
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
                        viewModel.changeNationality(country);
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
                                color: viewModel.state.selectedDate == null
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
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                              ).then((date) {
                                if (date != null) {
                                  viewModel.changeDob(date);
                                }
                              });
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                viewModel.state.selectedDate != null
                                    ? '${viewModel.state.selectedDate!.year.toString()}-${viewModel.state.selectedDate!.month.toString().padLeft(2, '0')}-${viewModel.state.selectedDate!.day.toString().padLeft(2, '0')}'
                                    : 'DOB',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: viewModel.state.selectedDate == null
                                        ? AppColors.greyText
                                        : Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        viewModel.state.selectedDate == null
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
                              Text('${widget.totalFare}',
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
                          text: state.isLoading ? 'Loading...' : 'Continue',
                          onTap: state.isLoading
                              ? () {}
                              : () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    await viewModel.postPassportData(
                                        PassportDTO(
                                            gender: state.selectedGender ==
                                                    Gender.male
                                                ? 0
                                                : 1,
                                            firstName: firstNameController.text,
                                            lastName: lastNameController.text,
                                            email: emailController.text,
                                            birthday:
                                                '${state.selectedDate?.year}${state.selectedDate?.month.toString().padLeft(2, '0')}${state.selectedDate?.day.toString().padLeft(2, '0')}',
                                            phone: phoneNumberController.text,
                                            isDeleted: 0),
                                        widget.bookIdList);
                                    if (mounted) {
                                      context.push('/book/passport/seat',
                                          extra: {
                                            "bookIdList": widget.bookIdList,
                                            "totalFare": widget.totalFare
                                          });
                                    }
                                  }
                                }),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
