import '../../../../core/usecases/usecase.dart';
import '../entities/session_entity.dart';
import '../repositories/session_repository.dart';
class SaveSession implements UseCase<void, SessionEntity> {
  final SessionRepository repository;
  SaveSession(this.repository);
  @override
  void call(SessionEntity session) {
    repository.saveSession(session);
  }
}
