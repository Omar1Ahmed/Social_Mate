class PostEntity {
  final int id;
  final String title;
  final String content;
  final String createdOn;
  final String createdBy;
  final int userId;

  const PostEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.content,
    required this.createdOn,
    required this.createdBy,
  });
}
