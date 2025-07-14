import 'dart:io';

import 'package:ambition_delivery/domain/entities/car.dart';
import 'package:ambition_delivery/domain/entities/driver.dart';
import 'package:ambition_delivery/domain/entities/vehicle.dart';
import 'package:ambition_delivery/presentation/bloc/auth_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/driver_profile_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/driver_profile_event.dart';
import 'package:ambition_delivery/presentation/bloc/driver_profile_state.dart';
import 'package:ambition_delivery/presentation/bloc/socket_bloc.dart';
import 'package:ambition_delivery/presentation/widgets/custom_text_field_widget.dart';
import 'package:ambition_delivery/presentation/widgets/profile_additional_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  final ImagePicker _picker = ImagePicker();
  late final AuthBloc _authBloc;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _licenseCheckCodeController =
      TextEditingController();
  final TextEditingController _carYearController = TextEditingController();
  final TextEditingController _carColorController = TextEditingController();
  final TextEditingController _carPlateController = TextEditingController();
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _accountSortCodeController =
      TextEditingController();
  Driver? driver;

  String? originalName;
  String? originalEmail;
  String? originalPhone;
  int? originalCarYear;
  String? originalCarColor;
  String? originalCarPlate;
  String? originalLicenseCheckCode;
  String? originalAccountName;
  String? originalAccountNumber;
  String? originalAccountSortCode;

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

  String? profileImageUrl;
  String? licenseBackImageUrl;
  String? licenseFrontImageUrl;
  String? licensePlateImageUrl;
  String? vehicleFrontImageUrl;
  String? vehicleBackImageUrl;
  String? vehicleLeftImageUrl;
  String? vehicleRightImageUrl;
  String? vehicleInsuranceImageUrl;
  String? publicLiabilityInsuranceImageUrl;
  String? goodsInTransitInsuranceImageUrl;
  String? pcoLicenseImageUrl;

  List<Vehicle> vehicles = [];
  Vehicle? selectedVehicle;
  Vehicle? initialSelectedVehicle;
  Car? selectedCar;

  String? selectedVehicleCategory;
  @override
  void initState() {
    selectedVehicleCategory = 'Van';
    // Fetch driver profile
    _authBloc = BlocProvider.of<AuthBloc>(context);
    context.read<AuthBloc>().add(FetchVehiclesEvent());
    BlocProvider.of<DriverProfileBloc>(context).add(GetDriverProfile());
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _licenseCheckCodeController.dispose();
    _carYearController.dispose();
    _carColorController.dispose();
    _carPlateController.dispose();
    _accountNameController.dispose();
    _accountNumberController.dispose();
    _accountSortCodeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<DriverProfileBloc, DriverProfileState>(
            listener: (context, state) {
              if (state is DriverProfileLoaded) {
                driver = state.driver;
                _nameController.text = state.driver.name;
                _emailController.text = state.driver.email;
                _phoneNumberController.text = state.driver.phone;
                _licenseCheckCodeController.text =
                    state.driver.licenseCheckCode;
                _accountNameController.text = state.driver.accountName;
                _accountNumberController.text = state.driver.accountNumber;
                _accountSortCodeController.text = state.driver.accountSortCode;
                _carYearController.text = state.driver.car.year.toString();
                _carColorController.text = state.driver.car.color;
                _carPlateController.text = state.driver.car.plate;
                selectedCar = state.driver.car;
                profileImageUrl = state.driver.profile;
                licenseBackImageUrl = state.driver.licenseBack;
                licenseFrontImageUrl = state.driver.licenseFront;
                licensePlateImageUrl = state.driver.licensePlatePicture;
                vehicleFrontImageUrl = state.driver.vehicleFrontPicture;
                vehicleBackImageUrl = state.driver.vehicleBackPicture;
                vehicleLeftImageUrl = state.driver.vehicleLeftPicture;
                vehicleRightImageUrl = state.driver.vehicleRightPicture;
                vehicleInsuranceImageUrl = state.driver.vehicleInsurancePicture;
                publicLiabilityInsuranceImageUrl =
                    state.driver.publicLiabilityInsurancePicture;
                goodsInTransitInsuranceImageUrl =
                    state.driver.goodsInTransitInsurancePicture;
                pcoLicenseImageUrl = state.driver.pcoLicensePicture;

                originalName = state.driver.name;
                originalEmail = state.driver.email;
                originalPhone = state.driver.phone;
                originalCarYear = state.driver.car.year;
                originalCarColor = state.driver.car.color;
                originalCarPlate = state.driver.car.plate;
                originalLicenseCheckCode = state.driver.licenseCheckCode;
                originalAccountName = state.driver.accountName;
                originalAccountNumber = state.driver.accountNumber;
                originalAccountSortCode = state.driver.accountSortCode;
              } else if (state is DriverProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              } else if (state is DriverProfileUpdated) {
              } else if (state is DriverProfileDeleted) {
              } else if (state is DriverDisabledError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Driver is disabled"),
                  ),
                );
                _authBloc.add(SignOutEvent());
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              } else if (state is DriverNotFoundError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Driver not found"),
                  ),
                );
                _authBloc.add(SignOutEvent());
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (route) => false,
                );
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthVehiclesLoaded) {
                vehicles = state.vehicles;

                setState(() {
                  selectedVehicle =
                      initialSelectedVehicle = vehicles.where((element) {
                    return element.vehicleName == selectedCar?.model;
                  }).firstOrNull;
                  selectedVehicleCategory =
                      selectedVehicle?.category.vehicleType.split(' ').last;
                });
              }
            },
          ),
        ],
        child: BlocBuilder<DriverProfileBloc, DriverProfileState>(
          builder: (context, state) {
            if (state is DriverProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is DriverProfileLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IgnorePointer(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            final pickedFile = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (pickedFile != null) {
                              setState(() {
                                profilePicture = File(pickedFile.path);
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: profilePicture != null
                                ? FileImage(profilePicture!)
                                : profileImageUrl != null
                                    ? NetworkImage(profileImageUrl!)
                                    : const AssetImage(
                                        'assets/profile_icon_blank.png'),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 20),
                        CustomeTextFieldWidget(
                            readOnly: false,
                            controller: _nameController,
                            hintText: 'Name',
                            label: 'Name',
                            prefixIcon: Image.asset(
                              'assets/name_icon.png',
                              color: Colors.black,
                              height: 16,
                            ),
                            emptyMessage: 'Please enter your name',
                            keyboardType: TextInputType.text),
                        const SizedBox(height: 16),
                        CustomeTextFieldWidget(
                            controller: _emailController,
                            readOnly: true,
                            hintText: 'Email',
                            label: 'Email',
                            prefixIcon: Image.asset(
                              'assets/email_icon.png',
                              color: Colors.black,
                              height: 16,
                            ),
                            emptyMessage: 'Please enter your email',
                            keyboardType: TextInputType.emailAddress),
                        const SizedBox(height: 16),
                        CustomeTextFieldWidget(
                            readOnly: true,
                            controller: _phoneNumberController,
                            hintText: 'Phone Number',
                            label: 'Phone Number',
                            prefixIcon: Image.asset(
                              'assets/phone_icon.png',
                              color: Colors.black,
                              height: 16,
                            ),
                            emptyMessage: 'Please enter your phone number',
                            keyboardType: TextInputType.phone),
                        const SizedBox(height: 16),

                        //Selection wether the driver has a car or van. Radio Button

                        const Row(
                          children: [
                            SizedBox(width: 16),
                            Text(
                              'Select Vehicle Category',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        IgnorePointer(
                          child: Row(
                            children: [
                              Radio<String>(
                                value: 'Car',
                                groupValue: selectedVehicleCategory,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedVehicleCategory = value;
                                    selectedVehicle = null;
                                  });
                                },
                              ),
                              const Text(
                                'Car',
                                style: TextStyle(color: Colors.black),
                              ),
                              Radio<String>(
                                value: 'Van',
                                groupValue: selectedVehicleCategory,
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedVehicleCategory = value;
                                    selectedVehicle = null;
                                  });
                                },
                              ),
                              const Text(
                                'Van',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        IgnorePointer(
                          child: DropdownMenu<Vehicle>(
                              menuStyle: MenuStyle(
                                //WidgetStateProperty color
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    Colors.white),
                              ),
                              hintText: 'Select Vehicle',
                              textStyle: const TextStyle(color: Colors.black),
                              leadingIcon: const Icon(
                                Icons.directions_car,
                                color: Colors.grey,
                              ),
                              width: MediaQuery.of(context).size.width - 32,
                              inputDecorationTheme: const InputDecorationTheme(
                                constraints: BoxConstraints(
                                  minHeight: 50,
                                  minWidth: double.infinity,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                              ),
                              initialSelection: selectedVehicle,
                              onSelected: (Vehicle? value) {
                                setState(() {
                                  selectedVehicle = value;
                                });
                              },
                              dropdownMenuEntries: selectedVehicleCategory ==
                                      'Car'
                                  ? vehicles
                                      .where((element) =>
                                          element.category.vehicleType == 'Car')
                                      .map((Vehicle item) {
                                      return DropdownMenuEntry<Vehicle>(
                                        value: item,
                                        label:
                                            "${item.make} ${item.vehicleName}",
                                      );
                                    }).toList()
                                  : selectedVehicleCategory == null
                                      ? vehicles.map((Vehicle item) {
                                          return DropdownMenuEntry<Vehicle>(
                                            value: item,
                                            label:
                                                "${item.make} ${item.vehicleName}",
                                          );
                                        }).toList()
                                      : vehicles
                                          .where((element) =>
                                              element.category.vehicleType !=
                                              'Car')
                                          .map((Vehicle item) {
                                          return DropdownMenuEntry<Vehicle>(
                                            value: item,
                                            label:
                                                "${item.make} ${item.vehicleName}",
                                          );
                                        }).toList()),
                        ),
                        const SizedBox(height: 20),
                        CustomeTextFieldWidget(
                            readOnly: false,
                            controller: _carYearController,
                            hintText: 'Vehicle Year',
                            label: 'Vehicle Year',
                            prefixIcon: const Icon(
                              Icons.calendar_today,
                              color: Colors.grey,
                            ),
                            emptyMessage: 'Please enter your vehicle year',
                            keyboardType: TextInputType.number),
                        const SizedBox(height: 16),
                        CustomeTextFieldWidget(
                            readOnly: false,
                            controller: _carPlateController,
                            hintText: 'Vehicle Plate Number',
                            label: 'Vehicle Plate Number',
                            prefixIcon: const Icon(
                              Icons.directions_car,
                              color: Colors.grey,
                            ),
                            emptyMessage:
                                'Please enter your vehicle plate number',
                            keyboardType: TextInputType.text),
                        const SizedBox(height: 16),
                        CustomeTextFieldWidget(
                            readOnly: false,
                            controller: _carColorController,
                            hintText: 'Vehicle Color',
                            label: 'Vehicle Color',
                            prefixIcon: const Icon(
                              Icons.color_lens,
                              color: Colors.grey,
                            ),
                            emptyMessage: 'Please enter your vehicle color',
                            keyboardType: TextInputType.text),
                        const SizedBox(height: 16),
                        CustomeTextFieldWidget(
                            readOnly: false,
                            controller: _licenseCheckCodeController,
                            hintText: 'DVLA License Check Code',
                            label: 'DVLA License Check Code',
                            prefixIcon: const Icon(
                              Icons.code,
                              color: Colors.grey,
                            ),
                            emptyMessage:
                                'Please enter your license check code',
                            keyboardType: TextInputType.text),
                        const SizedBox(height: 16),
                        CustomeTextFieldWidget(
                            readOnly: false,
                            controller: _accountNameController,
                            hintText: 'Bank Account Name',
                            label: 'Bank Account Name',
                            prefixIcon: const Icon(
                              Icons.account_circle,
                              color: Colors.grey,
                            ),
                            emptyMessage: 'Please enter your bank account name',
                            keyboardType: TextInputType.text),
                        const SizedBox(height: 16),
                        CustomeTextFieldWidget(
                            readOnly: false,
                            controller: _accountNumberController,
                            hintText: 'Bank Account Number',
                            label: 'Bank Account Number',
                            prefixIcon: const Icon(
                              Icons.account_balance,
                              color: Colors.grey,
                            ),
                            emptyMessage:
                                'Please enter your bank account number',
                            keyboardType: TextInputType.text),
                        const SizedBox(height: 16),
                        CustomeTextFieldWidget(
                            readOnly: false,
                            controller: _accountSortCodeController,
                            hintText: 'Bank Account Sort Code',
                            label: 'Bank Account Sort Code',
                            prefixIcon: const Icon(
                              Icons.code,
                              color: Colors.grey,
                            ),
                            emptyMessage:
                                'Please enter your bank account sort code',
                            keyboardType: TextInputType.text),

                        const SizedBox(height: 8),
                        const Text(
                          'Front Picture of Driving License',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                            onTap: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  licenseFrontPicture = File(image.path);
                                });
                              }
                            },
                            child: ProfileAdditionalImageCard(
                                picture: licenseFrontPicture,
                                imageUrl: licenseFrontImageUrl,
                                color: Colors.black)),
                        const SizedBox(height: 8),
                        const Text(
                          'Back Picture of Driving License',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                            onTap: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  licenseBackPicture = File(image.path);
                                });
                              }
                            },
                            child: ProfileAdditionalImageCard(
                                picture: licenseBackPicture,
                                imageUrl: licenseBackImageUrl,
                                color: Colors.black)),
                        const SizedBox(height: 8),
                        const Text(
                          'License Plate Picture',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                            onTap: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  licensePlatePicture = File(image.path);
                                });
                              }
                            },
                            child: ProfileAdditionalImageCard(
                                picture: licensePlatePicture,
                                imageUrl: licensePlateImageUrl,
                                color: Colors.black)),
                        const SizedBox(height: 8),
                        const Text(
                          'Front Picture of Vehicle',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                            onTap: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  vehicleFrontPicture = File(image.path);
                                });
                              }
                            },
                            child: ProfileAdditionalImageCard(
                                picture: vehicleFrontPicture,
                                imageUrl: vehicleFrontImageUrl,
                                color: Colors.black)),
                        const SizedBox(height: 8),
                        const Text(
                          'Back Picture of Vehicle',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                            onTap: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  vehicleBackPicture = File(image.path);
                                });
                              }
                            },
                            child: ProfileAdditionalImageCard(
                                picture: vehicleBackPicture,
                                imageUrl: vehicleBackImageUrl,
                                color: Colors.black)),
                        const SizedBox(height: 8),
                        const Text(
                          'Left Picture of Vehicle',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                            onTap: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  vehicleLeftPicture = File(image.path);
                                });
                              }
                            },
                            child: ProfileAdditionalImageCard(
                                picture: vehicleLeftPicture,
                                imageUrl: vehicleLeftImageUrl,
                                color: Colors.black)),
                        const SizedBox(height: 8),
                        const Text(
                          'Right Picture of Vehicle',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                            onTap: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  vehicleRightPicture = File(image.path);
                                });
                              }
                            },
                            child: ProfileAdditionalImageCard(
                                picture: vehicleRightPicture,
                                imageUrl: vehicleRightImageUrl,
                                color: Colors.black)),
                        const SizedBox(height: 8),
                        const Text(
                          'Vehicle Insurance Picture',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                            onTap: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  vehicleInsurancePicture = File(image.path);
                                });
                              }
                            },
                            child: ProfileAdditionalImageCard(
                                picture: vehicleInsurancePicture,
                                imageUrl: vehicleInsuranceImageUrl,
                                color: Colors.black)),
                        const SizedBox(height: 8),
                        const Text(
                          'Public Liability Insurance Picture',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        GestureDetector(
                            onTap: () async {
                              final XFile? image = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) {
                                setState(() {
                                  publicLiabilityInsurancePicture =
                                      File(image.path);
                                });
                              }
                            },
                            child: ProfileAdditionalImageCard(
                                picture: publicLiabilityInsurancePicture,
                                imageUrl: publicLiabilityInsuranceImageUrl,
                                color: Colors.black)),
                        const SizedBox(height: 8),
                        if (selectedVehicleCategory == 'Van') ...[
                          const Text(
                            'Goods in Transit Insurance Picture',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                              onTap: () async {
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  setState(() {
                                    goodsInTransitInsurancePicture =
                                        File(image.path);
                                  });
                                }
                              },
                              child: ProfileAdditionalImageCard(
                                  picture: goodsInTransitInsurancePicture,
                                  imageUrl: goodsInTransitInsuranceImageUrl,
                                  color: Colors.black)),
                        ],

                        if (selectedVehicleCategory == 'Car') ...[
                          const Text(
                            'PCO License Picture',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                              onTap: () async {
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  setState(() {
                                    pcoLicensePicture = File(image.path);
                                  });
                                }
                              },
                              child: ProfileAdditionalImageCard(
                                  picture: pcoLicensePicture,
                                  imageUrl: pcoLicenseImageUrl,
                                  color: Colors.black)),
                        ],

                        //Add padding equal to the height of the bottom sheet
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is DriverProfileError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Failed to load driver profile'),
              );
            }
          },
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Delete Account'),
                  content: const Text(
                      'Are you sure you want to delete your account?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (driver == null) {
                          return;
                        }
                        context
                            .read<DriverProfileBloc>()
                            .add(DeleteDriverProfile(
                              id: driver!.id,
                            ));
                        final AuthBloc authBloc =
                            BlocProvider.of<AuthBloc>(context);
                        BlocProvider.of<SocketBloc>(context)
                            .unsubscribeFromEvents(authBloc.currentUserId);
                        authBloc.add(SignOutEvent());

                        // Navigate to the login page
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/login',
                          (route) => false,
                        );
                      },
                      child: const Text('Delete'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Delete Account',
              style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
