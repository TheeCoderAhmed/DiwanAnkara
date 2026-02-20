import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.link,
    required this.date,
    required this.imageUrl,
    this.order,
  });

  final String id;
  final String title;
  final String description;
  final String link;
  final DateTime date;
  final String imageUrl;
  final int? order; // For custom ordering

  factory Announcement.fromJson(Map<String, dynamic> json) {
    String s(String key) => (json[key] as String?) ?? '';

    // Handle date parsing (Timestamp or String)
    DateTime parseDate(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is String && val.isNotEmpty)
        return DateTime.tryParse(val) ?? DateTime.now();
      return DateTime.now();
    }

    return Announcement(
      id: s('id'),
      title: s('title'),
      description: s('description'),
      link: s('link'),
      date: parseDate(json['date']),
      imageUrl: s('imageUrl').isNotEmpty ? s('imageUrl') : s('image_url'),
      order: (json['order'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'link': link,
      'date': date.toIso8601String(),
      'image_url': imageUrl,
      'order': order,
    };
  }
}
