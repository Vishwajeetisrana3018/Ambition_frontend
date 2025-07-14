import 'package:ambition_delivery/domain/entities/suggested_alternative_vehicle.dart';
import 'package:ambition_delivery/domain/usecases/get_vehicle_categories_by_items.dart';
import 'package:ambition_delivery/domain/usecases/get_vehicle_categories_by_passengers.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vehicle_categories_event.dart';
part 'vehicle_categories_state.dart';

class VehicleCategoriesBloc
    extends Bloc<VehicleCategoriesEvent, VehicleCategoriesState> {
  final GetVehicleCategoriesByItems getVehicleCategoriesByItems;
  final GetVehicleCategoriesByPassengers getVehicleCategoriesByPassengers;
  VehicleCategoriesBloc({
    required this.getVehicleCategoriesByItems,
    required this.getVehicleCategoriesByPassengers,
  }) : super(VehicleCategoriesInitial()) {
    on<GetVehicleCategoriesEvent>(_onVehicleCategoriesRequested);
    on<GetVehicleCategoriesByPassengerCapacityEvent>(
        _onVehicleCategoriesByPassengerCapicityRequested);
  }

  Future<void> _onVehicleCategoriesRequested(GetVehicleCategoriesEvent event,
      Emitter<VehicleCategoriesState> emit) async {
    try {
      emit(VehicleCategoriesLoading());
      final vehicleCategories = await getVehicleCategoriesByItems(event.items);
      emit(VehicleCategoriesLoaded(vehicleCategories));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(VehicleCategoriesError(e.response!.data.toString()));
      } else {
        emit(VehicleCategoriesError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(VehicleCategoriesError(e.toString()));
    }
  }

  Future<void> _onVehicleCategoriesByPassengerCapicityRequested(
      GetVehicleCategoriesByPassengerCapacityEvent event,
      Emitter<VehicleCategoriesState> emit) async {
    try {
      emit(VehicleCategoriesLoading());
      final vehicleCategories =
          await getVehicleCategoriesByPassengers(event.passengerCapacity);
      emit(VehicleCategoriesLoaded(vehicleCategories));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(VehicleCategoriesError(e.response!.data.toString()));
      } else {
        emit(VehicleCategoriesError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(VehicleCategoriesError(e.toString()));
    }
  }
}
