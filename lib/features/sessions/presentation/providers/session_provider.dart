import 'package:flutter/material.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/usecases/get_sessions.dart';
import '../../domain/usecases/save_session.dart';
import '../../domain/usecases/delete_session.dart';
enum UserRole { mentor, mentee }
class SessionProvider with ChangeNotifier {
  final GetSessions getSessionsUseCase;
  final SaveSession saveSessionUseCase;
  final DeleteSession deleteSessionUseCase;
  SessionProvider({
    required this.getSessionsUseCase,
    required this.saveSessionUseCase,
    required this.deleteSessionUseCase,
  }) {
    _loadSessions();
  }
  UserRole _currentRole = UserRole.mentee;
  List<SessionEntity> _sessions = [];
  UserRole get currentRole => _currentRole;
  List<SessionEntity> get sessions => _sessions;
  void _loadSessions() {
    _sessions = getSessionsUseCase(NoParams());
    notifyListeners();
  }
  void toggleRole() {
    _currentRole = _currentRole == UserRole.mentor ? UserRole.mentee : UserRole.mentor;
    notifyListeners();
  }
  void saveSession(SessionEntity session) {
    saveSessionUseCase(session);
    _loadSessions();
  }
  void deleteSession(String id) {
    deleteSessionUseCase(id);
    _loadSessions();
  }
}