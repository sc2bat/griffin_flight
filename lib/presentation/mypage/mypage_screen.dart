import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:griffin/presentation/mypage/mypage_state.dart';
import 'package:griffin/presentation/mypage/mypage_view_model.dart';
import 'package:provider/provider.dart';

class MypageScreen extends StatefulWidget {
  const MypageScreen({super.key});

  @override
  State<MypageScreen> createState() => _MypageScreenState();
}

class _MypageScreenState extends State<MypageScreen>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;

  List<Widget> pages = <Widget>[
    const Text('Upcoming'),
    const Text('Past'),
  ];

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    Future.microtask(() {
      final MypageViewModel mypageViewModel = context.read<MypageViewModel>();
      mypageViewModel.init();
    });
    _pageViewController = PageController();

    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MypageViewModel mypageViewModel = context.watch<MypageViewModel>();
    final MypageState mypageState = mypageViewModel.mypageState;
    // List<bool> selectedPage = [true, false];
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              //테두리 모양 조절
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
            ),
            child: const Text('LOG OUT', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  16.0,
                ),
              ),
              color: Colors.white30,
            ),
            child: ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                mypageViewModel.updateToggle(index);
                _updateCurrentPageIndex(index);
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.red[700],
              selectedColor: Colors.white,
              fillColor: Colors.red[200],
              color: Colors.red[400],
              constraints: BoxConstraints(
                minHeight: 48.0,
                minWidth: MediaQuery.of(context).size.width * 0.3,
              ),
              isSelected: mypageState.selectedPage,
              children: pages,
            ),
          ),
          mypageState.isLoading
              ? const CircularProgressIndicator()
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: PageView(
                      controller: _pageViewController,
                      onPageChanged: _handlePageViewChanged,
                      children: [
                        PageViewListWidget(
                            ticketList: mypageState.upcomingList),
                        PageViewListWidget(ticketList: mypageState.pastList),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class PageViewListWidget extends StatelessWidget {
  const PageViewListWidget({
    super.key,
    required this.ticketList,
  });
  final List<Map<String, dynamic>> ticketList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemCount: ticketList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> item = ticketList[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    16.0,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'FROM',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                        Transform.rotate(
                          angle: math.pi / 2,
                          child: const Icon(
                            Icons.flight,
                            color: Colors.black54,
                          ),
                        ),
                        const Text(
                          'TO',
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item['fromAirportCode']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${item['toAirportCode']}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item['fromCountry']}, ${item['fromCountryCode']}',
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${item['toCountry']}, ${item['toCountryCode']}',
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item['fromTime']}',
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '${item['toTime']}',
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Terminal 3',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Terminal 2',
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
