import 'package:flutter/material.dart';

class ColumnNumber extends StatefulWidget {
  final int number;

  const ColumnNumber({super.key, required this.number});

  @override
  State<ColumnNumber> createState() => _ColumnNumberState();
}

class _ColumnNumberState extends State<ColumnNumber> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('${widget.number}')
    );
  }
}
