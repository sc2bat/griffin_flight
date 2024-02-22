import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class FlightDetailsCard extends StatelessWidget {
  const FlightDetailsCard({super.key, required this.width, required this.height, required this.title});
  final double width;
  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.greyCard,
      child: Container(
        height: height,
        width: width,
        child: Text(title)
      ),
    );
  }
}
