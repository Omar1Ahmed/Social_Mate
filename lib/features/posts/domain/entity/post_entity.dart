class PostEntity {
  final int id;
  final String title;
  final String content;
  final UserEntity createdBy;
  final DateTime createdOn;

  PostEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.createdBy,
    required this.createdOn,
  });
}

// domain/entities/user_entity.dart
class UserEntity {
  final int id;
  final String fullName;

  UserEntity({required this.id, required this.fullName});
}