import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/data/dtos/books_dto.dart';
import 'package:griffin/presentation/book/seat/seat_view_model.dart';
import 'package:griffin/presentation/book/seat/widgets/seat_tab_widget.dart';
import 'package:provider/provider.dart';
import '../../../domain/model/books/books_model.dart';
import '../../common/colors.dart';
import '../../common/common_dialog.dart';

class SeatScreen extends StatefulWidget {
  final List<BooksModel> departureBookList;
  final List<BooksModel> arrivalBookList;

  const SeatScreen({
    super.key,
    required this.departureBookList,
    required this.arrivalBookList,
  });

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final seatViewModel = context.read<SeatViewModel>();
      seatViewModel.init(widget.departureBookList, widget.arrivalBookList);
    });
    _tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
      animationDuration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SeatViewModel>();
    final state = viewModel.state;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => CommonDialog(
              title: 'Quit Registration?',
              subtitle: 'Any information you have entered will not be saved.',
              noOnTap: () => Navigator.pop(context),
              yesOnTap: () => context.go('/search'),
            ),
          ),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Departure Seat'),
            Tab(text: 'Arrival Seat'),
          ],
          isScrollable: true,
          indicatorColor: Colors.red[200],
          labelColor: Colors.red[200],
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          labelPadding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
          unselectedLabelColor: AppColors.greyText,
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: List.generate(
          2,
          (index) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SeatTabWidget(
              numberOfPeople: state.numberOfPeople,
              tabController: _tabController,
              saveSeatData: (booksDTO) => viewModel.saveSeat(booksDTO),
              updateBookData: () =>
                  viewModel.updateBookData(),
              totalFare: state.totalFare,
              departureSelectedSeats: state.departureSelectedSeats,
              arrivalSelectedSeats: state.arrivalSelectedSeats,
              departureBookList: state.departureBookList,
              arrivalBookList: state.arrivalBookList,
            ),
          ),
        ),
      ),
    ));
  }
}
