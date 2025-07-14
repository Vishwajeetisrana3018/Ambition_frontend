import 'package:ambition_delivery/domain/entities/ambition_service.dart';
import 'package:ambition_delivery/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';

class ServiceSelectionScreen extends StatefulWidget {
  const ServiceSelectionScreen(
      {super.key,
      required this.pickupAddress,
      required this.dropoffAddress,
      required this.moveType});
  final Place pickupAddress;
  final Place dropoffAddress;
  final String moveType;

  @override
  State<ServiceSelectionScreen> createState() => _ServiceSelectionScreenState();
}

class _ServiceSelectionScreenState extends State<ServiceSelectionScreen> {
  AmbitionService? selectedService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Service'),
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double itemWidth = (constraints.maxWidth - 48) / 3;
                final double itemHeight = itemWidth / 1.2;

                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.all(16.0),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildServiceItem(
                              Consts.ambitionServices[index],
                              itemWidth,
                              itemHeight),
                          childCount: 3,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildServiceItem(
                              Consts.ambitionServices[3],
                              constraints.maxWidth - 32,
                              (constraints.maxWidth - 32) / 3.6),
                          childCount: 1,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16.0),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.8,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildServiceItem(
                              Consts.ambitionServices[index + 4],
                              itemWidth,
                              itemHeight),
                          childCount: 3,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2.0,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _buildServiceItem(
                              Consts.ambitionServices[7],
                              constraints.maxWidth - 32,
                              (constraints.maxWidth - 32) / 3.6),
                          childCount: 1,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      if (selectedService != null) {
                        if (selectedService!.isEvent) {
                          Navigator.of(context).pushNamed(
                            '/event_item_selection',
                            arguments: {
                              'pickupAddress': widget.pickupAddress,
                              'dropoffAddress': widget.dropoffAddress,
                              'jobType': selectedService!.title,
                              'moveType': widget.moveType,
                            },
                          );
                        } else {
                          Navigator.of(context).pushNamed(
                            '/item_selection',
                            arguments: {
                              'pickupAddress': widget.pickupAddress,
                              'dropoffAddress': widget.dropoffAddress,
                              'jobType': selectedService!.title,
                              'moveType': widget.moveType,
                            },
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a service'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm ${selectedService != null ? selectedService!.title : ""}',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(
      AmbitionService service, double width, double height) {
    final isSelected = selectedService == service;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedService = service;
        });
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              service.icon,
              size: 40,
              color: isSelected ? Colors.white : Colors.blue,
            ),
            const SizedBox(height: 8),
            Text(
              service.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
