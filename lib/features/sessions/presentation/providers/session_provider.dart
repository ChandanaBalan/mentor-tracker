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

  bool _isLoading = false;
  String? _errorMessage;

  UserRole get currentRole => _currentRole;
  List<SessionEntity> get sessions => _sessions;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> _loadSessions() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      _sessions = await getSessionsUseCase(NoParams());
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleRole() {
    _currentRole = _currentRole == UserRole.mentor ? UserRole.mentee : UserRole.mentor;
    notifyListeners();
  }

  Future<void> saveSession(SessionEntity session) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await saveSessionUseCase(session);
      await _loadSessions();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteSession(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      await deleteSessionUseCase(id);
      await _loadSessions();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
