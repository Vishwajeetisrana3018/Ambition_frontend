// domain/entities/driver.dart

import 'car.dart';
import 'location_entity.dart';

class Driver {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String licenseCheckCode;
  final String profile;
  final String licenseFront;
  final String licenseBack;
  final String licensePlatePicture;
  final String vehicleFrontPicture;
  final String vehicleBackPicture;
  final String vehicleLeftPicture;
  final String vehicleRightPicture;
  final String vehicleInsurancePicture;
  final String publicLiabilityInsurancePicture;
  final String goodsInTransitInsurancePicture;
  final String pcoLicensePicture;
  final String accountName;
  final String accountNumber;
  final String accountSortCode;
  final String status;
  final LocationEntity location;
  final Car car;

  Driver({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.licenseCheckCode,
    required this.profile,
    required this.licenseFront,
    required this.licenseBack,
    required this.licensePlatePicture,
    required this.vehicleFrontPicture,
    required this.vehicleBackPicture,
    required this.vehicleLeftPicture,
    required this.vehicleRightPicture,
    required this.vehicleInsurancePicture,
    required this.publicLiabilityInsurancePicture,
    required this.goodsInTransitInsurancePicture,
    required this.pcoLicensePicture,
    required this.accountName,
    required this.accountNumber,
    required this.accountSortCode,
    required this.status,
    required this.location,
    required this.car,
  });
}
