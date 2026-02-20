import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../data/firestore/firestore_providers.dart';

class VersionGuard extends ConsumerStatefulWidget {
  const VersionGuard({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<VersionGuard> createState() => _VersionGuardState();
}

class _VersionGuardState extends ConsumerState<VersionGuard> {
  int? _currentBuildNumber;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          _currentBuildNumber = int.tryParse(info.buildNumber) ?? 0;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _currentBuildNumber = 999999; // Fallback to avoid blocking if error
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_currentBuildNumber == null) {
      // Waiting for package info
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final appSettingsAsync = ref.watch(appSettingsProvider);
    
    return appSettingsAsync.when(
      data: (settings) {
        if (_currentBuildNumber! < settings.minAppVersion) {
          return const _ForceUpdateScreen();
        }
        return widget.child;
      },
      loading: () => Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => widget.child, // On error, allow app to proceed
    );
  }
}

class _ForceUpdateScreen extends StatelessWidget {
  const _ForceUpdateScreen();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D9488).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.system_update_rounded, 
                  size: 80, 
                  color: Color(0xFF0D9488)
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'تحديث مهم مطلوب',
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'نسخة التطبيق الحالية قديمة جداً ولا تدعم الميزات الجديدة. يرجى تحديث التطبيق من المتجر للاستمرار في الاستخدام.',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
