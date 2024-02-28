import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:griffin/presentation/book/passport/widgets/custom_textfield_widget.dart';
import 'package:griffin/presentation/book/passport/widgets/gender_widget.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traveller Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const GenderSelectionWiget(),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomTextFieldWidget(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    flex: 1,
                    child: CustomTextFieldWidget(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                ],
              ),
            ),
            CustomTextFieldWidget(hintText: 'test', controller: emailController)
          ],
        ),
      ),
    );
  }
}
