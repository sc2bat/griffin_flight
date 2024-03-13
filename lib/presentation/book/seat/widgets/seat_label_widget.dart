import 'package:flutter/material.dart';

import '../../../common/colors.dart';

class SeatLabelWidget extends StatelessWidget {
  const SeatLabelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.orangeColor,
              width: 3,
            ),
          ),
        ),
        const SizedBox(width: 5),
        const Text('First'),
        const SizedBox(width: 15),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.greenColor,
              width: 3,
            ),
          ),
        ),
        const SizedBox(width: 5),
        const Text('Business'),
        const SizedBox(width: 15),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 3,
            ),
          ),
        ),
        const SizedBox(width: 5),
        const Text('Economy'),
      ],
    );
  }
}
