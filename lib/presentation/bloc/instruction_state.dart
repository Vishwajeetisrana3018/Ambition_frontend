import 'package:ambition_delivery/domain/entities/instruction_entity.dart';
import 'package:equatable/equatable.dart';

abstract class InstructionState extends Equatable {
  const InstructionState();

  @override
  List<Object> get props => [];
}

class InstructionInitial extends InstructionState {}

class InstructionLoading extends InstructionState {}

class InstructionsLoaded extends InstructionState {
  final List<InstructionEntity> instructions;

  const InstructionsLoaded(this.instructions);

  @override
  List<Object> get props => [instructions];
}

class InstructionError extends InstructionState {
  final String message;

  const InstructionError(this.message);

  @override
  List<Object> get props => [message];
}
