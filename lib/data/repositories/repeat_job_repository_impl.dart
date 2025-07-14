import 'dart:developer';

import 'package:ambition_delivery/data/datasources/remote_data_source.dart';
import 'package:ambition_delivery/data/models/repeat_job_model.dart';
import 'package:ambition_delivery/domain/entities/repeat_job_entity.dart';
import 'package:ambition_delivery/domain/repositories/repeat_job_repository.dart';

class RepeatJobRepositoryImpl implements RepeatJobRepository {
  final RemoteDataSource remoteDataSource;

  RepeatJobRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> createRepeatJob(Map<String, dynamic> repeatJob) async {
    final resp = await remoteDataSource.createRepeatJob(repeatJob);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      throw Exception('Failed to create repeat job');
    }
  }

  @override
  Future<void> deleteRepeatJob(String id) async {
    final resp = await remoteDataSource.deleteRepeatJob(id);
    if (resp.statusCode != 200) {
      throw Exception('Failed to delete repeat job');
    }
  }

  @override
  Future<List<RepeatJobEntity>> getRepeatJobs(String userId) async {
    try {
      final resp = await remoteDataSource.getRepeatJobs(userId);
      if (resp.statusCode != 200) {
        throw Exception('Failed to get repeat jobs');
      }
      final List<dynamic> data = resp.data['data'];
      return data.map((e) => RepeatJobModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to get repeat jobs: $e');
    }
  }
}
