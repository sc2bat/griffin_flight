import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?) validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;

  const CustomTextFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.onChanged,
    required this.validator,
    this.keyboardType,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  String textFormFieldText = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.always,
      controller: widget.controller,
      onChanged: (text) {
        widget.onChanged?.call(text);
        setState(() {
          textFormFieldText = text;
        });
      },
      keyboardType: widget.keyboardType,
      maxLines: 1,
      style: const TextStyle(decorationThickness: 0),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: AppColors.greyText),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.all(15),
        // 기본 디자인
        filled: true,
        fillColor: AppColors.greyCard,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),

        //눌렀을때 디자인
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        ),
      );
  }
}
