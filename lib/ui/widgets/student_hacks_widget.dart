import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/cached_image_widget.dart';

class StudentHacksWidget extends StatelessWidget {
  const StudentHacksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBBF24).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  LucideIcons.lightbulb,
                  color: Color(0xFFFBBF24),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'مصادر مفيدة للطلاب',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('student_tips')
                .orderBy('order')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Icon(Icons.error));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final docs = snapshot.data?.docs ?? [];
              if (docs.isEmpty) {
                return const SizedBox();
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data() as Map<String, dynamic>;
                  final hack = _StudentHack.fromMap(data);
                  
                  return Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: index > 0 ? 16 : 0,
                    ),
                    child: _HackCard(hack: hack),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _StudentHack {
  const _StudentHack({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.url,
    this.backgroundImage,
  });

  factory _StudentHack.fromMap(Map<String, dynamic> map) {
    final theme = map['theme'] as String? ?? 'general';
    final (icon, gradient) = _getThemeStyles(theme);

    return _StudentHack(
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      url: map['url'] as String? ?? '',
      icon: icon,
      gradient: gradient,
      backgroundImage: map['background_image'] as String?,
    );
  }

  static (IconData, List<Color>) _getThemeStyles(String theme) {
    switch (theme) {
      case 'museum':
        return (
          LucideIcons.ticket,
          [const Color(0xFF0D9488), const Color(0xFF14B8A6)]
        );
      case 'cinema':
        return (
          LucideIcons.film,
          [const Color(0xFFEF4444), const Color(0xFFF87171)]
        );
      case 'help':
        return (
          LucideIcons.phone,
          [const Color(0xFF8B5CF6), const Color(0xFFA78BFA)]
        );
      case 'transport':
        return (
          LucideIcons.bus,
          [const Color(0xFFF59E0B), const Color(0xFFFBBF24)]
        );
      case 'general':
      default:
        return (
          LucideIcons.lightbulb,
          [const Color(0xFF3B82F6), const Color(0xFF60A5FA)]
        );
    }
  }

  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;
  final String url;
  final String? backgroundImage;
}

class _HackCard extends StatelessWidget {
  const _HackCard({required this.hack});

  final _StudentHack hack;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () async {
        if (hack.url.isEmpty) return;
        final uri = Uri.parse(hack.url);
        try {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('خطأ في فتح الرابط: $e')),
            );
          }
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 300,
          height: 180,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Gradient & Border
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isDark
                        ? [
                            hack.gradient[0].withValues(alpha: 0.3),
                            hack.gradient[1].withValues(alpha: 0.2),
                          ]
                        : [
                            hack.gradient[0].withValues(alpha: 0.8),
                            hack.gradient[1].withValues(alpha: 0.6),
                          ],
                  ),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : hack.gradient[0].withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
              ),

              // Optional Background Image
              if (hack.backgroundImage != null && hack.backgroundImage!.isNotEmpty)
                CachedImageWidget(
                  imageUrl: hack.backgroundImage!,
                  fit: BoxFit.cover,
                  width: 300,
                  height: 180,
                ),

              // Overlay for readability if image exists
              if (hack.backgroundImage != null && hack.backgroundImage!.isNotEmpty)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        hack.icon,
                        color: isDark ? Colors.white : hack.gradient[0],
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      hack.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Text(
                        hack.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? Colors.white70
                              : Colors.white.withValues(alpha: 0.9),
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0),
    );
  }
}
