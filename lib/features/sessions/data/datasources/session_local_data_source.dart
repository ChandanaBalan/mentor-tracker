import '../models/session_model.dart';
abstract class SessionLocalDataSource {
  List<SessionModel> getSessions();
  void saveSession(SessionModel session);
  void deleteSession(String id);
}
class SessionLocalDataSourceImpl implements SessionLocalDataSource {
  final List<SessionModel> _sessions = [
    // Initial mock data
    SessionModel(
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
  @override
  List<SessionModel> getSessions() {
    return _sessions;
  }
  @override
  void saveSession(SessionModel session) {
    final index = _sessions.indexWhere((s) => s.id == session.id);
    if (index >= 0) {
      _sessions[index] = session;
    } else {
      _sessions.add(session);
    }
  }
  @override
  void deleteSession(String id) {
    _sessions.removeWhere((s) => s.id == id);
  }
}
