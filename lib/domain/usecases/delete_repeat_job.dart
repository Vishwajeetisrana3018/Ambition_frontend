import 'package:ambition_delivery/domain/repositories/repeat_job_repository.dart';

class DeleteRepeatJob {
  final RepeatJobRepository repeatJobRepository;

  DeleteRepeatJob(this.repeatJobRepository);

  Future<void> call(String id) async {
    return await repeatJobRepository.deleteRepeatJob(id);
  }
}
