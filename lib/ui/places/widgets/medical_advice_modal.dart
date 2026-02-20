import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';
import '../../../services/translation_service.dart';

class MedicalAdviceModal extends StatefulWidget {
  const MedicalAdviceModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const MedicalAdviceModal(),
    );
  }

  @override
  State<MedicalAdviceModal> createState() => _MedicalAdviceModalState();
}

class _MedicalAdviceModalState extends State<MedicalAdviceModal> {
  // Translation state for Turkish support
  Map<String, String>? _translatedContent;
  bool _isTranslating = false;

  // English content keys for translation mapping
  static const String keyBooking = 'booking';
  static const String keyLanguage = 'language';
  static const String keyInsurance = 'insurance';
  static const String keyDocuments = 'documents';

  final Map<String, String> _englishContent = {
    keyBooking:
        "Public & University: Use MHRS app or call 182. For Hacettepe, use My Hacettepe portal.\nPrivate: Direct booking via website or WhatsApp.",
    keyLanguage:
        "Public: Translators recommended. Private/University: Look for the 'International Patient Office'.",
    keyInsurance:
        "SGK: Available after 1 year residency. Private Insurance: Essential for visas. Emergencies: Free at public hospitals.",
    keyDocuments:
        "1. Passport or Residence ID.\n2. Insurance documents.\n3. Past medical records.",
  };

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAndTranslate();
  }

  Future<void> _checkAndTranslate() async {
    final locale = Localizations.localeOf(context).languageCode;

    // If Turkish and not yet translated
    if (locale == 'tr' && _translatedContent == null && !_isTranslating) {
      setState(() {
        _isTranslating = true;
      });

      final service = TranslationService();
      try {
        final keys = [keyBooking, keyLanguage, keyInsurance, keyDocuments];
        final textsToTranslate = keys.map((k) => _englishContent[k]!).toList();

        // Use batch translation optimization
        final results = await service.translateList(
          textsToTranslate,
          'tr',
          sourceLanguageCode: 'en',
        );

        if (mounted) {
          final Map<String, String> resultMap = {};
          for (int i = 0; i < keys.length; i++) {
            resultMap[keys[i]] = results[i];
          }

          setState(() {
            _translatedContent = resultMap;
            _isTranslating = false;
          });
        }
      } catch (e) {
        debugPrint("Error translating medical advice: $e");
        if (mounted) {
          setState(() => _isTranslating = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isArabic = locale == 'ar';
    final isTurkish = locale == 'tr';

    // Helper to get text based on locale
    String getText(String arText, String enKey) {
      if (isArabic) return arText;
      if (isTurkish &&
          _translatedContent != null &&
          _translatedContent!.containsKey(enKey)) {
        return _translatedContent![enKey]!;
      }
      return _englishContent[enKey]!;
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(75),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
              children: [
                Row(
                  children: [
                    Icon(
                      LucideIcons.info,
                      color: Theme.of(context).primaryColor,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.hospitalAdvices,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                if (_isTranslating)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: LinearProgressIndicator(),
                  ),

                _buildAdviceItem(
                  context,
                  LucideIcons.mousePointer2,
                  l10n.bookingMethod,
                  getText(
                    "الدولة والجامعة (MHRS/182): استخدم تطبيق MHRS أو اتصل بـ 182. بالنسبة لمستشفى حاجيت تبه، استخدم بوابة My Hacettepe.\nالخاص: الحجز المباشر عبر الموقع أو واتساب.",
                    keyBooking,
                  ),
                ),
                _buildAdviceItem(
                  context,
                  LucideIcons.languages,
                  l10n.languageTip,
                  getText(
                    "المستشفيات العامة: يفضل اصطحاب مترجم. المستشفيات الخاصة والجامعية: ابحث عن 'International Desk' (مكتب المرضى الدوليين).",
                    keyLanguage,
                  ),
                ),
                _buildAdviceItem(
                  context,
                  LucideIcons.shieldCheck,
                  l10n.insuranceInfo,
                  getText(
                    "SGK: متاح بعد سنة من الإقامة. التأمين الخاص: ضروري للفيزا ويغطي المستشفيات الخاصة. الطوارئ: مجانية في المستشفيات الحكومية.",
                    keyInsurance,
                  ),
                ),
                _buildAdviceItem(
                  context,
                  LucideIcons.briefcase,
                  l10n.whatToBring,
                  getText(
                    "1. جواز السفر أو الإقامة.\n2. وثائق التأمين.\n3. السجلات الطبية السابقة.",
                    keyDocuments,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdviceItem(
    BuildContext context,
    IconData icon,
    String title,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: Theme.of(context).primaryColor),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: Text(
              content,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
