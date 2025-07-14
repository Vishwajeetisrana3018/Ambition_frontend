import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSource(this.sharedPreferences);

  // Keys for storing user data and type
  static const String _userKey = 'user';
  static const String _userTypeKey = 'user_type';
  static const String _driverType = 'driver';
  static const String _passengerType = 'passenger';
  static const String _tokenKey = 'token';

  // Save driver information on login
  Future<void> saveDriver(Map<String, dynamic> driver) async {
    await sharedPreferences.setString(_userKey, json.encode(driver));
    await sharedPreferences.setString(_userTypeKey, _driverType);
  }

  // Save passenger information on login
  Future<void> savePassenger(Map<String, dynamic> passenger) async {
    await sharedPreferences.setString(_userKey, json.encode(passenger));
    await sharedPreferences.setString(_userTypeKey, _passengerType);
  }

  // Check if the current user is a driver
  bool isDriver() {
    return sharedPreferences.getString(_userTypeKey) == _driverType;
  }

  // Check if the current user is a passenger
  bool isPassenger() {
    return sharedPreferences.getString(_userTypeKey) == _passengerType;
  }

  //Save phone number and user type
  Future<void> savePhoneNumberAndUserType(
      String phoneNumber, String userType) async {
    await sharedPreferences.setString('otp_phone_number', phoneNumber);
    await sharedPreferences.setString('otp_user_type', userType);
  }

  //Get phone number and user type if available else return null
  Map<String, String>? getOtpPhoneNumberAndUserType() {
    final phoneNumber = sharedPreferences.getString('otp_phone_number');
    final userType = sharedPreferences.getString('otp_user_type');
    if (phoneNumber != null && userType != null) {
      return {
        'phone_number': phoneNumber,
        'user_type': userType,
      };
    }
    return null;
  }

  //Delete phone number and user type
  Future<void> deleteOtpPhoneNumberAndUserType() async {
    await sharedPreferences.remove('otp_phone_number');
    await sharedPreferences.remove('otp_user_type');
  }

  // Get user data
  Map<String, dynamic>? getLocalUser() {
    final user = sharedPreferences.getString(_userKey);
    if (user != null) {
      return json.decode(user) as Map<String, dynamic>;
    }
    return null;
  }

  //Save token
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  //Get token
  String? getToken() {
    return sharedPreferences.getString(_tokenKey);
  }

  //Delete token
  Future<void> deleteToken() async {
    await sharedPreferences.remove(_tokenKey);
  }

  // Delete user data on logout
  Future<void> logout() async {
    await deleteOtpPhoneNumberAndUserType();
    await sharedPreferences.remove(_userKey);
    await sharedPreferences.remove(_userTypeKey);
    await sharedPreferences.remove(_tokenKey);
  }
}
