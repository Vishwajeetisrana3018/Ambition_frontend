import 'dart:io';
import 'package:ambition_delivery/data/models/driver_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../domain/entities/vehicle.dart';
import 'vehicle_category_selector.dart';
import 'image_upload_section.dart';

class DriverInfoForm extends StatefulWidget {
  final DriverFormData driverFormData;
  final Function(DriverFormData) onDataChanged;

  const DriverInfoForm({
    super.key,
    required this.driverFormData,
    required this.onDataChanged,
  });

  @override
  State<DriverInfoForm> createState() => _DriverInfoFormState();
}

class _DriverInfoFormState extends State<DriverInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Information',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 16),

        const Divider(thickness: 1),

        // Note section
        _buildNoteSection(),

        const Divider(thickness: 1),
        const SizedBox(height: 16),

        // Vehicle category selector
        VehicleCategorySelector(
          selectedCategory: widget.driverFormData.selectedVehicleCategory,
          onCategoryChanged: (category) {
            setState(() {
              widget.driverFormData.selectedVehicleCategory = category;
              widget.driverFormData.selectedVehicle = null;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        // Vehicle dropdown
        _buildVehicleDropdown(),
        const SizedBox(height: 20),

        // Vehicle details fields
        _buildVehicleDetailsFields(),

        // License check code field
        _buildLicenseCheckCodeField(),

        // Bank account fields
        _buildBankAccountFields(),

        // Document upload sections
        _buildDocumentUploadSections(),
      ],
    );
  }

  Widget _buildNoteSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Note:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• ', style: TextStyle(fontSize: 16)),
            Expanded(
              child: Text(
                'Drivers cannot register or drive as an Ambition Driver with a van that has any branding, logos, or stickers inside or outside of the vehicle.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• ', style: TextStyle(fontSize: 16)),
            Expanded(
              child: Text(
                'The vehicle should not be more than 15 years old.',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVehicleDropdown() {
    return DropdownSearch<Vehicle>(
      popupProps: PopupProps.menu(
        showSearchBox: true,
        menuProps: const MenuProps(
          shadowColor: Colors.transparent,
          color: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          barrierColor: Colors.transparent,
        ),
        searchFieldProps: const TextFieldProps(
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search vehicle',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(width: 1.0),
            ),
          ),
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.4,
        ),
      ),
      decoratorProps: DropDownDecoratorProps(
        baseStyle: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Select Vehicle',
          prefixIcon: const Icon(Icons.directions_car, color: Colors.grey),
          filled: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 1.0),
          ),
        ),
      ),
      items: (filter, infiniteScrollProps) {
        final category = widget.driverFormData.selectedVehicleCategory;
        if (category == 'Car') {
          return widget.driverFormData.vehicles
              .where((v) => v.category.vehicleType == 'Car')
              .toList();
        } else if (category == null) {
          return widget.driverFormData.vehicles;
        } else {
          return widget.driverFormData.vehicles
              .where((v) => v.category.vehicleType != 'Car')
              .toList();
        }
      },
      itemAsString: (Vehicle v) => "${v.make} ${v.vehicleName}",
      selectedItem: widget.driverFormData.selectedVehicle,
      onChanged: (Vehicle? value) {
        setState(() {
          widget.driverFormData.selectedVehicle = value;
          widget.onDataChanged(widget.driverFormData);
        });
      },
      compareFn: (item1, item2) {
        return item1 == item2;
      },
    );
  }

  Widget _buildVehicleDetailsFields() {
    return Column(
      children: [
        TextFormField(
          controller: widget.driverFormData.carYearController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
            hintText: 'Vehicle Year',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your vehicle year';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.driverFormData.carPlateController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.directions_car, color: Colors.grey),
            hintText: 'Vehicle Plate Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your vehicle plate number';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: widget.driverFormData.carColorController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.color_lens, color: Colors.grey),
            hintText: 'Vehicle Color',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your vehicle color';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildLicenseCheckCodeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            RichText(
              text: TextSpan(
                text: 'DVLA License Check Code',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' \u{1F517}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = Uri.parse(
                            'https://www.gov.uk/view-driving-licence');
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.driverFormData.licenseCheckCodeController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.code, color: Colors.grey),
            hintText: 'DVLA License Check Code',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your license check code';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildBankAccountFields() {
    return Column(
      children: [
        TextFormField(
          controller: widget.driverFormData.accountNameController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.account_circle, color: Colors.grey),
            hintText: 'Bank Account Name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your bank account name';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.driverFormData.accountNumberController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.account_balance, color: Colors.grey),
            hintText: 'Bank Account Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your bank account number';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.driverFormData.accountSortCodeController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.security, color: Colors.grey),
            hintText: 'Bank Account Sort Code',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(width: 1.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your bank account sort code';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildDocumentUploadSections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // License documents
        ImageUploadSection(
          title: 'Front Picture of Driving License',
          image: widget.driverFormData.licenseFrontPicture,
          onImageSelected: (File image) {
            setState(() {
              widget.driverFormData.licenseFrontPicture = image;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        ImageUploadSection(
          title: 'Back Picture of Driving License',
          image: widget.driverFormData.licenseBackPicture,
          onImageSelected: (File image) {
            setState(() {
              widget.driverFormData.licenseBackPicture = image;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        ImageUploadSection(
          title: 'License Plate Picture',
          image: widget.driverFormData.licensePlatePicture,
          onImageSelected: (File image) {
            setState(() {
              widget.driverFormData.licensePlatePicture = image;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        // Vehicle pictures
        ImageUploadSection(
          title: 'Vehicle Front Picture',
          image: widget.driverFormData.vehicleFrontPicture,
          onImageSelected: (File image) {
            setState(() {
              widget.driverFormData.vehicleFrontPicture = image;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        ImageUploadSection(
          title: 'Vehicle Back Picture',
          image: widget.driverFormData.vehicleBackPicture,
          onImageSelected: (File image) {
            setState(() {
              widget.driverFormData.vehicleBackPicture = image;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        ImageUploadSection(
          title: 'Vehicle Left Picture',
          image: widget.driverFormData.vehicleLeftPicture,
          onImageSelected: (File image) {
            setState(() {
              widget.driverFormData.vehicleLeftPicture = image;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        ImageUploadSection(
          title: 'Vehicle Right Picture',
          image: widget.driverFormData.vehicleRightPicture,
          onImageSelected: (File image) {
            setState(() {
              widget.driverFormData.vehicleRightPicture = image;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        // Insurance documents
        ImageUploadSection(
          title: 'Vehicle Insurance Picture',
          image: widget.driverFormData.vehicleInsurancePicture,
          onImageSelected: (File image) {
            setState(() {
              widget.driverFormData.vehicleInsurancePicture = image;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        ImageUploadSection(
          title: 'Public Liability Insurance Picture',
          image: widget.driverFormData.publicLiabilityInsurancePicture,
          onImageSelected: (File image) {
            setState(() {
              widget.driverFormData.publicLiabilityInsurancePicture = image;
              widget.onDataChanged(widget.driverFormData);
            });
          },
        ),

        // Vehicle category specific documents
        if (widget.driverFormData.selectedVehicleCategory == 'Van')
          ImageUploadSection(
            title: 'Goods in Transit Insurance Picture',
            image: widget.driverFormData.goodsInTransitInsurancePicture,
            onImageSelected: (File image) {
              setState(() {
                widget.driverFormData.goodsInTransitInsurancePicture = image;
                widget.onDataChanged(widget.driverFormData);
              });
            },
          ),

        if (widget.driverFormData.selectedVehicleCategory == 'Car')
          ImageUploadSection(
            title: 'PCO License Picture',
            image: widget.driverFormData.pcoLicensePicture,
            onImageSelected: (File image) {
              setState(() {
                widget.driverFormData.pcoLicensePicture = image;
                widget.onDataChanged(widget.driverFormData);
              });
            },
          ),

        const SizedBox(height: 20),
      ],
    );
  }
}
