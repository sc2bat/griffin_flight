import 'package:griffin/domain/repositories/payment_repository.dart';

class PaymentUseCase {
  PaymentUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  final PaymentRepository _paymentRepository;

  Future<void> execute({
    required Map<String, dynamic> data,
  }) async {
    _paymentRepository.postPaymentData(data);
  }
}
