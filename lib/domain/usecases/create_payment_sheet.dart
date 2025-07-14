import 'package:ambition_delivery/domain/entities/payment_sheet_data_entity.dart';
import 'package:ambition_delivery/domain/repositories/payment_repository.dart';

class CreatePaymentSheet {
  final PaymentRepository repository;

  CreatePaymentSheet(this.repository);

  Future<PaymentSheetDataEntity> call(CreatePaymentSheetParams params) async {
    return await repository.createPaymentSheet(params.amount, params.email);
  }
}

class CreatePaymentSheetParams {
  final int amount;
  final String email;

  CreatePaymentSheetParams({required this.amount, required this.email});
}
