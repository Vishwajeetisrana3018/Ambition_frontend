import 'package:ambition_delivery/domain/entities/repeat_job_entity.dart';

abstract class RepeatJobRepository {
  Future<List<RepeatJobEntity>> getRepeatJobs(String userId);
  Future<void> createRepeatJob(Map<String, dynamic> repeatJob);
  Future<void> deleteRepeatJob(String id);
}
