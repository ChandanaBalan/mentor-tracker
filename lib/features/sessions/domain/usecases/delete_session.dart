import '../../../../core/usecases/usecase.dart';
import '../repositories/session_repository.dart';
class DeleteSession implements UseCase<void, String> {
  final SessionRepository repository;
  DeleteSession(this.repository);
  @override
  void call(String id) {
    repository.deleteSession(id);
  }
}