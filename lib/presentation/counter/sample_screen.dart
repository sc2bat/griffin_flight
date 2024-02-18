import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:griffin/domain/model/airport_model.dart';
import 'package:griffin/presentation/counter/sample_provider.dart';
import 'package:griffin/utils/simple_logger.dart';

class SampleScreen extends ConsumerStatefulWidget {
  const SampleScreen({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<SampleScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   ref.read(sampleProvider);
  //   final sampleNotifier = ref.watch(sampleProvider.notifier);
  //   sampleNotifier.fetch();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final sampleNotifier = ref.watch(sampleProvider.notifier);
    sampleNotifier.fetch();
  }

  @override
  Widget build(BuildContext context) {
    logger.info('build');
    final airportList = ref.watch(sampleProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child:
            // TestColumn(),
            ColumnList(airportList: airportList),
      ),
    );
  }
}

class TestColumn extends StatelessWidget {
  const TestColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('title'),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 300.0,
            color: Colors.blueAccent,
            child: const Row(
              children: [
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 300.0,
            color: Colors.amber,
            child: const Row(
              children: [
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 300.0,
            color: Colors.blueAccent,
            child: const Row(
              children: [
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
              ],
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 300.0,
            color: Colors.amber,
            child: const Row(
              children: [
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
                Text('qwerasdf'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ColumnList extends StatelessWidget {
  const ColumnList({
    super.key,
    required this.airportList,
  });

  final List<AirportModel> airportList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        airportList.length,
        (index) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: 120.0,
            color: index % 2 == 0 ? Colors.amber : Colors.blueAccent,
            child: Row(
              children: [
                Text('airportId ${airportList[index].airportId}'),
                const SizedBox(
                  width: 24.0,
                ),
                Text('airportCode ${airportList[index].airportCode}'),
                const SizedBox(
                  width: 24.0,
                ),
                Text('airportName ${airportList[index].airportName}'),
                const SizedBox(
                  width: 24.0,
                ),
                Text('latitude ${airportList[index].latitude}'),
                const SizedBox(
                  width: 24.0,
                ),
                Text('longitude ${airportList[index].longitude}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
