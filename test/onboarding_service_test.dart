import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yc_ankara_app/services/onboarding_service.dart';

void main() {
  group('OnboardingService', () {
    late OnboardingService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();
      service = OnboardingService(prefs);
    });

    test('returns false when onboarding not completed', () {
      expect(service.hasSeenOnboarding(), isFalse);
    });

    test('marks onboarding as completed', () async {
      await service.completeOnboarding();
      expect(service.hasSeenOnboarding(), isTrue);
    });

    test('resets onboarding status', () async {
      await service.completeOnboarding();
      expect(service.hasSeenOnboarding(), isTrue);

      await service.resetOnboarding();
      expect(service.hasSeenOnboarding(), isFalse);
    });

    test('persists completion across service instances', () async {
      await service.completeOnboarding();

      // Simulate app restart - create new service instance with same prefs
      final prefs = await SharedPreferences.getInstance();
      final newService = OnboardingService(prefs);

      expect(newService.hasSeenOnboarding(), isTrue);
    });
  });
}
