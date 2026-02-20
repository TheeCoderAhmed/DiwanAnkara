class AppSettings {
  final String iban;
  final String? supportDesc;
  final String safetyEmail;
  final int minAppVersion;
  final String emergencyBannerText;
  final bool emergencyBannerVisible;
  final bool enableComments;
  final bool enableIkametTracker;
  final bool enableAnnouncements;
  final bool enablePopularPlaces;
  final bool enableEvents;
  final bool enableCurrencyConverter;
  final bool enableStudentHacks;
  final bool enableProjects;
  final bool enablePartners;
  final Map<String, double> currencyFallbackRates;
  final String residencyGuideUrl;

  AppSettings({
    required this.iban,
    this.supportDesc,
    required this.safetyEmail,
    required this.minAppVersion,
    required this.emergencyBannerText,
    required this.emergencyBannerVisible,
    required this.enableComments,
    required this.enableIkametTracker,
    required this.enableAnnouncements,
    required this.enablePopularPlaces,
    required this.enableEvents,
    required this.enableCurrencyConverter,
    required this.enableStudentHacks,
    required this.enableProjects,
    required this.enablePartners,
    required this.currencyFallbackRates,
    required this.residencyGuideUrl,
  });

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    Map<String, double> parsedRates = {};
    if (json['currencyFallbackRates'] != null) {
      final Map<String, dynamic> rawRates = json['currencyFallbackRates'] as Map<String, dynamic>;
      rawRates.forEach((key, value) {
        if (value is num) {
          parsedRates[key] = value.toDouble();
        }
      });
    }

    if (parsedRates.isEmpty) {
      parsedRates = {
        'USD': 0.037,
        'EUR': 0.034,
        'TRY': 1.0,
        'SAR': 0.139,
        'YER': 9.27,
        'AED': 0.136,
        'KWD': 0.011,
        'QAR': 0.135,
        'GBP': 0.029,
        'EGP': 2.30,
      };
    }

    return AppSettings(
      iban: json['iban'] as String? ?? 'TR330006100519786457841326',
      supportDesc: json['supportDesc'] as String?,
      safetyEmail: json['safetyEmail'] as String? ?? 'ahm3dbusinesss@gmail.com',
      minAppVersion: json['minAppVersion'] as int? ?? 1,
      emergencyBannerText: json['emergencyBannerText'] as String? ?? '',
      emergencyBannerVisible: json['emergencyBannerVisible'] as bool? ?? false,
      enableComments: json['enableComments'] as bool? ?? true,
      enableIkametTracker: json['enableIkametTracker'] as bool? ?? true,
      enableAnnouncements: json['enableAnnouncements'] as bool? ?? true,
      enablePopularPlaces: json['enablePopularPlaces'] as bool? ?? true,
      enableEvents: json['enableEvents'] as bool? ?? true,
      enableCurrencyConverter: json['enableCurrencyConverter'] as bool? ?? true,
      enableStudentHacks: json['enableStudentHacks'] as bool? ?? true,
      enableProjects: json['enableProjects'] as bool? ?? true,
      enablePartners: json['enablePartners'] as bool? ?? true,
      currencyFallbackRates: parsedRates,
      residencyGuideUrl: json['residencyGuideUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iban': iban,
      'supportDesc': supportDesc,
      'safetyEmail': safetyEmail,
      'minAppVersion': minAppVersion,
      'emergencyBannerText': emergencyBannerText,
      'emergencyBannerVisible': emergencyBannerVisible,
      'enableComments': enableComments,
      'enableIkametTracker': enableIkametTracker,
      'enableAnnouncements': enableAnnouncements,
      'enablePopularPlaces': enablePopularPlaces,
      'enableEvents': enableEvents,
      'enableCurrencyConverter': enableCurrencyConverter,
      'enableStudentHacks': enableStudentHacks,
      'enableProjects': enableProjects,
      'enablePartners': enablePartners,
      'currencyFallbackRates': currencyFallbackRates,
      'residencyGuideUrl': residencyGuideUrl,
    };
  }
}
