import 'package:ambition_delivery/presentation/bloc/payment_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/payment_event.dart';
import 'package:ambition_delivery/presentation/bloc/payment_state.dart';
import 'package:ambition_delivery/presentation/bloc/ride_request_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/vehicle_categories_bloc.dart';
import 'package:ambition_delivery/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/vehicle_category.dart';

class CarCategorySelectionScreen extends StatefulWidget {
  const CarCategorySelectionScreen({super.key, required this.rideRequest});
  final Map<String, dynamic> rideRequest;

  @override
  State<CarCategorySelectionScreen> createState() =>
      _CarCategorySelectionScreenState();
}

class _CarCategorySelectionScreenState
    extends State<CarCategorySelectionScreen> {
  VehicleCategory? selectedVehicleCategory;
  Map<String, dynamic>? currentUserData;
  num amount = 0;
  num vehicleAmount = 0;

// Helper method to format the main amount
  String _formatAmount(num amount, num vehicleAmount) {
    if ((amount + vehicleAmount) > 0) {
      return '£${((amount + vehicleAmount) / 100).toStringAsFixed(2)}';
    }
    return '£0.00';
  }

  @override
  void initState() {
    vehicleAmount = widget.rideRequest['amount'];
    // Dispatch events to their respective blocs
    BlocProvider.of<RideRequestBloc>(context).add(GetCurrentUserDataEvent());
    BlocProvider.of<VehicleCategoriesBloc>(context)
        .add(GetVehicleCategoriesByPassengerCapacityEvent(passengerCapacity: {
      "originLat": widget.rideRequest['pickupLocationLat'],
      "originLong": widget.rideRequest['pickupLocationLng'],
      "destinationLat": widget.rideRequest['dropoffLocationLat'],
      "destinationLong": widget.rideRequest['dropoffLocationLng'],
      "passengersCount": widget.rideRequest['passengersCount'],
    }));

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
          title: const Text('Select Car Category'),
        ),
        body: MultiBlocListener(
          listeners: [
            // Listen to RideRequestBloc for user data
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
                }
              },
            ),
            // Listen to VehicleCategoriesBloc for errors
            BlocListener<VehicleCategoriesBloc, VehicleCategoriesState>(
              listener: (context, state) {
                if (state is VehicleCategoriesError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
            ),
          ],
          child: BlocBuilder<VehicleCategoriesBloc, VehicleCategoriesState>(
            builder: (context, state) {
              if (state is VehicleCategoriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is VehicleCategoriesLoaded) {
                if (state.vehicleCategories.suggestedVehicle == null &&
                    state.vehicleCategories.alternativeVehicles.isEmpty) {
                  return const Center(
                    child: Text('No Car Categories available'),
                  );
                }
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Suggested Car Category',
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
                            amount = (widget.rideRequest['isEventJob'] as bool)
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
                              (widget.rideRequest['isEventJob'] as bool)
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
                      'Alternative Car Categories',
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
                                amount =
                                    (widget.rideRequest['isEventJob'] as bool)
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
                                  (widget.rideRequest['isEventJob'] as bool)
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

                    // Add a button to proceed to the next screen
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                      ),
                      onPressed: () {
                        if (selectedVehicleCategory != null) {
                          context.read<PaymentBloc>().add(
                                InitiateCarAndVehiclePayment(
                                    amount: (amount + vehicleAmount) > 0
                                        ? (amount + vehicleAmount).toInt()
                                        : 0,
                                    email: currentUserData?['email'] ?? ''),
                              );
                        }
                      },
                      child: BlocConsumer<PaymentBloc, PaymentState>(
                        listener: (context, state) {
                          if (state is PaymentCarAndVehicleSuccess) {
                            Navigator.of(context).pushNamed(
                              '/ride_request',
                              arguments: {
                                'user': currentUserData?['id'],
                                'vehicleCategory':
                                    widget.rideRequest['vehicleCategory'],
                                "carCategory": selectedVehicleCategory!.id,
                                "moveType": widget.rideRequest['moveType'],
                                "jobType": widget.rideRequest['jobType'],
                                "isRideAndMove":
                                    widget.rideRequest['isRideAndMove'],
                                "isEventJob": widget.rideRequest['isEventJob'],
                                "pickupLocationLat":
                                    widget.rideRequest['pickupLocationLat'],
                                "pickupLocationLng":
                                    widget.rideRequest['pickupLocationLng'],
                                "pickupLocationName":
                                    widget.rideRequest['pickupLocationName'],
                                "pickupLocationAddress":
                                    widget.rideRequest['pickupLocationAddress'],
                                "dropoffLocationLat":
                                    widget.rideRequest['dropoffLocationLat'],
                                "dropoffLocationLng":
                                    widget.rideRequest['dropoffLocationLng'],
                                "dropoffLocationName":
                                    widget.rideRequest['dropoffLocationName'],
                                "dropoffLocationAddress": widget
                                    .rideRequest['dropoffLocationAddress'],
                                "distance": widget.rideRequest['distance'],
                                'time': widget.rideRequest['time'],
                                'items': widget.rideRequest['items'],
                                'customItems':
                                    widget.rideRequest['customItems'],
                                "pickupFloor":
                                    widget.rideRequest['pickupFloor'],
                                "dropoffFloor":
                                    widget.rideRequest['dropoffFloor'],
                                "requiredHelpers":
                                    widget.rideRequest['requiredHelpers'],
                                "peopleTaggingAlong":
                                    widget.rideRequest['peopleTaggingAlong'],
                                "specialRequirements":
                                    widget.rideRequest['specialRequirements'],
                                "passengersCount":
                                    widget.rideRequest['passengersCount'],
                                "vehicleInitialServiceFee": widget
                                    .rideRequest['vehicleInitialServiceFee'],
                                "vehicleServiceFee":
                                    widget.rideRequest['vehicleServiceFee'],
                                "vehicleTimeFare":
                                    widget.rideRequest['vehicleTimeFare'],
                                "vehicleItemBasedPricing": widget
                                    .rideRequest['vehicleItemBasedPricing'],
                                "carTimeFare":
                                    selectedVehicleCategory?.fares?.timeFare,
                                "helpersCharge":
                                    widget.rideRequest['helpersCharge'],
                                "congestionCharge":
                                    widget.rideRequest['congestionCharge'],
                                "surcharge": widget.rideRequest['surcharge'],
                                "total": (amount + vehicleAmount) > 0
                                    ? ((amount + vehicleAmount) / 100)
                                        .toStringAsFixed(2)
                                    : 0,
                                "transactionId":
                                    state.paymentSheetData.transactionId,
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
                            'Proceed to Pay ${_formatAmount(amount, vehicleAmount)}',
                            style: const TextStyle(color: Colors.black),
                          );
                        },
                      ),
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
