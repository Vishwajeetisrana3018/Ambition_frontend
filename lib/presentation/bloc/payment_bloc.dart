import 'package:ambition_delivery/domain/usecases/create_payment_sheet.dart';
import 'package:ambition_delivery/domain/usecases/get_local_user.dart';
import 'package:ambition_delivery/domain/usecases/present_payment_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CreatePaymentSheet createPaymentSheet;
  final PresentPaymentSheet presentPaymentSheet;
  final GetLocalUser getLocalUser;

  PaymentBloc({
    required this.createPaymentSheet,
    required this.presentPaymentSheet,
    required this.getLocalUser,
  }) : super(PaymentInitial()) {
    on<InitiateVehiclePayment>(_onInitiateVehiclePayment);
    on<InitiateCarAndVehiclePayment>(_onInitiateCarAndVehiclePayment);
  }

  Future<void> _onInitiateVehiclePayment(
    InitiateVehiclePayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final paymentSheetData = await createPaymentSheet(
        CreatePaymentSheetParams(amount: event.amount, email: event.email),
      );
      await presentPaymentSheet(paymentSheetData);
      emit(PaymentVehicleSuccess(paymentSheetData));
    } on StripeException catch (e) {
      emit(PaymentFailure(e.error.localizedMessage ?? 'An error occurred'));
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }

  Future<void> _onInitiateCarAndVehiclePayment(
   
  InitiateCarAndVehiclePayment event,
  Emitter<PaymentState> emit,
) async {
   print('Initiating car and vehicle payment...');
  emit(PaymentLoading());

  print('Starting payment sheet creation...');
  final paymentSheetData = await createPaymentSheet(
    CreatePaymentSheetParams(amount: event.amount, email: event.email),
  );
  print('Payment sheet data created: $paymentSheetData');

  print('Presenting payment sheet...');
  await presentPaymentSheet(paymentSheetData);
  print('Payment sheet presented successfully.');

  emit(PaymentCarAndVehicleSuccess(paymentSheetData));
}

}
