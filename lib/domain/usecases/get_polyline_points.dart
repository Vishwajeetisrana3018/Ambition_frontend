import 'package:ambition_delivery/domain/entities/polyline_point_entity.dart';
import 'package:ambition_delivery/domain/repositories/ride_request_repository.dart';

class GetPolylinePoints {
  final RideRequestRepository _rideRequestRepository;

  GetPolylinePoints(this._rideRequestRepository);

  Future<List<PolylinePointEntity>> call(Map<String, dynamic> data) async {
    return _rideRequestRepository.getPolylinePoints(data);
  }
}
