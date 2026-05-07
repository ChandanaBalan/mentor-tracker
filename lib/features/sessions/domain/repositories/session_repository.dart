import '../entities/session_entity.dart';

abstract class SessionRepository {
  Future<List<SessionEntity>> getSessions();
  Future<void> saveSession(SessionEntity session);
  Future<void> deleteSession(String id);
}
