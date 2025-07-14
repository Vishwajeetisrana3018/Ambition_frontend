import 'dart:developer';

import 'package:ambition_delivery/data/models/polyline_point_model.dart';
import 'package:ambition_delivery/data/models/ride_request_model.dart';
import 'package:ambition_delivery/data/models/ride_with_earnings_model.dart';
import 'package:ambition_delivery/domain/entities/polyline_point_entity.dart';
import 'package:ambition_delivery/domain/entities/ride_with_earnings.dart';
import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';
import 'package:ambition_delivery/domain/entities/ride_request.dart';

import '../datasources/remote_data_source.dart';

class RideRequestRepositoryImpl implements RideRequestRepository {
  final RemoteDataSource remoteDataSource;

  RideRequestRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createRideRequest(Map<String, dynamic> rideRequest) {
    return remoteDataSource.createRideRequest(rideRequest);
  }

  @override
  Future<void> deleteRideRequest(String id) async {
    return await remoteDataSource.deleteRideRequest(id);
  }

  @override
  Future<RideRequest?> getRideRequest(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<RideRequest>> getRideRequests() {
    throw UnimplementedError();
  }

  @override
  Future<void> updateRideRequest(Map<String, dynamic> rideRequest, String id) {
    return remoteDataSource.updateRideRequestByDriverId(rideRequest, id);
  }

  @override
  Future<RideWithEarnings?> getPendingRideRequestsByDriverCarCategory(
      String driverId) async {
    final response = await remoteDataSource
        .getPendingRideRequestsByDriverCarCategory(driverId);
    if (response.statusCode == 200) {
      return RideWithEarningsModel.fromJson(response.data).toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<RideRequest?> getOngoingRideRequestByDriverId(String driverId) async {
    final response =
        await remoteDataSource.getOngoingRideRequestByDriverId(driverId);
    if (response.statusCode == 200) {
      return RideRequestModel.fromJson(response.data).toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<RideRequest?> getOngoingRideRequestByUserId(String userId) async {
    final response =
        await remoteDataSource.getOngoingRideRequestByUserId(userId);
    if (response.statusCode == 200) {
      return RideRequestModel.fromJson(response.data).toEntity();
    } else {
      return null;
    }
  }

  @override
  Future<List<RideRequest?>> getClosedRideRequestsByDriverId(
      String driverId) async {
    final response =
        await remoteDataSource.getClosedRideRequestsByDriverId(driverId);
    if (response.statusCode == 200) {
      log('response.data: ${response.data}');
      return response.data
          .map<RideRequest?>(
              (data) => RideRequestModel.fromJson(data).toEntity())
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<RideRequest?>> getClosedRideRequestsByUserId(
      String userId) async {
    final response =
        await remoteDataSource.getClosedRideRequestsByUserId(userId);
    if (response.statusCode == 200) {
      return response.data
          .map<RideRequest?>(
              (data) => RideRequestModel.fromJson(data).toEntity())
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<List<PolylinePointEntity>> getPolylinePoints(
      Map<String, dynamic> data) async {
    final response = await remoteDataSource.getPolylinePoints(data);
    if (response.statusCode == 200) {
      return response.data['polyline']
          .map<PolylinePointEntity>(
              (data) => PolylinePointModel.fromJson(data).toEntity())
          .toList();
    } else {
      return [];
    }
  }

  @override
  Future<void> cancelRideRequest(String rideId) async {
    final response = await remoteDataSource.cancelRideRequest(rideId);
    if (response.statusCode != 200) {
      throw Exception('Failed to cancel ride request');
    }
  }

  @override
  Future<void> completeRideRequest(String rideId) async {
    final response = await remoteDataSource.completeRideRequest(rideId);
    if (response.statusCode != 200) {
      throw Exception('Failed to complete ride request');
    }
  }
}
