import 'package:equatable/equatable.dart';

class InstructionEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String userType;
  final DateTime createdAt;

  const InstructionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.userType,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, title, description, userType, createdAt];
}
