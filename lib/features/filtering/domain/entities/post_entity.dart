// my app only care about this model , this is what will be shown in the UI
class PostEntity {
  final int id;
  final String title;
  final String content;
  final CreatedBy createdBy;
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
