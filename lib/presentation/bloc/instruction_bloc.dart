import 'package:ambition_delivery/domain/usecases/get_instructions_by_user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'instruction_event.dart';
import 'instruction_state.dart';

class InstructionBloc extends Bloc<InstructionEvent, InstructionState> {
  final GetInstructionsByUserType getInstructionsByUserType;

  InstructionBloc({
    required this.getInstructionsByUserType,
  }) : super(InstructionInitial()) {
    on<GetInstructionsByUserTypeEvent>(_onGetInstructionsByUserType);
  }

  void _onGetInstructionsByUserType(GetInstructionsByUserTypeEvent event,
      Emitter<InstructionState> emit) async {
    emit(InstructionLoading());
    final result = await getInstructionsByUserType(event.userType);
    result.fold(
      (failure) => emit(
          const InstructionError('Failed to load instructions by user type')),
      (instructions) => emit(InstructionsLoaded(instructions)),
    );
  }
}
