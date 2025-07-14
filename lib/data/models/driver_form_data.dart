import 'dart:io';

import 'package:ambition_delivery/domain/entities/vehicle.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class DriverFormData {
  String? userType;
  String? phoneNumber;
  String? selectedVehicleCategory = 'Van';
  Vehicle? selectedVehicle;
  List<Vehicle> vehicles = [];
  bool isTermsAndConditionsChecked = false;
  Position? currentLocation;

  // Text controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController carYearController = TextEditingController();
  final TextEditingController carColorController = TextEditingController();
  final TextEditingController carPlateController = TextEditingController();
  final TextEditingController licenseCheckCodeController =
      TextEditingController();
  final TextEditingController accountNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountSortCodeController =
      TextEditingController();

  // Image files
  File? profilePicture;
  File? licenseBackPicture;
  File? licenseFrontPicture;
  File? licensePlatePicture;
  File? vehicleFrontPicture;
  File? vehicleBackPicture;
  File? vehicleLeftPicture;
  File? vehicleRightPicture;
  File? vehicleInsurancePicture;
  File? publicLiabilityInsurancePicture;
  File? goodsInTransitInsurancePicture;
  File? pcoLicensePicture;

  bool isValid() {
    final basicFieldsValid = selectedVehicle != null &&
        nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        carYearController.text.isNotEmpty &&
        carColorController.text.isNotEmpty &&
        carPlateController.text.isNotEmpty &&
        licenseCheckCodeController.text.isNotEmpty &&
        accountNameController.text.isNotEmpty &&
        accountNumberController.text.isNotEmpty &&
        accountSortCodeController.text.isNotEmpty;

    final imagesValid = profilePicture != null &&
        licenseFrontPicture != null &&
        licenseBackPicture != null &&
        licensePlatePicture != null &&
        vehicleFrontPicture != null &&
        vehicleBackPicture != null &&
        vehicleLeftPicture != null &&
        vehicleRightPicture != null &&
        vehicleInsurancePicture != null &&
        publicLiabilityInsurancePicture != null;

    final categorySpecificValid = selectedVehicleCategory == 'Car'
        ? pcoLicensePicture != null
        : goodsInTransitInsurancePicture != null;

    return basicFieldsValid && imagesValid && categorySpecificValid;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      "profile": profilePicture,
      "latitude": currentLocation?.latitude ?? 0.0,
      "longitude": currentLocation?.longitude ?? 0.0,
      "phone": phoneNumber ?? "",
      "vehicleCategory": selectedVehicle?.category.id ?? "",
      "licenseCheckCode": licenseCheckCodeController.text.trim(),
      "accountName": accountNameController.text.trim(),
      "accountNumber": accountNumberController.text.trim(),
      "accountSortCode": accountSortCodeController.text.trim(),
      "carModel": selectedVehicle?.vehicleName ?? "",
      "carMake": selectedVehicle?.make ?? "",
      "carYear": carYearController.text.trim(),
      "carColor": carColorController.text.trim(),
      "carPlate": carPlateController.text.trim(),
      "driverLicenseFront": licenseFrontPicture,
      "driverLicenseBack": licenseBackPicture,
      "licensePlatePicture": licensePlatePicture,
      "vehicleFrontPicture": vehicleFrontPicture,
      "vehicleBackPicture": vehicleBackPicture,
      "vehicleLeftPicture": vehicleLeftPicture,
      "vehicleRightPicture": vehicleRightPicture,
      "vehicleInsurancePicture": vehicleInsurancePicture,
      "publicLiabilityInsurancePicture": publicLiabilityInsurancePicture,
      "goodsInTransitInsurancePicture": goodsInTransitInsurancePicture,
      "pcoLicensePicture": pcoLicensePicture,
    };
  }
}
