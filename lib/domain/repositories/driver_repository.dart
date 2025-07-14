// domain/repositories/driver_repository.dart
import 'package:ambition_delivery/domain/entities/location_entity.dart';

import '../entities/driver.dart';

abstract class DriverRepository {
  Future<Map<String, dynamic>> createDriver(Map<String, dynamic> driver);
  Future<Driver?> getDriver(String id);
  Future<List<Driver>> getDrivers();
  Future<Map<String, dynamic>> sendDriverLoginOtp(Map<String, dynamic> data);
  Future<Map<String, dynamic>> resendDriverLoginOtp(Map<String, dynamic> data);
  Future<Map<String, dynamic>> verifyDriverLoginOtp(Map<String, dynamic> data);
  Future<Map<String, dynamic>> sendDriverTempOtp(Map<String, dynamic> data);
  Future<Map<String, dynamic>> verifyDriverTempOtp(Map<String, dynamic> data);
  Future<Map<String, dynamic>> resendDriverTempOtp(Map<String, dynamic> data);
  Future<Map<String, dynamic>> verifyDriverOtp(Map<String, dynamic> otp);
  Future<Map<String, dynamic>> resendDriverOtp(Map<String, dynamic> otp);
  Future<Map<String, dynamic>> updateDriverPassword(Map<String, dynamic> data);
  Future<Map<String, dynamic>> sendOtpToDriverByEmail(
      Map<String, dynamic> data);
  Future<Map<String, dynamic>> resendOtpToDriverByEmail(
      Map<String, dynamic> data);
  Future<Map<String, dynamic>> verifyOtpForDriverByEmail(
      Map<String, dynamic> data);
  Future<Driver> updateDriver(String id, Map<String, dynamic> driver);
  Future<void> deleteDriver(String id);
  Future<void> deleteDriverByPhoneNumber(String phoneNumber);
  Future<LocationEntity?> getDriverLocation(String id);
  Future<void> updateDriverLocation(String id, Map<String, dynamic> location);
}
