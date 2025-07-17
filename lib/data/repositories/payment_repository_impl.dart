import 'package:ambition_delivery/data/datasources/remote_data_source.dart';
import 'package:ambition_delivery/data/models/payment_sheet_data_model.dart';
import 'package:ambition_delivery/domain/entities/payment_sheet_data_entity.dart';
import 'package:ambition_delivery/domain/repositories/payment_repository.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final RemoteDataSource dataSource;

  PaymentRepositoryImpl({required this.dataSource});

  @override
  Future<PaymentSheetDataEntity> createPaymentSheet(
      int amount, String email) async {
    final response =
        await dataSource.createPaymentSheet({'amount': amount, 'email': email});
        
    final body = response.data;
    if (body['error'] != null) {
      throw Exception(body['error']);
    }
    return PaymentSheetDataModel.fromJson(body);
  }

  @override
  Future<void> presentPaymentSheet(
      PaymentSheetDataEntity paymentSheetData) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentSheetData.paymentIntent,
        merchantDisplayName: "Ambition",
        customerId: paymentSheetData.customer,
        preferredNetworks: [CardBrand.Amex],
        customerEphemeralKeySecret: paymentSheetData.ephemeralKey,
        applePay: const PaymentSheetApplePay(
          merchantCountryCode: 'DE',
        ),
        googlePay: const PaymentSheetGooglePay(
          merchantCountryCode: 'DE',
          testEnv: true,
          buttonType: PlatformButtonType.book,
        ),
      ),
    );
    await Stripe.instance.presentPaymentSheet();
  }
}
