import 'package:dartz/dartz.dart';
import '../entities/instruction_entity.dart';

abstract class InstructionRepository {
  Future<Either<Failure, List<InstructionEntity>>> getInstructions();
  Future<Either<Failure, List<InstructionEntity>>> getInstructionsByUserType(
      String userType);
  Future<Either<Failure, InstructionEntity>> getInstructionById(String id);
  Future<Either<Failure, InstructionEntity>> createInstruction(
      InstructionEntity instruction);
  Future<Either<Failure, InstructionEntity>> updateInstruction(
      String id, InstructionEntity instruction);
  Future<Either<Failure, void>> deleteInstruction(String id);
}

class Failure {}

class ServerFailure extends Failure {}
