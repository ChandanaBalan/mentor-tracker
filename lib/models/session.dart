class Session {
  String id;
  String mentorName;
  String menteeName;
  DateTime date;
  int sessionNumber;
  String topicsDiscussed;
  String actionItems;
  String mentorComments;

  Session({
    required this.id,
    required this.mentorName,
    required this.menteeName,
    required this.date,
    required this.sessionNumber,
    required this.topicsDiscussed,
    required this.actionItems,
    required this.mentorComments,
  });

  Session copyWith({
    String? id,
    String? mentorName,
    String? menteeName,
    DateTime? date,
    int? sessionNumber,
    String? topicsDiscussed,
    String? actionItems,
    String? mentorComments,
  }) {
    return Session(
      id: id ?? this.id,
      mentorName: mentorName ?? this.mentorName,
      menteeName: menteeName ?? this.menteeName,
      date: date ?? this.date,
      sessionNumber: sessionNumber ?? this.sessionNumber,
      topicsDiscussed: topicsDiscussed ?? this.topicsDiscussed,
      actionItems: actionItems ?? this.actionItems,
      mentorComments: mentorComments ?? this.mentorComments,
    );
  }
}
