import 'package:flutter/material.dart';
import 'package:griffin/presentation/common/colors.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Flight Details'),
      ),
      body: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.circle_outlined, color: AppColors.greyColor),
            title: Text('출발지'),
            subtitle: Text('출발지정보'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 40),
            child: Card(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.greyColor,
                ),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.airplanemode_active, color: AppColors.greyColor),
            title: Text('도착지'),
            subtitle: Text('도착지정보'),
          )
        ],
      ),
    );
  }
}
