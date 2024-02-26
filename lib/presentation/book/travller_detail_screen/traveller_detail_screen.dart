import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:griffin/presentation/book/travller_detail_screen/custom_textfield.dart';
import 'package:griffin/presentation/book/travller_detail_screen/gender_selection_widget.dart';

class TravellerDetailScreen extends StatefulWidget {
  const TravellerDetailScreen({super.key});

  @override
  State<TravellerDetailScreen> createState() => _TravellerDetailScreenState();
}

class _TravellerDetailScreenState extends State<TravellerDetailScreen> {
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
                    child: CustomTextField(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    flex: 1,
                    child: CustomTextField(
                      hintText: 'test',
                      controller: firstNameController,
                    ),
                  ),
                ],
              ),
            ),
            CustomTextField(hintText: 'test', controller: emailController)
          ],
        ),
      ),
    );
  }
}
