abstract class RepeatJobEvent {}

class GetRepeatJobsEvent extends RepeatJobEvent {}

class CreateRepeatJobEvent extends RepeatJobEvent {
  final Map<String, dynamic> repeatJob;

  CreateRepeatJobEvent(this.repeatJob);
}

class DeleteRepeatJobEvent extends RepeatJobEvent {
  final String id;

  DeleteRepeatJobEvent(this.id);
}
