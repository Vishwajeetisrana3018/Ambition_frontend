import 'package:ambition_delivery/domain/entities/repeat_job_entity.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_event.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepeatJobScreen extends StatefulWidget {
  const RepeatJobScreen({super.key});

  @override
  State<RepeatJobScreen> createState() => _RepeatJobScreenState();
}

class _RepeatJobScreenState extends State<RepeatJobScreen> {
  late final RepeatJobBloc _repeatJobBloc;

  @override
  void initState() {
    super.initState();
    _repeatJobBloc = context.read<RepeatJobBloc>();
    _repeatJobBloc.add(GetRepeatJobsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repeat Jobs'),
      ),
      body: BlocBuilder<RepeatJobBloc, RepeatJobState>(
        builder: (context, state) {
          if (state is RepeatJobLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is RepeatJobLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                _repeatJobBloc.add(GetRepeatJobsEvent());
              },
              child: ListView.builder(
                itemCount: state.jobs.length,
                itemBuilder: (context, index) {
                  final repeatJob = state.jobs[index];
                  return RepeatJobCard(
                    repeatJob: repeatJob,
                    onTap: () => _navigateToJobDetails(repeatJob),
                    onDelete: () => _showDeleteConfirmation(repeatJob),
                  );
                },
              ),
            );
          } else if (state is RepeatJobError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return const Center(
              child: Text('No repeat jobs found'),
            );
          }
        },
      ),
    );
  }

  void _navigateToJobDetails(RepeatJobEntity repeatJob) {
    Navigator.of(context).pushNamed(
      repeatJob.isEventJob
          ? '/event_item_selection_repeat'
          : '/item_selection_repeat',
      arguments: repeatJob,
    );
  }

  void _showDeleteConfirmation(RepeatJobEntity repeatJob) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this job?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _repeatJobBloc.add(DeleteRepeatJobEvent(repeatJob.id));
              },
            ),
          ],
        );
      },
    );
  }
}

class RepeatJobCard extends StatelessWidget {
  final RepeatJobEntity repeatJob;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const RepeatJobCard({
    super.key,
    required this.repeatJob,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Request ID: ${repeatJob.id}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Type: ${repeatJob.jobType} (${repeatJob.moveType})'),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(repeatJob.isEventJob ? Icons.event : Icons.work),
                const SizedBox(width: 8),
                Text(repeatJob.isEventJob ? 'Event Job' : 'Regular Job'),
                if (repeatJob.isRideAndMove) ...[
                  const SizedBox(width: 16),
                  const Icon(Icons.directions_car),
                  const SizedBox(width: 8),
                  const Text('Ride & Move'),
                ],
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.people),
                const SizedBox(width: 8),
                Text('Helpers: ${repeatJob.requiredHelpers}'),
                const SizedBox(width: 16),
                const Icon(Icons.local_offer),
                const SizedBox(width: 8),
                Text(
                    'Items: ${repeatJob.items.length + repeatJob.customItems.length}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.stairs),
                const SizedBox(width: 8),
                Text(
                    'Floors: ${repeatJob.pickupFloor} → ${repeatJob.dropoffFloor}'),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Origin:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(repeatJob.originName),
            Text(repeatJob.originAddress),
            const SizedBox(height: 8),
            const Text('Destination:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(repeatJob.destinationName),
            Text(repeatJob.destinationAddress),
            if (repeatJob.specialRequirements.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Special Requirements:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(repeatJob.specialRequirements),
            ],
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: onDelete,
                  child:
                      const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: onTap,
                  child: const Text('Repeat',
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
