import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget(
      {super.key,
        required this.hintText,
        required this.controller,
        this.onChanged,
        this.width});

  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final double? width;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  String textFormFieldText = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: (text) {
        widget.onChanged?.call(text);
        setState(() {
          textFormFieldText = text;
        });
        },
      maxLines: 1,
      style: const TextStyle(decorationThickness: 0),
      decoration: InputDecoration(
          labelText: widget.hintText,
          // 기본 디자인
          filled: true,
          fillColor: AppColors.greyCard,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.transparent),
          ),

          //눌렀을때 디자인
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(color: Colors.transparent),
          )),
    );
  }
}
