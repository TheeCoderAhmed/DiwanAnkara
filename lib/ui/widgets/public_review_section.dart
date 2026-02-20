import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/firestore/firestore_providers.dart';
import '../../domain/models/comment.dart';
import '../../services/translation_service.dart';

class PublicReviewSection extends ConsumerStatefulWidget {
  const PublicReviewSection({
    super.key,
    required this.targetId,
    required this.targetType,
    required this.targetName,
  });

  final String targetId;
  final String targetType; // 'university', 'hospital', 'mall', etc.
  final String targetName; // For display in empty state

  @override
  ConsumerState<PublicReviewSection> createState() =>
      _PublicReviewSectionState();
}

class _PublicReviewSectionState extends ConsumerState<PublicReviewSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];
  int _rating = 0;
  bool _isSubmitting = false;
  bool _showForm = false;

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submitReview() async {
    if (!_formKey.currentState!.validate()) return;

    if (_rating == 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'الرجاء تقييم التجربة أولاً',
            style: TextStyle(fontSize: 14),
          ),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Rate limiting check
    final prefs = await SharedPreferences.getInstance();
    final lastCommentTime = prefs.getString('last_comment_time');

    if (lastCommentTime != null) {
      final lastTime = DateTime.parse(lastCommentTime);
      final now = DateTime.now();
      final difference = now.difference(lastTime);

      if (difference.inHours < 1) {
        final remainingMinutes = 60 - difference.inMinutes;

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.timer_outlined, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'يرجى الانتظار $remainingMinutes دقيقة قبل إرسال تعليق آخر',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.orange,
            duration: const Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
    }

    setState(() => _isSubmitting = true);

    try {
      final List<String> uploadedUrls = [];
      if (_selectedImages.isNotEmpty) {
        final storageRef = FirebaseStorage.instance.ref();
        for (var i = 0; i < _selectedImages.length; i++) {
          final file = _selectedImages[i];
          final uuid = const Uuid().v4();
          final ext = file.path.split('.').last;
          final filename = 'reviews/${widget.targetId}/$uuid.$ext';
          final ref = storageRef.child(filename);

          await ref.putFile(File(file.path));
          final url = await ref.getDownloadURL();
          uploadedUrls.add(url);
        }
      }

      final submitComment = ref.read(submitCommentProvider);
      final success = await submitComment(
        announcementId: widget.targetId,
        userName: _nameController.text.trim(),
        commentText: _commentController.text.trim(),
        targetType: widget.targetType,
        imageUrls: uploadedUrls,
        rating: _rating.toDouble(),
      );

      if (!mounted) return;

      if (success) {
        await prefs.setString(
          'last_comment_time',
          DateTime.now().toIso8601String(),
        );

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'تم إرسال تقييمك بنجاح! سيتم نشره بعد المراجعة.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            backgroundColor: Color(0xFF0D9488),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );

        // Clear form and hide it
        _nameController.clear();
        _commentController.clear();
        _rating = 0;
        _selectedImages.clear();
        _formKey.currentState!.reset();
        setState(() => _showForm = false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'حدث خطأ. يرجى المحاولة مرة أخرى.',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewsAsync = ref.watch(publicReviewsProvider(widget.targetId));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0D9488).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.star_rounded,
                      color: Color(0xFF0D9488),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'التقييمات',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'شارك تجربتك مع الآخرين',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ],
          ),
        ),

        // Reviews List
        reviewsAsync.when(
          data: (reviews) {
            if (reviews.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 32,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.rate_review_outlined,
                        size: 64,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'لا توجد تقييمات بعد',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'كن أول من يشارك تجربته!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: reviews.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _ReviewBubble(review: review, isDark: isDark);
              },
            );
          },
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, _) => Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'خطأ في تحميل التقييمات',
              style: TextStyle(color: Colors.red.shade700),
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Add Review Button / Form
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _showForm
              ? _buildReviewForm(isDark)
              : OutlinedButton.icon(
                  onPressed: () => setState(() => _showForm = true),
                  icon: const Icon(Icons.add_comment),
                  label: const Text('إضافة تقييم'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildReviewForm(bool isDark) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Rating Stars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return IconButton(
                onPressed: () => setState(() => _rating = index + 1),
                icon: Icon(
                  index < _rating
                      ? Icons.star_rounded
                      : Icons.star_outline_rounded,
                  color: const Color(0xFF0D9488),
                  size: 32,
                ),
              );
            }),
          ),
          const SizedBox(height: 16),

          // Name Field
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'الاسم',
              hintText: 'أدخل اسمك',
              prefixIcon: const Icon(Icons.person),
              filled: true,
              fillColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0D9488),
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء إدخال الاسم';
              }
              if (value.trim().length < 2 || value.trim().length > 50) {
                return 'الاسم يجب أن يكون بين 2-50 حرفاً';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Review Field
          TextFormField(
            controller: _commentController,
            maxLines: 4,
            maxLength: 500,
            decoration: InputDecoration(
              labelText: 'التقييم',
              hintText: 'اكتب تقييمك هنا...',
              alignLabelWithHint: true,
              filled: true,
              fillColor: isDark
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.grey.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0D9488),
                  width: 2,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'الرجاء إدخال التقييم';
              }
              if (value.trim().length < 10) {
                return 'التقييم يجب أن يكون على الأقل 10 أحرف';
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

          // Images Overview
          if (_selectedImages.isNotEmpty)
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_selectedImages[index].path),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 12,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImages.removeAt(index);
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

          if (_selectedImages.length < 3) ...[
            if (_selectedImages.isNotEmpty) const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () async {
                final List<XFile> images = await _picker.pickMultiImage(
                  imageQuality: 70,
                );
                if (images.isNotEmpty) {
                  setState(() {
                    _selectedImages.addAll(images);
                    if (_selectedImages.length > 3) {
                      _selectedImages = _selectedImages.sublist(0, 3);
                    }
                  });
                }
              },
              icon: const Icon(Icons.add_photo_alternate_outlined),
              label: const Text('إضافة صور (الحد الأقصى 3)'),
              style: TextButton.styleFrom(alignment: Alignment.centerRight),
            ),
          ],

          const SizedBox(height: 16),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _nameController.clear();
                    _commentController.clear();
                    _formKey.currentState?.reset();
                    setState(() => _showForm = false);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('إلغاء'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _submitReview,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF0D9488),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          'إرسال التقييم',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewBubble extends StatefulWidget {
  const _ReviewBubble({required this.review, required this.isDark});

  final Comment review;
  final bool isDark;

  @override
  State<_ReviewBubble> createState() => _ReviewBubbleState();
}

class _ReviewBubbleState extends State<_ReviewBubble> {
  String? _translatedText;
  bool _isTranslating = false;

  Future<void> _translateComment() async {
    if (_translatedText != null) return;

    setState(() => _isTranslating = true);

    try {
      final service = TranslationService();
      final targetLang = Localizations.localeOf(context).languageCode;

      // Attempt to translate. Assuming source is auto-detected or defaults to 'ar'
      // if not specified. Ideally we'd detect language, but for now we rely on
      // the service's robust handling (it defaults source to 'ar').
      final result = await service.translate(
        widget.review.commentText,
        targetLang,
        // We don't specify source to let it default to 'ar' or use detection logic if added.
        // If the comment is already in target language, result should be same.
      );

      if (mounted) {
        setState(() {
          _translatedText = result;
          _isTranslating = false;
        });
      }
    } catch (e) {
      debugPrint('Error translating comment: $e');
      if (mounted) {
        setState(() => _isTranslating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: widget.isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.grey.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Name and Date
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF0D9488).withValues(alpha: 0.2),
                child: Text(
                  widget.review.userName.isNotEmpty
                      ? widget.review.userName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    color: Color(0xFF0D9488),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.review.userName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      DateFormat(
                        'dd/MM/yyyy',
                        'ar',
                      ).format(widget.review.timestamp),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    if (widget.review.rating > 0)
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < widget.review.rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: const Color(0xFF0D9488),
                            size: 14,
                          );
                        }),
                      ),
                  ],
                ),
              ),
              // Translate Button
              IconButton(
                icon: _isTranslating
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        Icons.translate,
                        size: 20,
                        color: _translatedText != null
                            ? const Color(0xFF0D9488)
                            : Colors.grey.shade400,
                      ),
                tooltip: 'Translate',
                onPressed: _isTranslating ? null : _translateComment,
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.verified,
                size: 20,
                color: const Color(0xFF0D9488).withValues(alpha: 0.7),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Review Text
          Text(
            _translatedText ?? widget.review.commentText,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: widget.isDark
                  ? Colors.white.withValues(alpha: 0.9)
                  : Colors.black87,
            ),
          ),

          if (_translatedText != null) ...[
            const SizedBox(height: 4),
            Text(
              '(Translated by Google)',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],

          if (widget.review.imageUrls.isNotEmpty) ...[
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.review.imageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.zero,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                InteractiveViewer(
                                  child: CachedNetworkImage(
                                    imageUrl: widget.review.imageUrls[index],
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                                Positioned(
                                  top: 40,
                                  left: 20,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          imageUrl: widget.review.imageUrls[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: widget.isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade200,
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: widget.isDark
                                ? Colors.grey.shade800
                                : Colors.grey.shade200,
                            child: const Icon(
                              Icons.broken_image,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
