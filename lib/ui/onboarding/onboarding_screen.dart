import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../routing/app_router.dart';
import '../../services/onboarding_service.dart';
import '../../settings/theme_controller.dart';
import '../../settings/locale_controller.dart';
import '../../l10n/app_localizations.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingSlide> _getSlides(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      OnboardingSlide(
        icon: LucideIcons.languages,
        title: l10n.onboardingLanguageTitle,
        description: l10n.onboardingLanguageDesc,
        color: const Color(0xFF06B6D4),
        isLanguageSelector: true,
      ),
      OnboardingSlide(
        icon: LucideIcons.palette,
        title: l10n.onboardingThemeTitle,
        description: l10n.onboardingThemeDesc,
        color: const Color(0xFFF59E0B),
        isThemeSelector: true,
      ),
      OnboardingSlide(
        icon: LucideIcons.brush,
        title: 'اختر مظهرك المفضل',
        description:
            'خصص تجربة استخدام التطبيق بأحد الأنماط الفريدة التي صممناها لك.',
        color: const Color(0xFF8B5CF6),
        isStyleSelector: true,
      ),
      OnboardingSlide(
        icon: LucideIcons.mapPin,
        title: l10n.onboarding1Title,
        description: l10n.onboarding1Desc,
        color: const Color(0xFF0D9488),
      ),
      OnboardingSlide(
        icon: LucideIcons.search,
        title: l10n.onboarding2Title,
        description: l10n.onboarding2Desc,
        color: const Color(0xFF8B5CF6),
      ),
      OnboardingSlide(
        icon: LucideIcons.bell,
        title: l10n.onboarding3Title,
        description: l10n.onboarding3Desc,
        color: const Color(0xFFEF4444),
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = ref.read(sharedPrefsProvider);
    final service = OnboardingService(prefs);
    await service.completeOnboarding();

    if (mounted) {
      context.go(const HomeScreenRoute().location);
    }
  }

  @override
  Widget build(BuildContext context) {
    final slides = _getSlides(context);
    final l10n = AppLocalizations.of(context);

    final currentColor = slides[_currentPage].color;

    return Scaffold(
      // 1.2 – Full-bleed animated gradient background per slide
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.4,
            colors: [currentColor.withValues(alpha: 0.08), Colors.transparent],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 1.3 – RTL-aware skip button alignment
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: Text(l10n.onboardingSkip),
                ),
              ),
              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return _buildSlide(slides[index]);
                  },
                ),
              ),
              // 1.4 – Animated progress dots
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(slides.length, (index) {
                    final isActive = _currentPage == index;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                ),
              ),
              // Next/Get Started button
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      if (_currentPage < slides.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      } else {
                        _completeOnboarding();
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      _currentPage < slides.length - 1
                          ? l10n.onboardingNext
                          : l10n.onboardingStart,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide(OnboardingSlide slide) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1.1 – Pulsing icon with TweenAnimationBuilder
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 1.0, end: 1.08),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOut,
            builder: (context, scale, child) =>
                Transform.scale(scale: scale, child: child),
            onEnd: () => setState(() {}), // retrigger for loop
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: slide.color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: slide.color.withValues(alpha: 0.25),
                    blurRadius: 32,
                    spreadRadius: 4,
                  ),
                ],
              ),
              child: Icon(slide.icon, size: 80, color: slide.color),
            ),
          ),
          const SizedBox(height: 48),
          Text(
            slide.title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            slide.description,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          if (slide.isLanguageSelector) ...[
            const SizedBox(height: 48),
            _buildLanguageOption('ar', 'العربية', '🇸🇦'),
            const SizedBox(height: 12),
            _buildLanguageOption('en', 'English', '🇺🇸'),
            const SizedBox(height: 12),
            _buildLanguageOption('tr', 'Türkçe', '🇹🇷'),
          ],
          if (slide.isThemeSelector) ...[
            const SizedBox(height: 48),
            _buildThemeOption(
              ThemeMode.system,
              AppLocalizations.of(context).themeSystem,
              Icons.brightness_auto,
            ),
            const SizedBox(height: 12),
            _buildThemeOption(
              ThemeMode.light,
              AppLocalizations.of(context).themeLight,
              Icons.light_mode,
            ),
            const SizedBox(height: 12),
            _buildThemeOption(
              ThemeMode.dark,
              AppLocalizations.of(context).themeDark,
              Icons.dark_mode,
            ),
          ],
          if (slide.isStyleSelector) ...[
            const SizedBox(height: 32),
            _buildStyleOption(
              AppStyle.classic,
              'النمط الكلاسيكي',
              'عصري وحيوي',
              LucideIcons.appWindow,
            ),
            const SizedBox(height: 12),
            _buildStyleOption(
              AppStyle.paper,
              'الورق والحبر',
              'أنيق وخالد',
              LucideIcons.pencil,
            ),
            const SizedBox(height: 12),
            _buildStyleOption(
              AppStyle.nordic,
              'اللمسة الشمالية',
              'تقني ونظيف',
              LucideIcons.snowflake,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStyleOption(
    AppStyle style,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final themeState = ref.watch(themeControllerProvider);
    final isSelected = themeState.style == style;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          ref.read(themeControllerProvider.notifier).setStyle(style);
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          side: BorderSide(
            color: isSelected
                ? const Color(0xFF0D9488)
                : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isSelected
              ? const Color(0xFF0D9488).withValues(alpha: 0.05)
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF0D9488).withValues(alpha: 0.1)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? const Color(0xFF0D9488) : Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? const Color(0xFF0D9488) : null,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF0D9488)),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String code, String name, String flag) {
    final currentLocale = ref.watch(localeControllerProvider);
    final isSelected = currentLocale?.languageCode == code;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          ref.read(localeControllerProvider.notifier).setLocale(Locale(code));
          // Provide subtle haptic feedback or just move to next page
          Future.delayed(const Duration(milliseconds: 300), () {
            if (_currentPage == 0 && mounted) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          });
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          side: BorderSide(
            color: isSelected
                ? const Color(0xFF0D9488)
                : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isSelected
              ? const Color(0xFF0D9488).withValues(alpha: 0.05)
              : null,
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF0D9488) : null,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF0D9488)),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(ThemeMode mode, String name, IconData icon) {
    final themeState = ref.watch(themeControllerProvider);
    final isSelected = themeState.mode == mode;

    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {
          ref.read(themeControllerProvider.notifier).setThemeMode(mode);
          // Provide subtle haptic feedback or just move to next page
          Future.delayed(const Duration(milliseconds: 300), () {
            if (_currentPage == 1 && mounted) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          });
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          side: BorderSide(
            color: isSelected
                ? const Color(0xFF0D9488)
                : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isSelected
              ? const Color(0xFF0D9488).withValues(alpha: 0.05)
              : null,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF0D9488) : Colors.grey,
            ),
            const SizedBox(width: 16),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? const Color(0xFF0D9488) : null,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFF0D9488)),
          ],
        ),
      ),
    );
  }
}

class OnboardingSlide {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isLanguageSelector;
  final bool isThemeSelector;
  final bool isStyleSelector;

  const OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.isLanguageSelector = false,
    this.isThemeSelector = false,
    this.isStyleSelector = false,
  });
}
