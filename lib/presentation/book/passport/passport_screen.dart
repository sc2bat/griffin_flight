import 'package:flutter/material.dart';
import 'package:griffin/presentation/book/passport/widgets/custom_textfield_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/gender_widget.dart';
import 'package:griffin/presentation/common/common_button.dart';

import '../../common/colors.dart';

class PassportScreen extends StatefulWidget {
  const PassportScreen({super.key});

  @override
  State<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends State<PassportScreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nationalityController = TextEditingController();
  final dobController = TextEditingController();
  final passportController = TextEditingController();
  final issuingCountryController = TextEditingController();
  final expiryController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    nationalityController.dispose();
    dobController.dispose();
    passportController.dispose();
    issuingCountryController.dispose();
    expiryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traveller Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const GenderSelectionWiget(),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldWidget(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomTextFieldWidget(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                hintText: 'test',
                controller: firstNameController,
              ),
              const SizedBox(height: 10),
              const Text('Your ticket will be sent to abouve email.'),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                hintText: 'test',
                controller: firstNameController,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldWidget(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomTextFieldWidget(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                hintText: 'test',
                controller: firstNameController,
              ),
              const SizedBox(height: 30),
              const Text('PASSPORT DETAILS'),
              const SizedBox(height: 10),
              CustomTextFieldWidget(
                hintText: 'test',
                controller: firstNameController,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldWidget(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: CustomTextFieldWidget(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  const Expanded(
                    child: ListTile(
                      title: Text('TOTAL FARE',
                          style: TextStyle(color: AppColors.greyText)),
                      subtitle: Row(
                        children: [
                          Icon(Icons.attach_money),
                          Text('금액정보'),
                        ],
                      ),
                    ),
                  ),
                  CommonButton(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.12,
                    text: 'Continue',
                    onTap: () {
                    },
                  )
                ],
              ), ],
          ),
        ),
      ),
    );
  }
}
