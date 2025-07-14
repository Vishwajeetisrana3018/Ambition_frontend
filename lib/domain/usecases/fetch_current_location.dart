import 'package:ambition_delivery/utils/location_service.dart';
import 'package:geolocator/geolocator.dart';

class FetchCurrentLocation {
  Future<Position> call() async {
    return await LocationService.determinePosition();
  }
}
