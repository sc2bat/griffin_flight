import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function() noOnTap;
  final void Function() yesOnTap;

  const CommonDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.noOnTap,
      required this.yesOnTap});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: Text(title),
              subtitle: Text(subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: noOnTap,
                  child: const Text('NO'),
                ),
                TextButton(
                  onPressed: yesOnTap,
                  child: const Text('YES'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
