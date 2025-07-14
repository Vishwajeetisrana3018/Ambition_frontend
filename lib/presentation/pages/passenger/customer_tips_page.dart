import 'package:ambition_delivery/presentation/bloc/instruction_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/instruction_event.dart';
import 'package:ambition_delivery/presentation/bloc/instruction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomerTipsPage extends StatefulWidget {
  const CustomerTipsPage({super.key});

  @override
  State<CustomerTipsPage> createState() => _CustomerTipsPageState();
}

class _CustomerTipsPageState extends State<CustomerTipsPage> {
  @override
  void initState() {
    super.initState();
    context
        .read<InstructionBloc>()
        .add(const GetInstructionsByUserTypeEvent('customer'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Guidelines'),
      ),
      body: BlocBuilder<InstructionBloc, InstructionState>(
          builder: (context, state) {
        if (state is InstructionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is InstructionError) {
          return Center(
            child: Text(state.message),
          );
        }
        if (state is InstructionsLoaded) {
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: state.instructions.length,
            itemBuilder: (context, index) {
              final instruction = state.instructions[index];
              return BulletPoint(
                title: instruction.title,
                content: instruction.description,
              );
            },
          );
        } else {
          return const SizedBox();
        }
      }),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String title;
  final String content;

  const BulletPoint({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.only(right: 12.0),
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.blueAccent,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16.0,
                    height: 1.5,
                    color: Colors.grey[800],
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
