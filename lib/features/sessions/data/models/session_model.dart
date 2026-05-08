import '../../domain/entities/session_entity.dart';

class SessionModel extends SessionEntity {
  SessionModel({
    required super.id,
    required super.mentorName,
    required super.menteeName,
    required super.date,
    required super.sessionNumber,
    required super.topicsDiscussed,
    required super.actionItems,
    required super.mentorComments,
  });

  factory SessionModel.fromEntity(SessionEntity entity) {
    return SessionModel(
      id: entity.id,
      mentorName: entity.mentorName,
      menteeName: entity.menteeName,
      date: entity.date,
      sessionNumber: entity.sessionNumber,
      topicsDiscussed: entity.topicsDiscussed,
      actionItems: entity.actionItems,
      mentorComments: entity.mentorComments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mentor_name': mentorName,
      'mentee_name': menteeName,
      'date': date.toIso8601String(),
      'session_number': sessionNumber,
      'topics_discussed': topicsDiscussed,
      'action_items': actionItems,
      'mentor_comments': mentorComments,
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    final dateRaw = map['date'];
    final date = dateRaw is DateTime
        ? dateRaw
        : DateTime.parse(dateRaw as String);

    return SessionModel(
      id: map['id'] as String,
      mentorName: map['mentor_name'] as String,
      menteeName: map['mentee_name'] as String,
      date: date,
      sessionNumber: (map['session_number'] as num).toInt(),
      topicsDiscussed: map['topics_discussed'] as String? ?? '',
      actionItems: map['action_items'] as String? ?? '',
      mentorComments: map['mentor_comments'] as String? ?? '',
    );
  }
}
