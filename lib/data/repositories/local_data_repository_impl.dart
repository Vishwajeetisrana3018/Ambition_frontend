import '../../domain/repositories/local_data_repository.dart';
import '../datasources/local_data_source.dart';

class LocalDataRepositoryImpl implements LocalDataRepository {
  final LocalDataSource localDataSource;

  LocalDataRepositoryImpl({
    required this.localDataSource,
  });
  @override
  Future<void> deleteToken() async {
    await localDataSource.deleteToken();
  }

  @override
  String? getToken() {
    return localDataSource.getToken();
  }

  @override
  bool isDriver() {
    return localDataSource.isDriver();
  }

  @override
  bool isPassenger() {
    return localDataSource.isPassenger();
  }

  @override
  Future<void> logout() async {
    return await localDataSource.logout();
  }

  @override
  Future<void> saveDriver(Map<String, dynamic> driver) async {
    return await localDataSource.saveDriver(driver);
  }

  @override
  Future<void> savePassenger(Map<String, dynamic> passenger) async {
    return await localDataSource.savePassenger(passenger);
  }

  @override
  Map<String, dynamic>? getLocalUser() {
    return localDataSource.getLocalUser();
  }

  @override
  Future<void> saveToken(String token) async {
    return await localDataSource.saveToken(token);
  }

  @override
  Future<void> savePhoneNumberAndUserType(
      String phoneNumber, String userType) async {
    return await localDataSource.savePhoneNumberAndUserType(
      phoneNumber,
      userType,
    );
  }

  @override
  Map<String, String>? getOtpPhoneNumberAndUserType() {
    return localDataSource.getOtpPhoneNumberAndUserType();
  }

  @override
  Future<void> deleteOtpPhoneNumberAndUserType() async {
    return await localDataSource.deleteOtpPhoneNumberAndUserType();
  }
}
