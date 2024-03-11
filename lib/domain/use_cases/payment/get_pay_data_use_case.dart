import '../../../data/core/result.dart';
import '../../model/payment/payment_model.dart';
import '../../repositories/payment_repository.dart';

class GetPayDataUseCase {
  GetPayDataUseCase({
    required PaymentRepository paymentRepository,
  }) : _paymentRepository = paymentRepository;

  final PaymentRepository _paymentRepository;

  Future<Result<List<PaymentModel>>> execute({
    required List<int> data,
  }) async {
    final result = await _paymentRepository.getPaymentData(data);

    return result.when(
      success: (data) => Result.success(data),
      error: (message) => Result.error(message),
    );
  }
}
