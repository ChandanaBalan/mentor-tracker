import '../entities/session_entity.dart';
abstract class SessionRepository {
  List<SessionEntity> getSessions();
  void saveSession(SessionEntity session);
  void deleteSession(String id);
}