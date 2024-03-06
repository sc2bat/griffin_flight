import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

enum Gender { male, female, none }

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({super.key, required this.onGenderSelected});

  final Function(Gender) onGenderSelected;

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  Gender selectedGender = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            selectedGender = Gender.male;
            widget.onGenderSelected(selectedGender);
            setState(() {});
          },
          icon: Icon(
            selectedGender == Gender.male
                ? Icons.check_circle
                : Icons.circle_outlined,
            size: 20,
            color: selectedGender == Gender.male ? AppColors.orangeColor : null,
          ),
        ),
        const Text('Male'),
        const SizedBox(width: 40),
        IconButton(
          onPressed: () {
            selectedGender = Gender.female;
            widget.onGenderSelected(selectedGender);
            setState(() {});
          },
          icon: Icon(
            selectedGender == Gender.female
                ? Icons.check_circle
                : Icons.circle_outlined,
            size: 20,
            color:
                selectedGender == Gender.female ? AppColors.orangeColor : null,
          ),
        ),
        const Text('Female')
      ],
    );
  }
}
