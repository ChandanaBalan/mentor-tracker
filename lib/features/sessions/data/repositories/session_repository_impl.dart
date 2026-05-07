import '../../domain/entities/session_entity.dart';
import '../../domain/repositories/session_repository.dart';
import '../datasources/session_local_data_source.dart';
import '../models/session_model.dart';
class SessionRepositoryImpl implements SessionRepository {
  final SessionLocalDataSource localDataSource;
  SessionRepositoryImpl({required this.localDataSource});
  @override
  List<SessionEntity> getSessions() {
    return localDataSource.getSessions();
  }
  @override
  void saveSession(SessionEntity session) {
    final model = SessionModel.fromEntity(session);
    localDataSource.saveSession(model);
  }
  @override
  void deleteSession(String id) {
    localDataSource.deleteSession(id);
  }
}