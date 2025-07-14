import 'package:ambition_delivery/domain/entities/location_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class UtilityFunctions {
  static void openMap({
    required LocationEntity? originPlace,
    required LocationEntity? destinationPlace,
    List<LocationEntity>? waypointsPlaces,
  }) async {
    // Validate the latitude and longitude
    if (originPlace == null && destinationPlace == null) {
      throw Exception('Both origin and destination places are empty');
    }

    // Construct the waypoints string if provided
    String waypointsString = '';
    if (waypointsPlaces != null && waypointsPlaces.isNotEmpty) {
      waypointsString = '&waypoints=';
      for (int i = 0; i < waypointsPlaces.length; i++) {
        waypointsString +=
            '${waypointsPlaces[i].coordinates[0]},${waypointsPlaces[i].coordinates[1]}';
        if (i < waypointsPlaces.length - 1) {
          waypointsString += '%7C'; // Separator between waypoints
        }
      }
    }

    // Construct the URL for directions using latitude and longitude
    if (originPlace != null && destinationPlace != null) {
      final String origin =
          '${originPlace.coordinates[0]},${originPlace.coordinates[1]}';
      final String destination =
          '${destinationPlace.coordinates[0]},${destinationPlace.coordinates[1]}';
      final url = Uri.parse(
          'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination$waypointsString');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw Exception('Could not launch $url');
      }
    } else if (destinationPlace != null) {
      // If only destination is provided, search for it
      final String destination =
          '${destinationPlace.coordinates[0]},${destinationPlace.coordinates[1]}';
      final url = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$destination');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw Exception('Could not launch $url');
      }
    } else {
      throw Exception('Both origin and destination places are empty');
    }
  }
}
