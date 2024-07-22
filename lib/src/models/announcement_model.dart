class Announcement {
  final int id;
  final int userId;
  final String title;
  final String subTitle;
  final bool isRead;
  String? message;
  final String createdAt;
  final String updatedAt;

  Announcement(
      {required this.id,
      required this.userId,
      required this.title,
      required this.subTitle,
      required this.isRead,
      this.message,
      required this.createdAt,
      required this.updatedAt});

  factory Announcement.getAllFromJson(Map<String, dynamic> json) {
    return Announcement(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? 0,
        title: json['title'] ?? "",
        subTitle: json['sub_title'] ?? "",
        isRead: json['is_read'] == 1 ? true : false,
        message: "",
        createdAt: json['created_at'] ?? "",
        updatedAt: json['updated_at'] ?? "");
  }

  factory Announcement.getDetailFromJson(Map<String, dynamic> json) {
    return Announcement(
        id: json['id'] ?? 0,
        userId: json['user_id'] ?? 0,
        title: json['title'] ?? "",
        subTitle: json['sub_title'] ?? "",
        isRead: json['is_read'] == 1 ? true : false,
        message: json['message'] ?? "",
        createdAt: json['created_at'] ?? "",
        updatedAt: json['updated_at'] ?? "");
  }

  @override
  String toString() {
    return 'Announcement{id: $id, userId: $userId, title: $title, subTitle: $subTitle, isRead: $isRead, message: $message, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
