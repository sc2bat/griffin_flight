import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class FlightDetailsCard extends StatelessWidget {
  const FlightDetailsCard({super.key, required this.width, required this.height});
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.greyCard,
      child: SizedBox(
        height: height,
        width: width,
      ),
    );
  }
}
