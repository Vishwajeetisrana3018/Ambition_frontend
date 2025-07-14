part of 'vehicle_categories_bloc.dart';

sealed class VehicleCategoriesState extends Equatable {
  const VehicleCategoriesState();

  @override
  List<Object?> get props => [];
}

final class VehicleCategoriesInitial extends VehicleCategoriesState {}

final class VehicleCategoriesLoading extends VehicleCategoriesState {}

final class VehicleCategoriesError extends VehicleCategoriesState {
  final String message;

  const VehicleCategoriesError(this.message);

  @override
  List<Object> get props => [message];
}

final class VehicleCategoriesLoaded extends VehicleCategoriesState {
  final SuggestedAlternativeVehicle vehicleCategories;

  const VehicleCategoriesLoaded(this.vehicleCategories);

  @override
  List<Object> get props => [vehicleCategories];
}
