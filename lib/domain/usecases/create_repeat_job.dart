import 'package:ambition_delivery/domain/repositories/repeat_job_repository.dart';

class CreateRepeatJob {
  final RepeatJobRepository repeatJobRepository;

  CreateRepeatJob(this.repeatJobRepository);

  Future<void> call(Map<String, dynamic> repeatJob) async {
    return await repeatJobRepository.createRepeatJob(repeatJob);
  }
}
