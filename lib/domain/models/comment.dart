import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  const Comment({
    required this.id,
    required this.announcementId,
    required this.userName,
    required this.commentText,
    required this.timestamp,
    required this.status,
    required this.targetType,
    required this.targetName,
    this.imageUrls = const [],
    this.rating = 0.0,
    this.userId,
  });

  final String id;
  final String
  announcementId; // This will be targetId (can be announcement, university, hospital, etc.)
  final String userName;
  final String commentText;
  final DateTime timestamp;
  final String status; // "pending" or "approved"
  final String
  targetType; // "announcement", "university", "hospital", "mall", etc.
  final String
  targetName; // Display name: "Atilim University", "ANKAmall", etc.
  final List<String> imageUrls;
  final double rating;
  final String? userId;

  factory Comment.fromJson(Map<String, dynamic> json) {
    String s(String key) => (json[key] as String?) ?? '';

    // Handle timestamp parsing
    DateTime parseTimestamp(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is String && val.isNotEmpty) {
        return DateTime.tryParse(val) ?? DateTime.now();
      }
      return DateTime.now();
    }

    return Comment(
      id: s('id'),
      announcementId: s('announcementId'),
      userName: s('userName'),
      commentText: s('commentText'),
      timestamp: parseTimestamp(json['timestamp']),
      status: s('status').isEmpty ? 'pending' : s('status'),
      targetType: s('targetType').isEmpty ? 'announcement' : s('targetType'),
      targetName: s('targetName'),
      imageUrls:
          (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'announcementId': announcementId,
    'userName': userName,
    'commentText': commentText,
    'timestamp': Timestamp.fromDate(timestamp),
    'status': status,
    'targetType': targetType,
    'targetName': targetName,
    'imageUrls': imageUrls,
    'rating': rating,
    'userId': userId,
  };
}
