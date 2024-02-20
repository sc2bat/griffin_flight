import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.width,
      required this.height,
      required this.text,
      required this.onTap});

  final double width;
  final double height;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orangeColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text(text, style: const TextStyle(color: Colors.black)),
      ),
    );
  }
}
