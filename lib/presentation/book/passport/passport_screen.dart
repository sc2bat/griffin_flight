import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/domain/model/books/books_model.dart';
import 'package:griffin/presentation/book/passport/passport_view_model.dart';
import 'package:griffin/presentation/book/passport/widgets/passport_form_widget.dart';
import 'package:griffin/presentation/common/common_dialog.dart';
import 'package:griffin/utils/simple_logger.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';

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
  List<GlobalKey<FormState>> _formKeyList = [];

  @override
  void initState() {
    super.initState();
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
        bottom: widget.departureBookList.length > 1
            ? TabBar(
                controller: _tabController,
                tabs: List.generate(
                  widget.departureBookList.length,
                  (index) => Tab(text: 'Person ${index + 1}'),
                ),
                isScrollable: true,
                indicatorColor: Colors.red[200],
                labelColor: Colors.red[200],
                labelStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                labelPadding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.2),
                unselectedLabelColor: AppColors.greyText,
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                onTap: (index) {},
              )
            : null,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: List.generate(
          widget.departureBookList.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: PassportFormWidget(
                savePassportData: (passportDTO) =>
                    viewModel.savePassport(passportDTO),
                numberOfPeople: state.numberOfPeople,
                postPassportData: () => viewModel.postPassportData(),
                departureBookList: state.departureBookList,
                arrivalBookList: state.arrivalBookList,
                passportDTOList: state.passportDTOList,
                tabController: _tabController,
              ),
            );
          },
        ),
      ),
    );
  }
}
