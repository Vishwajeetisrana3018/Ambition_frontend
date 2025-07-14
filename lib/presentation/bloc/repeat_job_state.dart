import 'package:ambition_delivery/domain/entities/repeat_job_entity.dart';

abstract class RepeatJobState {}

class RepeatJobInitial extends RepeatJobState {}

class RepeatJobLoading extends RepeatJobState {}

class RepeatJobLoaded extends RepeatJobState {
  final List<RepeatJobEntity> jobs;

  RepeatJobLoaded(this.jobs);
}

class RepeatJobCreated extends RepeatJobState {}

class RepeatJobDeleted extends RepeatJobState {}

class RepeatJobError extends RepeatJobState {
  final String message;

  RepeatJobError(this.message);
}
