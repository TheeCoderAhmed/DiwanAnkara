import 'package:shared_preferences/shared_preferences.dart';

/// Service to manage onboarding completion status
class OnboardingService {
  static const String _onboardingKey = 'onboarding_completed';

  final SharedPreferences _prefs;

  OnboardingService(this._prefs);

  /// Check if onboarding has been completed
  bool hasSeenOnboarding() {
    return _prefs.getBool(_onboardingKey) ?? false;
  }

  /// Mark onboarding as completed
  Future<bool> completeOnboarding() async {
    return await _prefs.setBool(_onboardingKey, true);
  }

  /// Reset onboarding status (for testing)
  Future<bool> resetOnboarding() async {
    return await _prefs.remove(_onboardingKey);
  }
}
