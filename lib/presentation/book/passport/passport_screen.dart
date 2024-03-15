import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/domain/model/books/books_model.dart';
import 'package:griffin/presentation/book/passport/passport_view_model.dart';
import 'package:griffin/utils/simple_logger.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import 'widgets/passport_form_widget.dart';

class PassportScreen extends StatefulWidget {
  final List<BooksModel> departureBookList;
  final List<BooksModel> arrivalBookList;

  const PassportScreen({
    super.key,
    required this.departureBookList,
    required this.arrivalBookList,
  });

  @override
  State<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends State<PassportScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final validationCodeController = TextEditingController();
  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<GlobalKey<FormState>> _formKeyList = [];

  @override
  void initState() {
    Future.microtask(() {
      final passportViewModel = context.read<PassportViewModel>();
      passportViewModel.init(widget.departureBookList, widget.arrivalBookList);
    });

    logger.info(widget.departureBookList.length);
    _formKeyList = List.generate(
        widget.departureBookList.length, (index) => GlobalKey<FormState>());
    _tabController = TabController(
      initialIndex: 0,
      length: widget.departureBookList.length,
      vsync: this,
      animationDuration: const Duration(milliseconds: 150),
    );
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    validationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PassportViewModel>();
    final state = viewModel.state;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Traveller Details'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.go('/book');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: List.generate(
            widget.departureBookList.length,
            (index) => Tab(text: 'Person ${index + 1}'),
          ),
          isScrollable: true,
          indicatorColor: AppColors.greenColor,
          labelColor: AppColors.greenColor,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold),
          labelPadding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.2),
          unselectedLabelColor: AppColors.greyText,
          overlayColor: const MaterialStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          onTap: (index) {},
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(
          widget.departureBookList.length,
          (index) {
            TextEditingController nameController = TextEditingController();
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: PassportFormWidget(
                formKeyList: _formKeyList,
                viewModel: viewModel,
                state: state,
                mounted: mounted,
              ),
            );
          },
        ),
      ),
    );
  }
}
