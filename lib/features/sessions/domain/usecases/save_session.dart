import '../../../../core/usecases/usecase.dart';
import '../entities/session_entity.dart';
import '../repositories/session_repository.dart';

class SaveSession implements UseCase<Future<void>, SessionEntity> {
  final SessionRepository repository;

  SaveSession(this.repository);

  @override
  Future<void> call(SessionEntity session) {
    return repository.saveSession(session);
  }
}
