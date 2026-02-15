import 'package:flutter/foundation.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationService {
  static final TranslationService _instance = TranslationService._internal();

  factory TranslationService() => _instance;

  TranslationService._internal();

  final _modelManager = OnDeviceTranslatorModelManager();

  TranslateLanguage? _getLanguage(String languageCode) {
    switch (languageCode) {
      case 'en':
        return TranslateLanguage.english;
      case 'tr':
        return TranslateLanguage.turkish;
      case 'ar':
        return TranslateLanguage.arabic;
      default:
        return null;
    }
  }

  /// Downloads the translation model for the given language code.
  /// Returns true if successful, false otherwise.
  Future<bool> downloadModel(String languageCode) async {
    final lang = _getLanguage(languageCode);
    if (lang == null) return false;

    if (await _modelManager.isModelDownloaded(lang.bcpCode)) {
      debugPrint('Model for $languageCode is already downloaded.');
      return true;
    }

    debugPrint('Downloading model for $languageCode...');
    final bool success = await _modelManager.downloadModel(lang.bcpCode);
    if (success) {
      debugPrint('Successfully downloaded model for $languageCode');
    } else {
      debugPrint('Failed to download model for $languageCode');
    }
    return success;
  }

  /// Translates text from Arabic to the target language code.
  /// If the target language is Arabic or not supported, returns the original text.
  Future<String> translate(String text, String targetLanguageCode) async {
    final targetLang = _getLanguage(targetLanguageCode);
    
    // Assuming source is Arabic for app content
    const sourceLang = TranslateLanguage.arabic;

    if (targetLang == null || targetLang == sourceLang) {
      return text;
    }

    // Ensure models are available before translating
    bool sourceReady = await _modelManager.isModelDownloaded(sourceLang.bcpCode);
    bool targetReady = await _modelManager.isModelDownloaded(targetLang.bcpCode);

    if (!sourceReady || !targetReady) {
        debugPrint('Models not ready. Source: $sourceReady, Target: $targetReady');
        // Optionally trigger download here, or rely on pre-download
        return text; 
    }

    final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: sourceLang,
      targetLanguage: targetLang,
    );

    try {
      final String response = await onDeviceTranslator.translateText(text);
      return response;
    } catch (e) {
      debugPrint('Translation Error: $e');
      return text;
    } finally {
      await onDeviceTranslator.close();
    }
  }
}
