import 'package:flutter/material.dart';

import 'package:ambition_delivery/data/models/driver_form_data.dart';
import 'package:ambition_delivery/data/models/repeat_job_model.dart';
import 'package:ambition_delivery/di/dependency_injection.dart';
import 'package:ambition_delivery/presentation/pages/auth/driver_signup_additional_info_page.dart';
import 'package:ambition_delivery/presentation/pages/auth/driver_signup_otp_page.dart';
import 'package:ambition_delivery/presentation/pages/auth/driver_signup_vehicle_selection_page.dart';
import 'package:ambition_delivery/presentation/pages/auth/login_otp_page.dart';
import 'package:ambition_delivery/presentation/pages/auth/login_page.dart';
import 'package:ambition_delivery/presentation/pages/auth/passenger_additional_info_page.dart';
import 'package:ambition_delivery/presentation/pages/auth/passenger_signup_otp_page.dart';
import 'package:ambition_delivery/presentation/pages/auth/signup_page.dart';
import 'package:ambition_delivery/presentation/pages/chat/chat_list_screen.dart';
import 'package:ambition_delivery/presentation/pages/chat/chat_messages_screen.dart';
import 'package:ambition_delivery/presentation/pages/driver/driver_home_page.dart';
import 'package:ambition_delivery/presentation/pages/driver/driver_tips_page.dart';
import 'package:ambition_delivery/presentation/pages/passenger/customer_tips_page.dart';
import 'package:ambition_delivery/presentation/pages/passenger/event_item_selection_screen.dart';
import 'package:ambition_delivery/presentation/pages/passenger/event_item_selection_screen_repeat.dart';
import 'package:ambition_delivery/presentation/pages/passenger/item_selection_screen.dart';
import 'package:ambition_delivery/presentation/pages/passenger/item_selection_screen_repeat.dart';
import 'package:ambition_delivery/presentation/pages/passenger/passenger_home_page.dart';
import 'package:ambition_delivery/presentation/pages/passenger/pickup_dropoff_address_screen.dart';
import 'package:ambition_delivery/presentation/pages/passenger/repeat_job_screen.dart';
import 'package:ambition_delivery/presentation/pages/passenger/ride_request_screen.dart';
import 'package:ambition_delivery/presentation/pages/passenger/service_selection_screen.dart';
import 'package:ambition_delivery/presentation/pages/passenger/vehicle_category_selection_screen.dart';

import '../presentation/pages/passenger/car_category_selection_screen.dart';

Map<String, WidgetBuilder> appRoutes = {
  '/': (context) {
    if (isDriver()) {
      return const DriverHomePage();
    } else if (isPassenger()) {
      return const PassengerHomePage();
    } else {
      return const LoginPage();
    }
  },
  '/driver_home': (context) => const DriverHomePage(),
  '/passenger_home': (context) => const PassengerHomePage(),
  '/passenger_signup_otp': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    return PassengerSignupOtpPage(phoneNumber: args!);
  },
  '/passenger_additional_info': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    return PassengerAdditionalInfoPage(phoneNumber: args!);
  },
  '/driver_signup_otp_page': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as DriverFormData?;
    return DriverSignupOtpPage(driverFormData: args!);
  },
  '/driver_signup_vehicle_selection': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as DriverFormData?;
    return DriverSignupVehicleSelectionPage(driverFormData: args!);
  },
  '/driver_signup_additional_info': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as DriverFormData?;
    return DriverSignupAdditionalInfoPage(driverFormData: args!);
  },
  '/login_otp_page': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    String? phoneNumber = args?['phone_number'];
    String? userType = args?['user_type'];
    return LoginOtpPage(phoneNumber: phoneNumber!, userType: userType!);
  },
  '/login': (context) => const LoginPage(),
  '/signup': (context) => const SignupPage(),
  '/pickup_dropoff_address': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    return PickupDropoffAddressScreen(moveType: args!);
  },
  '/service_selection': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ServiceSelectionScreen(
      pickupAddress: args?['pickupAddress'],
      dropoffAddress: args?['dropoffAddress'],
      moveType: args?['moveType'],
    );
  },
  '/item_selection': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return ItemSelectionScreen(
      pickupAddress: args?['pickupAddress'],
      dropoffAddress: args?['dropoffAddress'],
      jobType: args?['jobType'],
      moveType: args?['moveType'],
    );
  },
  '/event_item_selection': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return EventItemSelectionScreen(
      pickupAddress: args?['pickupAddress'],
      dropoffAddress: args?['dropoffAddress'],
      jobType: args?['jobType'],
      moveType: args?['moveType'],
    );
  },
  '/vehicle_category_selection': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return VehicleCategorySelectionScreen(items: args!);
  },
  '/car_category_selection': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return CarCategorySelectionScreen(rideRequest: args!);
  },
  '/ride_request': (context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    return RideRequestScreen(rideRequest: args!);
  },
  '/chat_list': (context) => const ChatListScreen(),
  '/chat_messages': (context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as ChatMessagesScreenArguments?;
    return ChatMessagesScreen(arguments: args!);
  },
  '/repeat_job': (context) => const RepeatJobScreen(),
  '/event_item_selection_repeat': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as RepeatJobModel?;
    return EventItemSelectionScreenRepeat(
      repeatJob: args!,
    );
  },
  '/item_selection_repeat': (context) {
    final args = ModalRoute.of(context)?.settings.arguments as RepeatJobModel?;
    return ItemSelectionScreenRepeat(
      repeatJob: args!,
    );
  },
  '/driver_tips': (context) => const DriverTipsPage(),
  '/customer_tips': (context) => const CustomerTipsPage(),
};
