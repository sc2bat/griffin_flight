import 'package:flutter/material.dart';

import '../../../common/colors.dart';

class BusinessClass extends StatefulWidget {
  const BusinessClass({super.key});

  @override
  State<BusinessClass> createState() => _BusinessClassState();
}

class _BusinessClassState extends State<BusinessClass> {
  bool isBusinessSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isBusinessSelected? Colors.pink.shade50 : AppColors.greenColor,
            width: 3,
          ),
          color: isBusinessSelected ? Colors.pink.shade50 : Colors.transparent,
        ),
        height: 10,
        width: 10,
      ),
      onTap: () {
        setState(() {
          isBusinessSelected = !isBusinessSelected;
        });
      },
    );
  }
}
