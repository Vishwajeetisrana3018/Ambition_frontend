class PaymentSheetDataEntity {
  final String paymentIntent;
  final String customer;
  final String ephemeralKey;
  final String transactionId;

  PaymentSheetDataEntity({
    required this.paymentIntent,
    required this.customer,
    required this.ephemeralKey,
    required this.transactionId,
  });
}
