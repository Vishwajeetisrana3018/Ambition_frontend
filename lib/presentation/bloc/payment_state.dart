import 'package:ambition_delivery/domain/entities/payment_sheet_data_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentVehicleSuccess extends PaymentState {
  final PaymentSheetDataEntity paymentSheetData;

  const PaymentVehicleSuccess(this.paymentSheetData);

  @override
  List<Object> get props => [paymentSheetData];
}

class PaymentCarAndVehicleSuccess extends PaymentState {
  final PaymentSheetDataEntity paymentSheetData;

  const PaymentCarAndVehicleSuccess(this.paymentSheetData);

  @override
  List<Object> get props => [paymentSheetData];
}

class PaymentFailure extends PaymentState {
  final String error;

  const PaymentFailure(this.error);

  @override
  List<Object> get props => [error];
}
