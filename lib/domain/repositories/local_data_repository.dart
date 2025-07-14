abstract class LocalDataRepository {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> deleteToken();
  Future<void> logout();
  bool isDriver();
  bool isPassenger();
  Map<String, dynamic>? getLocalUser();
  Future<void> saveDriver(Map<String, dynamic> driver);
  Future<void> savePassenger(Map<String, dynamic> passenger);
  Future<void> savePhoneNumberAndUserType(String phoneNumber, String userType);
  Map<String, String>? getOtpPhoneNumberAndUserType();
  Future<void> deleteOtpPhoneNumberAndUserType();
}
