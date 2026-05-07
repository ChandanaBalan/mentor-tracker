import 'package:flutter/material.dart';
import '../models/session.dart';

enum UserRole { mentor, mentee }

class SessionProvider with ChangeNotifier {
  UserRole _currentRole = UserRole.mentee;

  final List<Session> _sessions = [
    // Initial mock data
    Session(
      id: '1',
      mentorName: 'Alice Johnson',
      menteeName: 'Bob Smith',
      date: DateTime.now().subtract(const Duration(days: 7)),
      sessionNumber: 1,
      topicsDiscussed: 'Introductions, goal setting, and expectations.',
      actionItems: 'Bob to write down 3 short-term goals.',
      mentorComments: 'Bob seems very motivated. We will focus on project management skills first.',
    ),
  ];

  UserRole get currentRole => _currentRole;
  List<Session> get sessions => _sessions;

  void toggleRole() {
    _currentRole = _currentRole == UserRole.mentor ? UserRole.mentee : UserRole.mentor;
    notifyListeners();
  }

  void addSession(Session session) {
    _sessions.add(session);
    notifyListeners();
  }

  void updateSession(Session updatedSession) {
    final index = _sessions.indexWhere((s) => s.id == updatedSession.id);
    if (index >= 0) {
      _sessions[index] = updatedSession;
      notifyListeners();
    }
  }

  void deleteSession(String id) {
    _sessions.removeWhere((s) => s.id == id);
    notifyListeners();
  }
}
