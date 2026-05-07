import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/session_repository.dart';
import '../datasources/session_remote_data_source.dart';
import '../models/session_model.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteDataSource remoteDataSource;

  SessionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SessionEntity>> getSessions() async {
    return await remoteDataSource.getSessions();
  }

  @override
  Future<void> saveSession(SessionEntity session) async {
    final model = SessionModel.fromEntity(session);
    await remoteDataSource.saveSession(model);
  }

  @override
  Future<void> deleteSession(String id) async {
    await remoteDataSource.deleteSession(id);
  }
}
