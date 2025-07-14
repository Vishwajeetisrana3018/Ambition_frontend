import 'package:ambition_delivery/data/datasources/remote_data_source.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/instruction_entity.dart';
import '../../domain/repositories/instruction_repository.dart';
import '../models/instruction_model.dart';

class InstructionRepositoryImpl implements InstructionRepository {
  final RemoteDataSource remoteDataSource;

  InstructionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<InstructionEntity>>> getInstructions() async {
    try {
      final remoteInstructions = await remoteDataSource.getInstructions();
      return Right(
          remoteInstructions.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, InstructionEntity>> createInstruction(
      InstructionEntity instruction) async {
    try {
      final remoteInstruction = await remoteDataSource.createInstruction(
        InstructionModel(
          id: '',
          title: instruction.title,
          description: instruction.description,
          userType: instruction.userType,
          createdAt: DateTime.now(),
        ),
      );
      return Right(remoteInstruction.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, InstructionEntity>> updateInstruction(
      String id, InstructionEntity instruction) async {
    try {
      final remoteInstruction = await remoteDataSource.updateInstruction(
        id,
        InstructionModel(
          id: id,
          title: instruction.title,
          description: instruction.description,
          userType: instruction.userType,
          createdAt: instruction.createdAt,
        ),
      );
      return Right(remoteInstruction.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteInstruction(String id) async {
    try {
      await remoteDataSource.deleteInstruction(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, InstructionEntity>> getInstructionById(
      String id) async {
    try {
      final remoteInstruction = await remoteDataSource.getInstruction(id);
      return Right(remoteInstruction.toEntity());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<InstructionEntity>>> getInstructionsByUserType(
      String userType) async {
    try {
      if (userType == 'all') {
        final remoteInstructions = await remoteDataSource.getInstructions();
        return Right(
            remoteInstructions.map((model) => model.toEntity()).toList());
      } else {
        final remoteInstructions =
            await remoteDataSource.getInstructionsByUserType(userType);
        return Right(
            remoteInstructions.map((model) => model.toEntity()).toList());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
