import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/book/passport/passport_view_model.dart';
import 'package:griffin/presentation/book/passport/widgets/country_textfield_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/custom_textfield_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/gender_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/phone_textfield_widget.dart';
import 'package:griffin/presentation/common/date_pick_button_widget.dart';
import 'package:griffin/presentation/common/total_fare_bar_widget.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';

class PassportScreen extends StatefulWidget {
  const PassportScreen({super.key});

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
  List<GlobalKey<FormState>> _formKeys = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _numberOfPeople,
      vsync: this,
      animationDuration: const Duration(milliseconds: 150),
    );
    _formKeys =
        List.generate(_numberOfPeople, (index) => GlobalKey<FormState>());
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
        bottom: _numberOfPeople > 1
            ? TabBar(
                controller: _tabController,
                tabs: List.generate(
                  _numberOfPeople,
                  (index) => Tab(text: 'Person ${index + 1}'),
                ),
                isScrollable: true,
                indicatorColor: AppColors.greenColor,
                labelColor: AppColors.greenColor,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                labelPadding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.2),
                unselectedLabelColor: AppColors.greyText,
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
              )
            : null,
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          _numberOfPeople,
          (index) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: _formKeys[index],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  GenderSelectionWidget(
                    onGenderSelected: (Gender gender) {},
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
                      onPhoneNumberChanged: (number) {
                      },
                      ),
                  const SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CountryTextFieldWidget(
                          onCountrySelected: (country) {
                          },
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: DatePickButtonWidget(
                          title: 'DOB',
                          textAlign: Alignment.centerLeft,
                          lastDate: DateTime.now(),
                          selectedTextStyle: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          defaultTextStyle: const TextStyle(
                              fontSize: 16, color: AppColors.greyText),
                          firstDate: DateTime(1800),
                          showRequiredText: true,
                          onDatedSelected: (selectedDate) {
                          },
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  TotalFareBarWidget(onTap: () {
                    if (_formKeys[index].currentState?.validate() ?? false) {
                      context.go('/book/passport/seat');
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
