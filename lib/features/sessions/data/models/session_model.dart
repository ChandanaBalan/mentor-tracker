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
}