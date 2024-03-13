import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/presentation/routes.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Griffin Flight',
        ),
      ),
      body: Column(
        children: List.generate(routeList.length, (index) {
          return ListTile(
            title: Text(
              '$index ${routeList[index]}',
            ),
            leading: const Icon(
              Icons.output_rounded,
            ),
            onTap: () => context.push('/${routeList[index]}'),
          );
        }),
      ),
    );
  }
}
