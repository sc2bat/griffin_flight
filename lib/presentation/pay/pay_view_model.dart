import 'dart:convert';
import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:griffin/domain/model/books/books_model.dart';
import 'package:griffin/domain/use_cases/my_books/total_my_books_use_case.dart';
import 'package:griffin/domain/use_cases/payment/get_pay_data_use_case.dart';
import 'package:griffin/presentation/pay/pay_state.dart';

import '../../data/core/result.dart';
import '../../domain/model/payment/payment_model.dart';
import '../../domain/model/user/user_account_model.dart';
import '../../domain/use_cases/payment/post_pay_data_use_case.dart';
import '../../domain/use_cases/splash/get_session_use_case.dart';
import '../../env/env.dart';
import '../../utils/simple_logger.dart';

class PayViewModel extends ChangeNotifier {
  final GetSessionUseCase _getSessionUseCase;
  final TotalMyBooksUseCase _totalMyBooksUseCase;
  final PostPayDataUseCase _postPayDataUseCase;
  final GetPayDataUseCase _getPayDataUseCase;

  PayViewModel(
      {required GetSessionUseCase getSessionUseCase,
      required TotalMyBooksUseCase totalMyBooksUseCase,
      required PostPayDataUseCase postPayDataUseCase,
      required GetPayDataUseCase getPayDataUseCase})
      : _getSessionUseCase = getSessionUseCase,
        _totalMyBooksUseCase = totalMyBooksUseCase,
        _postPayDataUseCase = postPayDataUseCase,
        _getPayDataUseCase = getPayDataUseCase {
    fetchData();
  }

  PayState _state = const PayState();

  PayState get state => _state;

  Future<void> getSession() async {
    final result = await _getSessionUseCase.execute();
    switch (result) {
      case Success<UserAccountModel>():
        _state = state.copyWith(userAccountModel: result.data);
        notifyListeners();
        break;
      case Error<UserAccountModel>():
        logger.info(result.message);
        notifyListeners();
        break;
    }
  }

  // pay status 변경 전 예약된 리스트 요청
  Future<void> fetchData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      await getSession();
      if (_state.userAccountModel != null) {
        final result =
            await _totalMyBooksUseCase.execute(_state.userAccountModel!.userId);
        switch (result) {
          case Success<List<BooksModel>>():
            _state = state.copyWith(
              totalBookItemList: result.data,
            );
          case Error<List<BooksModel>>():
            _state = state.copyWith(
              totalBookItemList: [],
            );
        }
        notifyListeners();
      }
    } catch (error) {
      // 에러 처리
      logger.info('Error fetching data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  void init(List<int> forPayBookIdList) async {
    try {
      final result = await _getPayDataUseCase.execute(data: forPayBookIdList);
      switch (result) {
        case Success<List<PaymentModel>>():
          _state = state.copyWith(forPaymentList: result.data);
          notifyListeners();
          break;
        case Error<List<PaymentModel>>():
          logger.info(result.message);
          notifyListeners();
          break;
      }
    } catch (error) {
      // 에러 처리
      logger.info('Error init data: $error');
    }
  }

  void postPaidItems(List<PaymentModel> forPaymentList) {
    List<BooksModel> paidList = [];
    for (var bookItem in forPaymentList) {
      BooksModel paidItem = _state.totalBookItemList
          .firstWhere((e) => e.bookId == bookItem.bookId);
      BooksModel postItem = BooksModel(
          bookId: paidItem.bookId,
          payStatus: 1,);
      paidList.add(postItem);
    }
    logger.info(paidList);
    _postPayDataUseCase.execute(data: paidList);
  }

  void bootpayPayment(BuildContext context, List<PaymentModel> forPaymentList,
      double totalAmount) {
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
        // postPaidItems(forPaymentList);
      },
      onClose: () {
        logger.info('------- onClose');
        Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
        context.go('/navigation');
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
        String paidResultData = jsonDecode(data)['event'];
        logger.info(paidResultData);
        if (paidResultData == 'done') {
          postPaidItems(forPaymentList); // 결제완료되면 서버로 pay status 변경
        }
      },
    );
  }

  Payload getPayload(double totalAmount) {
    Payload payload = Payload();
    Item item1 = Item();
    item1.name = "GRIFFIN 예약 - 항공티켓"; // 주문정보에 담길 상품명
    item1.qty = 1; // 해당 상품의 주문 수량
    item1.id = "ITEM_CODE_TICKET"; // 해당 상품의 고유 키
    item1.price = totalAmount; // 상품의 가격

    payload.androidApplicationId =
        Env.androidApplicationId; // android application id
    payload.iosApplicationId = Env.iosApplicationId; // ios application id

    payload.pg = '나이스페이';
    // payload.method = '카드';
    // payload.methods = ['card', 'phone', 'vbank', 'bank', 'kakao'];
    payload.orderName = item1.name; //결제할 상품명
    payload.price = item1.price; //정기결제시 0 혹은 주석

    payload.orderId =
        '${_state.userAccountModel!.userId}_${DateTime.now().millisecondsSinceEpoch.toString()}'; //주문번호, 개발사에서 고유값으로 지정해야함 ('userId + epoch time' 형태로 지정)

    payload.metadata = {
      "구매자 ID": _state.userAccountModel!.userId,
      "구매자 이름": _state.userAccountModel!.userName,
      "구매자 E-mail": _state.userAccountModel!.email,
      "티켓구매수량": "${_state.paidBookItemList.length} 매",
    }; // 전달할 파라미터, 결제 후 되돌려 주는 값, 부트페이 관리자 화면에서 확인

    User user = User(); // 구매자 정보
    user.username = _state.userAccountModel!.userName;
    user.email = _state.userAccountModel!.email;

    Extra extra = Extra(); // 결제 옵션
    extra.cardQuota = '3'; // 5만원 이상 결제 시 할부 가능 범위 옵션
    // extra.openType = 'popup';

    // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
    // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

    payload.user = user;
    payload.extra = extra;
    return payload;
  }
}
