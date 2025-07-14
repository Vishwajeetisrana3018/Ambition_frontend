class RideRequestDetails {
  final num totalVolume; // In cubic meters
  final num totalWeight; // In kilograms
  final Map<String, dynamic> itemCounts; // Counts for each item size
  final int peopleTagging; // Number of people tagging
  final num distance; // Distance in kilometers
  final num time; // Time in minutes

  RideRequestDetails({
    required this.totalVolume,
    required this.totalWeight,
    required this.itemCounts,
    required this.peopleTagging,
    required this.distance,
    required this.time,
  });
}
