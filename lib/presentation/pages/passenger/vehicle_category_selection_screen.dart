import 'package:ambition_delivery/domain/entities/ride_request_details.dart';
import 'package:ambition_delivery/presentation/bloc/payment_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/payment_event.dart';
import 'package:ambition_delivery/presentation/bloc/payment_state.dart';
import 'package:ambition_delivery/presentation/bloc/ride_request_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/vehicle_categories_bloc.dart';
import 'package:ambition_delivery/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/vehicle_category.dart';

class VehicleCategorySelectionScreen extends StatefulWidget {
  const VehicleCategorySelectionScreen({super.key, required this.items});
  final Map<String, dynamic> items;

  @override
  State<VehicleCategorySelectionScreen> createState() =>
      _VehicleCategorySelectionScreenState();
}

class _VehicleCategorySelectionScreenState
    extends State<VehicleCategorySelectionScreen> {
  late final RideRequestBloc _rideRequestBloc;
  late final VehicleCategoriesBloc _vehicleCategoryBloc;
  VehicleCategory? selectedVehicleCategory;
  Map<String, dynamic>? currentUserData;
  RideRequestDetails? rideRequestDetails;
  num amount = 0;
  bool isLoading = false;
  DateTime? scheduledTime;

  @override
  void initState() {
    _rideRequestBloc = BlocProvider.of<RideRequestBloc>(context);
    _vehicleCategoryBloc = BlocProvider.of<VehicleCategoriesBloc>(context);
    _rideRequestBloc.add(GetCurrentUserDataEvent());
    _vehicleCategoryBloc.add(GetVehicleCategoriesEvent(items: widget.items));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        // WidgetsBinding.instance.addPostFrameCallback((_) {
        //   Navigator.of(context).popUntil((route) => route.isFirst);
        // });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Select Vehicle Category'),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<RideRequestBloc, RideRequestState>(
              listener: (context, state) {
                if (state is RideRequestError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                } else if (state is CurrentUserLoaded) {
                  setState(() {
                    currentUserData = state.user;
                  });
                } else if (state is RideRequestLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
            ),
            BlocListener<VehicleCategoriesBloc, VehicleCategoriesState>(
              listener: (context, state) {
                if (state is VehicleCategoriesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                } else if (state is VehicleCategoriesLoaded) {
                  setState(() {
                    rideRequestDetails =
                        state.vehicleCategories.rideRequestDeails;
                    isLoading = false;
                  });
                } else if (state is VehicleCategoriesLoading) {
                  setState(() {
                    isLoading = true;
                  });
                }
              },
            ),
          ],
          child: BlocBuilder<VehicleCategoriesBloc, VehicleCategoriesState>(
            builder: (context, state) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is VehicleCategoriesLoaded) {
                if (state.vehicleCategories.suggestedVehicle == null &&
                    state.vehicleCategories.alternativeVehicles.isEmpty) {
                  return const Center(
                    child: Text('No vehicle categories found'),
                  );
                }
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Suggested Vehicle',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    if (state.vehicleCategories.suggestedVehicle != null) ...[
                      ListTile(
                        leading: Consts.getVehicleIcon(state
                            .vehicleCategories.suggestedVehicle?.vehicleType),
                        selected: selectedVehicleCategory ==
                            state.vehicleCategories.suggestedVehicle,
                        selectedTileColor: Colors.grey[300],
                        onTap: () {
                          setState(() {
                            selectedVehicleCategory =
                                state.vehicleCategories.suggestedVehicle;
                            amount = (widget.items['isEventJob'] as bool)
                                ? (selectedVehicleCategory?.fares?.eventFare ??
                                        0) *
                                    100
                                : (selectedVehicleCategory?.fares?.timeFare ??
                                        0) *
                                    100;
                          });
                        },
                        title: Text(
                            state.vehicleCategories.suggestedVehicle!.name),
                        subtitle: Text(state
                            .vehicleCategories.suggestedVehicle!.vehicleType),
                        trailing: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.person),
                                Text(
                                  state.vehicleCategories.suggestedVehicle !=
                                          null
                                      ? state.vehicleCategories
                                          .suggestedVehicle!.passengerCapacity
                                          .toString()
                                      : '0',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Text(
                              Consts.isEventRequest(widget.items['jobType'])
                                  ? "£${(state.vehicleCategories.suggestedVehicle?.fares?.eventFare ?? 0).toStringAsFixed(2)}"
                                  : "£${(state.vehicleCategories.suggestedVehicle?.fares?.timeFare ?? 0).toStringAsFixed(2)}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                    const SizedBox(height: 20),
                    Text(
                      'Alternative Vehicles',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            state.vehicleCategories.alternativeVehicles.length,
                        itemBuilder: (context, index) {
                          final vehicle = state
                              .vehicleCategories.alternativeVehicles[index];
                          return ListTile(
                            leading: Consts.getVehicleIcon(vehicle.vehicleType),
                            selected: selectedVehicleCategory == vehicle,
                            selectedTileColor: Colors.grey[300],
                            onTap: () {
                              setState(() {
                                selectedVehicleCategory = vehicle;
                                amount = (widget.items['isEventJob'] as bool)
                                    ? (selectedVehicleCategory
                                                ?.fares?.eventFare ??
                                            0) *
                                        100
                                    : (selectedVehicleCategory
                                                ?.fares?.timeFare ??
                                            0) *
                                        100;
                              });
                            },
                            title: Text(vehicle.name),
                            subtitle: Text(vehicle.vehicleType),
                            trailing: Column(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.person),
                                    Text(
                                      vehicle.passengerCapacity.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Text(
                                  (widget.items['isEventJob'] as bool)
                                      ? "£${(vehicle.fares?.eventFare ?? 0).toStringAsFixed(2)}"
                                      : "£${(vehicle.fares?.timeFare ?? 0).toStringAsFixed(2)}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Add a button to proceed to the next screen
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                          ),
                          onPressed: () {
                            if (selectedVehicleCategory != null) {
                              if (widget.items['passengersCount'] != null) {
                                Navigator.of(context).pushNamed(
                                  '/car_category_selection',
                                  arguments: {
                                    'user': currentUserData?['id'],
                                    'vehicleCategory':
                                        selectedVehicleCategory!.id,
                                    "moveType": widget.items['moveType'],
                                    "jobType": widget.items['jobType'],
                                    "isRideAndMove":
                                        widget.items['isRideAndMove'],
                                    "isEventJob": widget.items['isEventJob'],
                                    "pickupLocationLat":
                                        widget.items['originLat'],
                                    "pickupLocationLng":
                                        widget.items['originLong'],
                                    "pickupLocationName":
                                        widget.items['originName'],
                                    "pickupLocationAddress":
                                        widget.items['originAddress'],
                                    "dropoffLocationLat":
                                        widget.items['destinationLat'],
                                    "dropoffLocationLng":
                                        widget.items['destinationLong'],
                                    "dropoffLocationName":
                                        widget.items['destinationName'],
                                    "dropoffLocationAddress":
                                        widget.items['destinationAddress'],
                                    "distance": rideRequestDetails?.distance,
                                    'time': rideRequestDetails?.time,
                                    'items': widget.items['items'],
                                    'customItems': widget.items['customItems'],
                                    "pickupFloor": widget.items['pickupFloor'],
                                    "dropoffFloor":
                                        widget.items['dropoffFloor'],
                                    "requiredHelpers":
                                        widget.items['requiredHelpers'],
                                    "peopleTaggingAlong":
                                        widget.items['peopleTagging'],
                                    "specialRequirements":
                                        widget.items['specialRequirements'],
                                    "passengersCount":
                                        widget.items['passengersCount'],
                                    "vehicleInitialServiceFee":
                                        (widget.items['isEventJob'] as bool)
                                            ? selectedVehicleCategory
                                                ?.fares?.initialServiceFee
                                            : 0,
                                    "vehicleServiceFee":
                                        (widget.items['isEventJob'] as bool)
                                            ? selectedVehicleCategory
                                                ?.fares?.serviceFee
                                            : 0,
                                    "vehicleTimeFare": selectedVehicleCategory
                                        ?.fares?.timeFare,
                                    "vehicleItemBasedPricing":
                                        selectedVehicleCategory
                                            ?.fares?.itemBasedPricing,
                                    "helpersCharge": selectedVehicleCategory
                                        ?.fares?.helpersCharge,
                                    "congestionCharge": selectedVehicleCategory
                                        ?.fares?.congestionCharge,
                                    "surcharge": selectedVehicleCategory
                                        ?.fares?.surcharge,
                                    'amount': amount.toInt(),
                                  },
                                ).then((value) {
                                  _rideRequestBloc
                                      .add(GetCurrentUserDataEvent());
                                  _vehicleCategoryBloc.add(
                                      GetVehicleCategoriesEvent(
                                          items: widget.items));
                                });
                              } else {
                                context.read<PaymentBloc>().add(
                                      InitiateVehiclePayment(
                                          amount: amount.toInt(),
                                          email:
                                              currentUserData?['email'] ?? ''),
                                    );
                              }
                            }
                          },
                          child: BlocConsumer<PaymentBloc, PaymentState>(
                            listener: (context, state) {
                              if (state is PaymentVehicleSuccess) {
                                Navigator.of(context).pushNamed(
                                  '/ride_request',
                                  arguments: {
                                    'user': currentUserData?['id'],
                                    'vehicleCategory':
                                        selectedVehicleCategory!.id,
                                    "moveType": widget.items['moveType'],
                                    "jobType": widget.items['jobType'],
                                    "isRideAndMove":
                                        widget.items['isRideAndMove'],
                                    "isEventJob": widget.items['isEventJob'],
                                    "pickupLocationLat":
                                        widget.items['originLat'],
                                    "pickupLocationLng":
                                        widget.items['originLong'],
                                    "pickupLocationName":
                                        widget.items['originName'],
                                    "pickupLocationAddress":
                                        widget.items['originAddress'],
                                    "dropoffLocationLat":
                                        widget.items['destinationLat'],
                                    "dropoffLocationLng":
                                        widget.items['destinationLong'],
                                    "dropoffLocationName":
                                        widget.items['destinationName'],
                                    "dropoffLocationAddress":
                                        widget.items['destinationAddress'],
                                    "distance": rideRequestDetails?.distance,
                                    'time': rideRequestDetails?.time,
                                    'items': widget.items['items'],
                                    'customItems': widget.items['customItems'],
                                    "pickupFloor": widget.items['pickupFloor'],
                                    "dropoffFloor":
                                        widget.items['dropoffFloor'],
                                    "requiredHelpers":
                                        widget.items['requiredHelpers'],
                                    "peopleTaggingAlong":
                                        widget.items['peopleTagging'],
                                    "specialRequirements":
                                        widget.items['specialRequirements'],
                                    "passengersCount":
                                        widget.items['passengersCount'],
                                    "vehicleInitialServiceFee":
                                        selectedVehicleCategory
                                            ?.fares?.initialServiceFee,
                                    "vehicleServiceFee": selectedVehicleCategory
                                        ?.fares?.serviceFee,
                                    "vehicleTimeFare": selectedVehicleCategory
                                        ?.fares?.timeFare,
                                    "vehicleItemBasedPricing":
                                        selectedVehicleCategory
                                            ?.fares?.itemBasedPricing,
                                    "helpersCharge": selectedVehicleCategory
                                        ?.fares?.helpersCharge,
                                    "congestionCharge": selectedVehicleCategory
                                        ?.fares?.congestionCharge,
                                    "surcharge": selectedVehicleCategory
                                        ?.fares?.surcharge,
                                    "total":
                                        (widget.items['isEventJob'] as bool)
                                            ? (selectedVehicleCategory
                                                    ?.fares?.eventFare ??
                                                0)
                                            : (selectedVehicleCategory
                                                    ?.fares?.timeFare ??
                                                0),
                                    "transactionId":
                                        state.paymentSheetData.transactionId,
                                    "scheduledTime": scheduledTime?.toIso8601String(),
                                  },
                                );
                              } else if (state is PaymentFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error)),
                                );
                              }
                            },
                            builder: (context, state) {
                              if (state is PaymentLoading) {
                                return const CircularProgressIndicator();
                              }
                              return Text(
                                  widget.items['passengersCount'] != null
                                      ? 'Proceed to select car category'
                                      : 'Proceed to Pay £${amount > 0 ? amount / 100 : 0}',
                                  style: const TextStyle(color: Colors.black));
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final DateTime now = DateTime.now();
                            final DateTime maxTime = now.add(const Duration(hours: 24));
                            
                            final TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(now.add(const Duration(minutes: 30))),
                              builder: (BuildContext context, Widget? child) {
                                return MediaQuery(
                                  data: MediaQuery.of(context).copyWith(
                                    alwaysUse24HourFormat: true,
                                  ),
                                  child: child!,
                                );
                              },
                              helpText: 'Select time within next 24 hours',
                              cancelText: 'Cancel',
                              confirmText: 'Confirm',
                            );

                            if (selectedTime != null) {
                              DateTime selectedDateTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                selectedTime.hour,
                                selectedTime.minute,
                              );

                              if (selectedDateTime.isBefore(now)) {
                                selectedDateTime = selectedDateTime.add(const Duration(days: 1));
                              }

                              if (selectedDateTime.isBefore(maxTime)) {
                                final String formattedDate = selectedDateTime.day == now.day 
                                    ? 'Today' 
                                    : '${selectedDateTime.day}/${selectedDateTime.month}/${selectedDateTime.year}';
                                final String formattedTime = '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
                                
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Ride scheduled for $formattedDate at $formattedTime'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                                scheduledTime = selectedDateTime;
                              }
                            }
                          },
                          child: const Text('Schedule Ride'),
                        )
                      ],
                    ),
                  ],
                );
              } else if (state is VehicleCategoriesError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
