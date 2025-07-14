import 'package:ambition_delivery/domain/entities/instruction_entity.dart';
import 'package:ambition_delivery/domain/repositories/instruction_repository.dart';
import 'package:dartz/dartz.dart';

class GetInstructionsByUserType {
  final InstructionRepository repository;

  GetInstructionsByUserType(this.repository);

  Future<Either<Failure, List<InstructionEntity>>> call(String userType) async {
    return await repository.getInstructionsByUserType(userType);
  }
}
