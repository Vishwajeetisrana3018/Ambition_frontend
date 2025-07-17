import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

const kGoogleApiKey = 'AIzaSyDbLG11NC8jAUTJRYBX6Pq3C0EYZrRnON0';

class PickupDropoffAddressScreen extends StatefulWidget {
  const PickupDropoffAddressScreen({super.key, required this.moveType});
  final String moveType;

  @override
  State<PickupDropoffAddressScreen> createState() =>
      _PickupDropoffAddressScreenState();
}

class _PickupDropoffAddressScreenState extends State<PickupDropoffAddressScreen> {
  Place? pickupAddress;
  Place? dropoffAddress;
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropoffController = TextEditingController();
  final FocusNode _pickupFocusNode = FocusNode();
  final FocusNode _dropoffFocusNode = FocusNode();

  bool _pickupFocused = false;
  bool _dropoffFocused = false;


  @override
  void initState() {
    super.initState();
    _pickupFocusNode.addListener(() {
      setState(() {
        _pickupFocused = _pickupFocusNode.hasFocus;
       
      });
    });
    _dropoffFocusNode.addListener(() {
      setState(() {
      
        _dropoffFocused = _dropoffFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _pickupFocusNode.dispose();
    _dropoffFocusNode.dispose();
    _pickupController.dispose();
    _dropoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pickup and Dropoff Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Pickup address
            SizedBox(
              height: 70,
              child: Stack(
                children: [
                  placesAutoCompleteTextField(
                    controller: _pickupController,
                    onPlaceSelected: (Place prediction) {
                      setState(() {
                        pickupAddress = prediction;
                      });
                    },
                    hintText: 'Pickup Location',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FaIcon(FontAwesomeIcons.car),
                    ),
                    focusNode: _pickupFocusNode,
                  ),
                ],
              ),
            ),
      
            if (_pickupFocused)
              GestureDetector(
                onTap: () async {
                  try {
                    final Place livePlace = await getLiveLocation();
                    setState(() {
                      pickupAddress = livePlace;
                      _pickupController.text = livePlace.name ?? '';
                    });
                    FocusScope.of(context).unfocus();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not get live location: $e')),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0),
                  child: Container(
                    width: 200, 
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.my_location, color: Colors.black, size: 15),
                        const SizedBox(width: 12),
                        Text(
                          'Your location',
                          style: TextStyle(
                            color: Colors.black,
                             fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // Consistent spacing after pickup "Your location" button
            if (_pickupFocused) const SizedBox(height: 16),
            // Dropoff address
            placesAutoCompleteTextField(
              controller: _dropoffController,
              onPlaceSelected: (Place prediction) {
                setState(() {
                  dropoffAddress = prediction;
                });
              },
              hintText: 'Dropoff Location',
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(FontAwesomeIcons.locationDot),
              ),
              focusNode: _dropoffFocusNode,
            ),
            // Consistent spacing after dropoff field
            if (_dropoffFocused) const SizedBox(height: 12),
            // "Your location" for Dropoff (below the field)
            if (_dropoffFocused)
              GestureDetector(
                onTap: () async {
                  try {
                    final Place livePlace = await getLiveLocation();
                    setState(() {
                      dropoffAddress = livePlace;
                      _dropoffController.text = livePlace.name ?? '';
                    });
                    FocusScope.of(context).unfocus();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not get live location: $e')),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    width: 200, 
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.my_location, color: Colors.black, size: 15),
                        const SizedBox(width: 12),
                        Text(
                          'Your location',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // Consistent spacing after dropoff "Your location" button
            if (_dropoffFocused) const SizedBox(height: 16),
            // Consistent spacing before the proceed button
            const SizedBox(height: 24),
            InkWell(
              onTap: () {
                if (pickupAddress != null && dropoffAddress != null) {
                  _dropoffFocusNode.unfocus();
                  _pickupFocusNode.unfocus();
                  if (widget.moveType == 'refrigeration') {
                    Navigator.of(context).pushNamed(
                      '/event_item_selection',
                      arguments: {
                        'pickupAddress': pickupAddress,
                        'dropoffAddress': dropoffAddress,
                        'jobType': "Events",
                        'moveType': widget.moveType,
                      },
                    );
                  } else {
                    Navigator.of(context).pushNamed(
                      '/service_selection',
                      arguments: {
                        'pickupAddress': pickupAddress,
                        'dropoffAddress': dropoffAddress,
                        'moveType': widget.moveType,
                      },
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select both pickup and dropoff location'),
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField({
    required TextEditingController controller,
    required void Function(Place) onPlaceSelected,
    required String hintText,
    required Widget prefixIcon,
    required FocusNode focusNode,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AddressAutocompleteTextField(
        focusNode: focusNode,
        controller: controller,
        mapsApiKey: kGoogleApiKey,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        debounceTime: 400,
        componentCountry: "uk",
        onSuggestionClick: onPlaceSelected,
        clearButton: const Icon(Icons.clear),
        // REMOVE suggestionBuilder!
      ),
    );
  }

  Future<Place> getLiveLocation() async {
    // Request permission
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw Exception('Location permission denied');
    }
    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // Reverse geocode to get address
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark placeMark = placemarks.first;
    String address = [
      placeMark.name,
      placeMark.street,
      placeMark.locality,
      placeMark.postalCode,
      placeMark.country
    ].where((e) => e != null && e.isNotEmpty).join(', ');

    // Create a Place object (adapt as needed for your Place class)
    return Place(
      name: address, // Use the correct field name from your Place class
      lat: position.latitude,
      lng: position.longitude,
    );
  }
}
