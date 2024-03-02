import 'package:flutter/material.dart';
import 'package:griffin/domain/model/payment_model.dart';
import 'package:griffin/presentation/pay/ticket_data.dart';
import 'package:ticket_widget/ticket_widget.dart';

class TicketWidgets extends StatelessWidget {
  const TicketWidgets({super.key, required this.twoTicketList});

  final List<PaymentModel> twoTicketList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        children: [
          TicketWidget(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.4,
            isCornerRounded: true,
            padding: const EdgeInsets.all(20),
            child: TicketData(
              ticketData: twoTicketList[0],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          (twoTicketList.length < 2)
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                )
              : TicketWidget(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.4,
                  isCornerRounded: true,
                  padding: const EdgeInsets.all(20),
                  child: TicketData(
                    ticketData: twoTicketList[1],
                  ),
                ),
        ],
      ),
    );
  }
}
