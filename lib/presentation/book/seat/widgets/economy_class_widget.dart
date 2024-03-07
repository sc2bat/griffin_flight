import 'package:flutter/material.dart';

class EconomyClass extends StatefulWidget {
  const EconomyClass({super.key});

  @override
  State<EconomyClass> createState() => _EconomyClassState();
}

class _EconomyClassState extends State<EconomyClass> {
  bool isEconomySelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isEconomySelected? Colors.pink.shade50 : Colors.blue,
            width: 3,
          ),
          color: isEconomySelected ? Colors.pink.shade50 : Colors.transparent,
        ),
        height: 10,
        width: 10,
      ),
      onTap: () {
        setState(() {
          isEconomySelected = !isEconomySelected;
        });
      },
    );
  }
}
