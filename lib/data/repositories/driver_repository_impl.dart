import 'package:ambition_delivery/data/models/location_model.dart';
import 'package:ambition_delivery/domain/entities/driver.dart';
import 'package:ambition_delivery/domain/entities/location_entity.dart';

import '../../domain/repositories/driver_repository.dart';
import '../datasources/remote_data_source.dart';
import '../models/driver_model.dart';

class DriverRepositoryImpl implements DriverRepository {
  final RemoteDataSource remoteDataSource;

  DriverRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Map<String, dynamic>> createDriver(Map<String, dynamic> driver) async {
    final resp = await remoteDataSource.createDriver(driver);
    return resp.data;
  }

  @override
  Future<void> deleteDriver(String id) async {
    await remoteDataSource.deleteDriver(id);
  }

  @override
  Future<void> deleteDriverByPhoneNumber(String phoneNumber) async {
    await remoteDataSource.deleteDriverByPhoneNumber(phoneNumber);
  }

  @override
  Future<Driver?> getDriver(String id) async {
    final resp = await remoteDataSource.getDriver(id);
    if (resp.statusCode == 200) {
      return DriverModel.fromJson(resp.data).toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<Driver> updateDriver(String id, Map<String, dynamic> driver) async {
    final resp = await remoteDataSource.updateDriver(id, driver);
    return DriverModel.fromJson(resp.data).toEntity();
  }

  @override
  Future<List<Driver>> getDrivers() async {
    final resp = await remoteDataSource.getDrivers();
    return DriverModel.fromJsonList(resp.data)
        .map((e) => e.toEntity())
        .toList();
  }

  @override
  Future<Map<String, dynamic>> sendDriverLoginOtp(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.sendDriverLoginOtp(data);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> resendDriverLoginOtp(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.resendDriverLoginOtp(data);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> verifyDriverLoginOtp(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.verifyDriverLoginOtp(data);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> sendDriverTempOtp(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.sendDriverTempOtp(data);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> verifyDriverTempOtp(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.verifyDriverTempOtp(data);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> resendDriverTempOtp(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.resendDriverTempOtp(data);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> resendDriverOtp(Map<String, dynamic> otp) async {
    final resp = await remoteDataSource.resendDriverOtp(otp);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> verifyDriverOtp(Map<String, dynamic> otp) async {
    final resp = await remoteDataSource.verifyDriverOtp(otp);
    return resp.data;
  }

  @override
  Future<LocationEntity?> getDriverLocation(String id) async {
    final resp = await remoteDataSource.getDriverLocation(id);
    if (resp.statusCode == 200) {
      return LocationModel.fromJson(resp.data).toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<void> updateDriverLocation(
      String id, Map<String, dynamic> location) async {
    await remoteDataSource.updateDriverLocation(id, location);
  }

  @override
  Future<Map<String, dynamic>> resendOtpToDriverByEmail(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.resendOtpToDriverByEmail(data);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> sendOtpToDriverByEmail(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.sendOtpToDriverByEmail(data);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> updateDriverPassword(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.updateDriverPassword(data);
    return resp.data;
  }

  @override
  Future<Map<String, dynamic>> verifyOtpForDriverByEmail(
      Map<String, dynamic> data) async {
    final resp = await remoteDataSource.verifyOtpForDriverByEmail(data);
    return resp.data;
  }
}
