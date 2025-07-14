import 'package:ambition_delivery/domain/entities/payment_sheet_data_entity.dart';

class PaymentSheetDataModel extends PaymentSheetDataEntity {
  PaymentSheetDataModel(
      {required super.paymentIntent,
      required super.customer,
      required super.ephemeralKey,
      required super.transactionId});

  factory PaymentSheetDataModel.fromJson(Map<String, dynamic> json) {
    return PaymentSheetDataModel(
      paymentIntent: json['paymentIntent'],
      customer: json['customer'],
      ephemeralKey: json['ephemeralKey'],
      transactionId: json['transactionId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'paymentIntent': super.paymentIntent,
      'customer': super.customer,
      'ephemeralKey': super.ephemeralKey,
      'transactionId': super.transactionId,
    };
  }

  //toEntity
  PaymentSheetDataEntity toEntity() {
    return PaymentSheetDataEntity(
      paymentIntent: super.paymentIntent,
      customer: super.customer,
      ephemeralKey: super.ephemeralKey,
      transactionId: super.transactionId,
    );
  }

  //fromEntity
  factory PaymentSheetDataModel.fromEntity(PaymentSheetDataEntity entity) {
    return PaymentSheetDataModel(
      paymentIntent: entity.paymentIntent,
      customer: entity.customer,
      ephemeralKey: entity.ephemeralKey,
      transactionId: entity.transactionId,
    );
  }
}
