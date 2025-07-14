import 'package:equatable/equatable.dart';

abstract class InstructionEvent extends Equatable {
  const InstructionEvent();

  @override
  List<Object> get props => [];
}

class GetInstructionsByUserTypeEvent extends InstructionEvent {
  final String userType;

  const GetInstructionsByUserTypeEvent(this.userType);

  @override
  List<Object> get props => [userType];
}
