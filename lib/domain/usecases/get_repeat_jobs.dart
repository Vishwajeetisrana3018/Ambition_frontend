import 'package:ambition_delivery/domain/entities/repeat_job_entity.dart';
import 'package:ambition_delivery/domain/repositories/repeat_job_repository.dart';

class GetRepeatJobs {
  final RepeatJobRepository jobRepository;

  GetRepeatJobs(this.jobRepository);

  Future<List<RepeatJobEntity>> call(String userId) async {
    return await jobRepository.getRepeatJobs(userId);
  }
}
