import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:griffin/domain/model/payment_model.dart';
import 'package:griffin/presentation/pay/ticket_widgets.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/simple_logger.dart';

class PayScreen extends StatefulWidget {
  final List<PaymentModel> forPaymentList;

  @override
  State<PayScreen> createState() => _PayScreenState();

  const PayScreen({
    super.key,
    required this.forPaymentList,
  });
}

class _PayScreenState extends State<PayScreen> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(
        (widget.forPaymentList.length / 2).ceil(),
        (i) => TicketWidgets(
            twoTicketList: widget.forPaymentList.sublist(
                i * 2,
                (i + 1) * 2 > widget.forPaymentList.length
                    ? widget.forPaymentList.length
                    : (i + 1) * 2)));
    final totalAmount =
        widget.forPaymentList.fold(0.0, (e, v) => e + v.payAmount!);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
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
                      Text(
                          '총 금액: ${NumberFormat('###,###,###,###').format(totalAmount)}원'),
                      TextButton(
                          onPressed: () {
                            bootpayPayment(context, totalAmount);
                          },
                          child: const Text('결제하기',
                              style: TextStyle(fontSize: 16.0))),
                      TextButton(
                          onPressed: () {
                            context.push('/myBooks');
                          },
                          child: const Text('취소',
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

void bootpayPayment(BuildContext context, double totalAmount) {
  Payload payload = getPayload(totalAmount);
  if (kIsWeb) {
    payload.extra?.openType = "iframe";
  }

  Bootpay().requestPayment(
    context: context,
    payload: payload,
    showCloseButton: false,
    // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
    onCancel: (String data) {
      logger.info('------- onCancel: $data');
    },
    onError: (String data) {
      logger.info('------- onError: $data');
    },
    onClose: () {
      logger.info('------- onClose');
      Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
      //TODO - 원하시는 라우터로 페이지 이동
    },
    onIssued: (String data) {
      logger.info('------- onIssued: $data');
    },
    onConfirm: (String data) {
      logger.info('------- onConfirm: $data');
      /**
          1. 바로 승인하고자 할 때
          return true;
       **/
      /***
          2. 비동기 승인 하고자 할 때
          checkQtyFromServer(data);
          return false;
       ***/
      /***
          3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
          return false; 후에 서버에서 결제승인 수행
       */
      // checkQtyFromServer(data);
      return true;
    },
    onDone: (String data) {
      logger.info('------- onDone: $data');
    },
  );
}

Payload getPayload(double totalAmount) {
  Payload payload = Payload();
  Item item1 = Item();
  item1.name = "항공 티켓"; // 주문정보에 담길 상품명
  item1.qty = 1; // 해당 상품의 주문 수량
  item1.id = "ITEM_CODE_MOUSE"; // 해당 상품의 고유 키
  item1.price = totalAmount; // 상품의 가격

  payload.androidApplicationId =
  '65cee8dee57a7e001de37229'; // android application id
  payload.iosApplicationId = '65cee8dee57a7e001de3722a'; // ios application id

  payload.pg = '나이스페이';
  // payload.method = '카드';
  // payload.methods = ['card', 'phone', 'vbank', 'bank', 'kakao'];
  payload.orderName = item1.name; //결제할 상품명
  payload.price = item1.price; //정기결제시 0 혹은 주석

  payload.orderId = DateTime.now()
      .millisecondsSinceEpoch
      .toString(); //주문번호, 개발사에서 고유값으로 지정해야함

  payload.metadata = {
    "callbackParam1": "value12",
    "callbackParam2": "value34",
    "callbackParam3": "value56",
    "callbackParam4": "value78",
  }; // 전달할 파라미터, 결제 후 되돌려 주는 값

  User user = User(); // 구매자 정보
  user.username = "사용자 이름";
  user.email = "user1234@gmail.com";

  Extra extra = Extra(); // 결제 옵션
  extra.appScheme = 'bootpayFlutterExample';
  extra.cardQuota = '3';
  // extra.openType = 'popup';

  // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
  // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

  payload.user = user;
  payload.extra = extra;
  return payload;
}
