import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class InitiateVehiclePayment extends PaymentEvent {
  final int amount;
  final String email;

  const InitiateVehiclePayment({required this.amount, required this.email});

  @override
  List<Object> get props => [amount, email];
}

class InitiateCarAndVehiclePayment extends PaymentEvent {
  final int amount;
  final String email;

  const InitiateCarAndVehiclePayment(
      {required this.amount, required this.email});

  @override
  List<Object> get props => [amount, email];
}
