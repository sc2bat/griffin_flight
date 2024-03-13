import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';
import 'package:griffin/presentation/common/common_button.dart';

class TotalFareBarWidget extends StatefulWidget {
  const TotalFareBarWidget({super.key, required this.onTap});

  final Function() onTap;

  @override
  State<TotalFareBarWidget> createState() => _TotalFareBarWidgetState();
}

class _TotalFareBarWidgetState extends State<TotalFareBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Row(
          children: [
            const Expanded(
              child: ListTile(
                title: Text('TOTAL FARE',
                    style: TextStyle(color: AppColors.greyText)),
                subtitle: Row(
                  children: [
                    Icon(Icons.attach_money),
                    Text('금액정보'),
                  ],
                ),
              ),
            ),
            CommonButton(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.12,
              text: 'Continue',
              onTap: widget.onTap,
            ),
          ],
        ),
      ],
    );
  }
}
