
abstract interface class PaymentRepository {
  Future<void> postPaymentData(Map<String, dynamic> data);
}