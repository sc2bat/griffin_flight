import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class FlightIconWidget extends StatelessWidget {
  const FlightIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.circle_outlined, color: AppColors.greyText, size: 20),
         Row(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width*0.02,
                height: MediaQuery.of(context).size.height*0.2),
            DottedDashedLine(
              height: MediaQuery.of(context).size.height*0.22,
              width: MediaQuery.of(context).size.width*0.02,
              axis: Axis.vertical,
              dashColor: AppColors.greyText,
            ),
          ],
        ),
        Image.asset('assets/icons/flightdown.png',
            width: 30, height: 30, color: AppColors.greyText),
      ],
    );
  }
}
