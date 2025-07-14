import 'package:ambition_delivery/domain/entities/payment_sheet_data_entity.dart';
import 'package:ambition_delivery/domain/repositories/payment_repository.dart';

class PresentPaymentSheet {
  final PaymentRepository repository;

  PresentPaymentSheet(this.repository);

  Future<void> call(PaymentSheetDataEntity paymentSheetData) async {
    await repository.presentPaymentSheet(paymentSheetData);
  }
}
