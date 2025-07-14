import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';

const kGoogleApiKey = 'AIzaSyDbLG11NC8jAUTJRYBX6Pq3C0EYZrRnON0';

class PickupDropoffAddressScreen extends StatefulWidget {
  const PickupDropoffAddressScreen({super.key, required this.moveType});
  final String moveType;

  @override
  State<PickupDropoffAddressScreen> createState() =>
      _PickupDropoffAddressScreenState();
}

class _PickupDropoffAddressScreenState
    extends State<PickupDropoffAddressScreen> {
  Place? pickupAddress;

  Place? dropoffAddress;

  final TextEditingController _pickupController = TextEditingController();

  final TextEditingController _dropoffController = TextEditingController();

  final FocusNode _pickupFocusNode = FocusNode();

  final FocusNode _dropoffFocusNode = FocusNode();

  // @override
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
          children: <Widget>[
            //Pickup address
            placesAutoCompleteTextField(
              controller: _pickupController,
              onPlaceSelected: (Place prediction) {
                pickupAddress = prediction;
              },
              hintText: 'Pickup Location',
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(FontAwesomeIcons.car),
              ),
              focusNode: _pickupFocusNode,
            ),
            const SizedBox(height: 16),
            //Dropoff address
            placesAutoCompleteTextField(
              controller: _dropoffController,
              onPlaceSelected: (Place prediction) {
                dropoffAddress = prediction;
              },
              hintText: 'Dropoff Location',
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8.0),
                child: FaIcon(FontAwesomeIcons.locationDot),
              ),
              focusNode: _dropoffFocusNode,
            ),
            //Proceed button
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                if (pickupAddress != null && dropoffAddress != null) {
                  //hide the keyboard
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
                      content: Text(
                          'Please select both pickup and dropoff location'),
                    ),
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
      ),
    );
  }
}
