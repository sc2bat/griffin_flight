import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class FlightDetailsCard extends StatelessWidget {
  const FlightDetailsCard(
      {super.key,
      required this.width,
      required this.height,
      required this.title});

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
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('to-from'),
                      Spacer(),
                      Text('특징'),
                    ],
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('시간'),
                      subtitle: Text('소요시간'),
                      trailing: Text(
                        '금액',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text('항공편 정보'),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
