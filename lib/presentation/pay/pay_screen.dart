import 'package:flutter/material.dart';
import 'package:griffin/presentation/pay/ticket_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PayScreen extends StatefulWidget {
  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  final pages = List.generate(3, (index) => const TicketWidgets());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: const WormEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                  type: WormType.normal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('총 금액: 000,000원'),
                      TextButton(
                          onPressed: () {
                            bootpayPayment(context);
                          },
                          child: const Text('결제하기',
                              style: TextStyle(fontSize: 16.0))),
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
