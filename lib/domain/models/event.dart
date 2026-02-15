import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum EventCategory {
  sports,
  culture,
  educational,
  social,
  religious,
  other;

  String get label {
    switch (this) {
      case EventCategory.sports: return 'رياضة';
      case EventCategory.culture: return 'ثقافة وفنون';
      case EventCategory.educational: return 'تعليم';
      case EventCategory.social: return 'اجتماعي';
      case EventCategory.religious: return 'ديني';
      case EventCategory.other: return 'عام';
    }
  }

  IconData get icon {
    switch (this) {
      case EventCategory.sports: return LucideIcons.trophy;
      case EventCategory.culture: return LucideIcons.palette;
      case EventCategory.educational: return LucideIcons.graduationCap;
      case EventCategory.social: return LucideIcons.users;
      case EventCategory.religious: return LucideIcons.moon; // Moon for religious
      case EventCategory.other: return LucideIcons.calendar;
    }
  }

  Color get color {
    switch (this) {
      case EventCategory.sports: return const Color(0xFFF59E0B); // Amber
      case EventCategory.culture: return const Color(0xFF8B5CF6); // Violet
      case EventCategory.educational: return const Color(0xFF3B82F6); // Blue
      case EventCategory.social: return const Color(0xFFEC4899); // Pink
      case EventCategory.religious: return const Color(0xFF10B981); // Emerald
      case EventCategory.other: return const Color(0xFF6B7280); // Gray
    }
  }
}

class AppEvent {
  const AppEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.category,
    required this.imageAsset,
    required this.url,
  });

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final EventCategory category;
  final String imageAsset; // Can be asset path or image_url from Firestore
  final String url; // Google Form URL

  factory AppEvent.fromJson(Map<String, dynamic> json) {
    String s(String key) => (json[key] as String?) ?? '';
    
    // Support both image_asset (legacy) and image_url (Firestore)
    final image = s('image_url').isEmpty ? s('image_asset') : s('image_url');
    
    // Parse Date (Handle Timestamp or String)
    DateTime parseDate(dynamic val) {
      if (val is Timestamp) return val.toDate();
      if (val is String && val.isNotEmpty) return DateTime.tryParse(val) ?? DateTime.now();
      return DateTime.now();
    }

    // Parse Category
    EventCategory parseCategory(String val) {
      try {
        return EventCategory.values.firstWhere((e) => e.name == val);
      } catch (_) {
        return EventCategory.other;
      }
    }

    return AppEvent(
      id: s('id'),
      title: s('title').isEmpty ? 'حدث جديد' : s('title'),
      description: s('description'),
      date: parseDate(json['date']),
      location: s('location').isEmpty ? 'غير محدد' : s('location'),
      category: parseCategory(s('category')),
      imageAsset: image,
      url: s('url'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.toIso8601String(),
      'location': location,
      'category': category.name,
      'image_url': imageAsset,
      'url': url,
    };
  }
}


