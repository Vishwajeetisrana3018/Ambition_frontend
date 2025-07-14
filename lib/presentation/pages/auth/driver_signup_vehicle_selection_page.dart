import 'package:ambition_delivery/data/models/driver_form_data.dart';
import 'package:ambition_delivery/domain/entities/vehicle.dart';
import 'package:ambition_delivery/presentation/bloc/auth_bloc.dart';
import 'package:ambition_delivery/presentation/widgets/vehicle_category_selector.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverSignupVehicleSelectionPage extends StatefulWidget {
  const DriverSignupVehicleSelectionPage(
      {super.key, required this.driverFormData});
  final DriverFormData driverFormData;

  @override
  State<DriverSignupVehicleSelectionPage> createState() =>
      _DriverSignupVehicleSelectionPageState();
}

class _DriverSignupVehicleSelectionPageState
    extends State<DriverSignupVehicleSelectionPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(FetchVehiclesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AuthFailure) {
                return Center(child: Text(state.error));
              } else if (state is AuthVehiclesLoaded) {
                widget.driverFormData.vehicles = state.vehicles;
                return Column(
                  children: [
                    // Note section
                    _buildNoteSection(),

                    const Divider(thickness: 1),
                    const SizedBox(height: 16),
                    // Vehicle category selector
                    VehicleCategorySelector(
                      selectedCategory:
                          widget.driverFormData.selectedVehicleCategory,
                      onCategoryChanged: (category) {
                        setState(() {
                          widget.driverFormData.selectedVehicleCategory =
                              category;
                          widget.driverFormData.selectedVehicle = null;
                        });
                      },
                    ),

                    // Vehicle dropdown
                    _buildVehicleDropdown(),
                    const SizedBox(height: 20),
                    // Add your vehicle selection options here

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/driver_signup_additional_info',
                              arguments: widget.driverFormData);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Continue',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
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
        });
      },
      compareFn: (item1, item2) {
        return item1 == item2;
      },
    );
  }
}
