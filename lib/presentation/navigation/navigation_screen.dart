import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:griffin/presentation/mypage/mypage_screen.dart';
import 'package:provider/provider.dart';

import '../../di/get_it.dart';
import '../my_books/my_books_screen.dart';
import '../my_books/my_books_view_model.dart';
import '../mypage/mypage_view_model.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final PageController _pageViewController = PageController();
  int _selectedIndex = 0;

  void _updateCurrentPageIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageViewController,
        children: [
          ChangeNotifierProvider(
              create: (_) => getIt<MyBooksViewModel>(),
              child: const MyBooksScreen()),
          ChangeNotifierProvider(
            create: (_) => getIt<MypageViewModel>(),
            child: const MypageScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Transform.rotate(
              angle: math.pi / 3,
              child: const Icon(
                Icons.flight,
              ),
            ),
            label: 'Book',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: 'Trips',
          ),
        ],
        selectedItemColor: const Color(0xFFF88264),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          _updateCurrentPageIndex(index);
        },
      ),
    );
  }
}
