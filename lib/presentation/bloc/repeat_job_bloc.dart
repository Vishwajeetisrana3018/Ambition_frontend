import 'package:ambition_delivery/domain/usecases/create_repeat_job.dart';
import 'package:ambition_delivery/domain/usecases/delete_repeat_job.dart';
import 'package:ambition_delivery/domain/usecases/get_local_user.dart';
import 'package:ambition_delivery/domain/usecases/get_repeat_jobs.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_event.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RepeatJobBloc extends Bloc<RepeatJobEvent, RepeatJobState> {
  final CreateRepeatJob createRepeatJob;
  final DeleteRepeatJob deleteRepeatJob;
  final GetRepeatJobs getRepeatJobs;
  final GetLocalUser getLocalUser;

  RepeatJobBloc({
    required this.createRepeatJob,
    required this.deleteRepeatJob,
    required this.getRepeatJobs,
    required this.getLocalUser,
  }) : super(RepeatJobInitial()) {
    on<GetRepeatJobsEvent>(_onGetRepeatJobsEvent);

    on<CreateRepeatJobEvent>(_onCreateRepeatJobEvent);

    on<DeleteRepeatJobEvent>(_onDeleteRepeatJobEvent);
  }

  void _onGetRepeatJobsEvent(
    GetRepeatJobsEvent event,
    Emitter<RepeatJobState> emit,
  ) async {
    try {
      emit(RepeatJobLoading());
      final localUser = getLocalUser();
      final repeatJobs = await getRepeatJobs(localUser!['id']);
      emit(RepeatJobLoaded(repeatJobs));
    } on DioException catch (e) {
      if (e.response != null) {
        emit(RepeatJobError(e.response!.data.toString()));
      } else {
        emit(RepeatJobError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(RepeatJobError(e.toString()));
    }
  }

  void _onCreateRepeatJobEvent(
    CreateRepeatJobEvent event,
    Emitter<RepeatJobState> emit,
  ) async {
    try {
      emit(RepeatJobLoading());
      final localUser = getLocalUser();
      event.repeatJob['userId'] = localUser!['id'];
      await createRepeatJob(event.repeatJob);
      emit(RepeatJobCreated());
    } on DioException catch (e) {
      if (e.response != null) {
        emit(RepeatJobError(e.response!.data.toString()));
      } else {
        emit(RepeatJobError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(RepeatJobError(e.toString()));
    }
  }

  void _onDeleteRepeatJobEvent(
    DeleteRepeatJobEvent event,
    Emitter<RepeatJobState> emit,
  ) async {
    try {
      emit(RepeatJobLoading());
      await deleteRepeatJob(event.id);
      emit(RepeatJobDeleted());
    } on DioException catch (e) {
      if (e.response != null) {
        emit(RepeatJobError(e.response!.data.toString()));
      } else {
        emit(RepeatJobError(e.message ?? 'An error occurred'));
      }
    } catch (e) {
      emit(RepeatJobError(e.toString()));
    }
  }
}
