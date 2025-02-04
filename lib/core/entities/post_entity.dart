
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

class CreatedBy {
  final int id;
  final String fullName;

  CreatedBy({required this.id, required this.fullName});
}

class UserEntity {
  final int id;
  final String fullName;

  UserEntity({required this.id, required this.fullName});
}
