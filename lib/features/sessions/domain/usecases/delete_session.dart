import '../../../../core/usecases/usecase.dart';
import '../repositories/session_repository.dart';

class DeleteSession implements UseCase<Future<void>, String> {
  final SessionRepository repository;

  DeleteSession(this.repository);

  @override
  Future<void> call(String id) {
    return repository.deleteSession(id);
  }
}
