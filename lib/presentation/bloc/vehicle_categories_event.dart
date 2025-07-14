part of 'vehicle_categories_bloc.dart';

sealed class VehicleCategoriesEvent extends Equatable {
  const VehicleCategoriesEvent();

  @override
  List<Object> get props => [];
}

final class GetVehicleCategoriesEvent extends VehicleCategoriesEvent {
  final Map<String, dynamic> items;

  const GetVehicleCategoriesEvent({required this.items});

  @override
  List<Object> get props => [items];
}

final class GetVehicleCategoriesByPassengerCapacityEvent
    extends VehicleCategoriesEvent {
  final Map<String, dynamic> passengerCapacity;

  const GetVehicleCategoriesByPassengerCapacityEvent(
      {required this.passengerCapacity});

  @override
  List<Object> get props => [passengerCapacity];
}
