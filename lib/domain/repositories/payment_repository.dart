import 'package:ambition_delivery/domain/entities/payment_sheet_data_entity.dart';

abstract class PaymentRepository {
  Future<PaymentSheetDataEntity> createPaymentSheet(int amount, String email);
  Future<void> presentPaymentSheet(PaymentSheetDataEntity paymentSheetData);
}
