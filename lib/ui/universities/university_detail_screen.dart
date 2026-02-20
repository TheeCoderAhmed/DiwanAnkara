import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

import '../../domain/models/university_model.dart';
import '../../services/translation_service.dart';
import '../shared/cached_image_widget.dart';
import '../widgets/public_review_section.dart';

class UniversityDetailScreen extends ConsumerStatefulWidget {
  final UniversityModel university;

  const UniversityDetailScreen({super.key, required this.university});

  @override
  ConsumerState<UniversityDetailScreen> createState() =>
      _UniversityDetailScreenState();
}

class _UniversityDetailScreenState
    extends ConsumerState<UniversityDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _translatedKnownFor;
  bool _isTranslating = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAndTranslate();
  }

  Future<void> _checkAndTranslate() async {
    final languageCode = Localizations.localeOf(context).languageCode;
    final uni = widget.university;

    if (languageCode != 'ar' &&
        uni.knownFor != null &&
        _translatedKnownFor == null &&
        !_isTranslating) {
      if (mounted) setState(() => _isTranslating = true);

      try {
        final service = TranslationService();
        final text = await service.translate(uni.knownFor!, languageCode);

        if (mounted) {
          setState(() {
            _translatedKnownFor = text;
            _isTranslating = false;
          });
        }
      } catch (e) {
        debugPrint("Error translating knownFor: $e");
        if (mounted) setState(() => _isTranslating = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final uni = widget.university;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildSliverAppBar(context, uni),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuickStats(context, uni),
                  const SizedBox(height: 32),
                  if (uni.knownFor != null) ...[
                    _buildSectionTitle(context, l10n.knownFor),
                    const SizedBox(height: 12),
                    Text(
                      _translatedKnownFor ?? uni.knownFor!,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.grey[300]
                            : Colors.grey[800],
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 32),
                  ],
                  _buildSectionTitle(
                    context,
                    l10n.aboutUs,
                  ), // Generic about label or new key
                  const SizedBox(height: 12),
                  _buildDescription(context, uni),
                  const SizedBox(height: 32),
                  if (uni.usefulLinks != null &&
                      uni.usefulLinks!.isNotEmpty) ...[
                    _buildSectionTitle(context, l10n.studentResources),
                    const SizedBox(height: 12),
                    _buildLinksGrid(context, uni.usefulLinks!),
                    const SizedBox(height: 32),
                  ],
                  if (uni.socialMedia != null &&
                      uni.socialMedia!.isNotEmpty) ...[
                    _buildSectionTitle(context, l10n.socialConnect),
                    const SizedBox(height: 12),
                    _buildSocialBar(context, uni.socialMedia!),
                    const SizedBox(height: 32),
                  ],
                  if (uni.lat != null && uni.lng != null) ...[
                    _buildSectionTitle(context, l10n.location),
                    const SizedBox(height: 12),
                    _buildLocationCard(context, uni),
                    const SizedBox(height: 32),
                  ],
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: PublicReviewSection(
              targetId: uni.id,
              targetType: 'university',
              targetName: uni.name,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, UniversityModel uni) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Campus/Building Image as Background
            Hero(
              tag: 'uni_campus_${uni.id}',
              child: CachedImageWidget(
                imageUrl:
                    uni.campusUrl ??
                    uni.logoUrl, // Fallback to logo if campus photo missing
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
            // Floating Logo Overlay
            Positioned.directional(
              textDirection: Directionality.of(context),
              top: 80,
              end: 20,
              child: Hero(
                tag: 'uni_logo_${uni.id}',
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 10),
                    ],
                  ),
                  child: ClipOval(
                    child: CachedImageWidget(
                      imageUrl: uni.logoUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ).animate().fadeIn(duration: 800.ms).scale(),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Text(
                uni.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black26, blurRadius: 10)],
                ),
              ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: const Color(0xFF0D9488),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, UniversityModel uni) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        if (uni.ranking != null) ...[
          _buildStatCard(
            context,
            icon: LucideIcons.trophy,
            label: l10n.globalRank,
            value: uni.ranking!,
          ),
          const SizedBox(width: 12),
        ],
        if (uni.establishment != null) ...[
          _buildStatCard(
            context,
            icon: LucideIcons.building,
            label: l10n.established,
            value: uni.establishment.toString(),
          ),
          const SizedBox(width: 12),
        ],
        _buildStatCard(
          context,
          icon: LucideIcons.graduationCap,
          label: l10n.degrees,
          value: l10n.bachelorsAndMore,
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF0D9488), size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescription(BuildContext context, UniversityModel uni) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final description =
        (languageCode == 'ar' ? uni.descriptionAr : uni.descriptionTr) ??
        uni.descriptionAr ??
        uni.descriptionTr ??
        l10n.noDescriptionAvailable;

    return Text(
      description,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildLinksGrid(BuildContext context, Map<String, String> links) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.5,
      ),
      itemCount: links.length,
      itemBuilder: (context, index) {
        final key = links.keys.elementAt(index);
        final url = links[key]!;
        return _buildLinkCard(context, key, url);
      },
    );
  }

  Widget _buildLinkCard(BuildContext context, String title, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF0D9488).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF0D9488).withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              LucideIcons.externalLink,
              size: 16,
              color: Color(0xFF0D9488),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialBar(BuildContext context, Map<String, String> social) {
    return Row(
      children: social.entries
          .map(
            (e) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton.filledTonal(
                onPressed: () => _launchURL(e.value),
                icon: Icon(_getSocialIcon(e.key)),
                style: IconButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF0D9488,
                  ).withValues(alpha: 0.1),
                  foregroundColor: const Color(0xFF0D9488),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  IconData _getSocialIcon(String key) {
    switch (key.toLowerCase()) {
      case 'instagram':
        return LucideIcons.instagram;
      case 'facebook':
        return LucideIcons.facebook;
      case 'linkedin':
        return LucideIcons.linkedin;
      case 'twitter':
        return LucideIcons.twitter;
      default:
        return LucideIcons.globe;
    }
  }

  Widget _buildLocationCard(BuildContext context, UniversityModel uni) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(LucideIcons.mapPin, color: Color(0xFF0D9488), size: 32),
          const SizedBox(height: 12),
          Text(
            l10n.openInGoogleMaps,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _launchURL(
              "https://www.google.com/maps/search/?api=1&query=${uni.lat},${uni.lng}",
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D9488),
              foregroundColor: Colors.white,
            ),
            child: Text(l10n.navigateNow),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
