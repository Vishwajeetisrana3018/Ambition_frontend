import 'package:equatable/equatable.dart';
import '../../domain/entities/instruction_entity.dart';

class InstructionModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String userType;
  final DateTime createdAt;

  const InstructionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.userType,
    required this.createdAt,
  });

  factory InstructionModel.fromJson(Map<String, dynamic> json) {
    return InstructionModel(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      userType: json['userType'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'userType': userType,
    };
  }

  InstructionEntity toEntity() {
    return InstructionEntity(
      id: id,
      title: title,
      description: description,
      userType: userType,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, description, userType, createdAt];
}
