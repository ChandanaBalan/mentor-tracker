import '../../../../core/usecases/usecase.dart';
import '../entities/session_entity.dart';
import '../repositories/session_repository.dart';

class GetSessions implements UseCase<Future<List<SessionEntity>>, NoParams> {
  final SessionRepository repository;

  GetSessions(this.repository);

  @override
  Future<List<SessionEntity>> call(NoParams params) {
    return repository.getSessions();
  }
}
