class SessionEntity {
  final String id;
  final String mentorName;
  final String menteeName;
  final DateTime date;
  final int sessionNumber;
  final String topicsDiscussed;
  final String actionItems;
  final String mentorComments;
  SessionEntity({
    required this.id,
    required this.mentorName,
    required this.menteeName,
    required this.date,
    required this.sessionNumber,
    required this.topicsDiscussed,
    required this.actionItems,
    required this.mentorComments,
  });
}