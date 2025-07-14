import 'package:ambition_delivery/presentation/bloc/ride_request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key, required this.rideRequest});
  final Map<String, dynamic> rideRequest;

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  late RideRequestBloc _rideRequestBloc;
  @override
  void initState() {
    _rideRequestBloc = BlocProvider.of<RideRequestBloc>(context);
    _rideRequestBloc.add(
      CreateRideRequestEvent(
        rideRequest: widget.rideRequest,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Request'),
      ),
      body: BlocConsumer<RideRequestBloc, RideRequestState>(
        listener: (context, state) {
          if (state is RideRequestError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          } else if (state is RideRequestCreated) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Future.delayed(const Duration(seconds: 2), () async {
                if (context.mounted) {
                  // Wait for the navigation pop to complete
                  await Future.microtask(() {
                    if (!context.mounted) return;
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  });

                  // Now safely add the event after popup is dismissed
                  _rideRequestBloc.add(GetOngoingRideRequestByUserIdEvent());
                }
              });
            });
          }
        },
        builder: (context, state) {
          if (state is RideRequestLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RideRequestCreated) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ride request created successfully',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('An error occurred'),
            );
          }
        },
      ),
    );
  }
}
