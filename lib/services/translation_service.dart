import 'package:flutter/foundation.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationService {
  static final TranslationService _instance = TranslationService._internal();

  factory TranslationService() {
    return _instance;
  }

  TranslationService._internal();

  final _modelManager = OnDeviceTranslatorModelManager();

  /// Downloads the translation model for the given language code.
  /// Returns true if successful or already downloaded.
  Future<bool> downloadModel(String languageCode) async {
    try {
      final language = _getTranslateLanguage(languageCode);
      if (language == null) {
        debugPrint(
          'TranslationService: Unsupported language code: $languageCode',
        );
        return false;
      }

      final isDownloaded = await _modelManager.isModelDownloaded(
        language.bcpCode,
      );
      if (isDownloaded) {
        return true;
      }

      debugPrint('TranslationService: Downloading model for $languageCode...');
      final bool success = await _modelManager.downloadModel(language.bcpCode);
      debugPrint(
        'TranslationService: Download for $languageCode ${success ? 'completed' : 'failed'}',
      );
      return success;
    } catch (e) {
      debugPrint(
        'TranslationService: Error downloading model for $languageCode: $e',
      );
      return false;
    }
  }

  /// Translates [text] to [targetLanguageCode].
  /// [sourceLanguageCode] is optional. If not provided, it defaults to Arabic.
  Future<String> translate(
    String text,
    String targetLanguageCode, {
    String? sourceLanguageCode,
  }) async {
    if (text.isEmpty) return text;

    try {
      final targetLang = _getTranslateLanguage(targetLanguageCode);
      final sourceLang = sourceLanguageCode != null
          ? _getTranslateLanguage(sourceLanguageCode)
          : TranslateLanguage.arabic;

      if (targetLang == null) {
        debugPrint(
          'TranslationService: Unsupported target language: $targetLanguageCode',
        );
        return text;
      }

      if (sourceLang == null) {
        debugPrint(
          'TranslationService: Unsupported source language: $sourceLanguageCode',
        );
        return text;
      }

      if (targetLang == sourceLang) {
        return text;
      }

      // Check if models are available, if not, try to download them quietly
      final sourceAvailable = await _modelManager.isModelDownloaded(
        sourceLang.bcpCode,
      );
      if (!sourceAvailable) {
        debugPrint(
          'TranslationService: Source model (${sourceLang.bcpCode}) not found, attempting download...',
        );
        await _modelManager.downloadModel(sourceLang.bcpCode);
      }

      final targetAvailable = await _modelManager.isModelDownloaded(
        targetLang.bcpCode,
      );
      if (!targetAvailable) {
        debugPrint(
          'TranslationService: Target model (${targetLang.bcpCode}) not found, attempting download...',
        );
        await _modelManager.downloadModel(targetLang.bcpCode);
      }

      final translator = OnDeviceTranslator(
        sourceLanguage: sourceLang,
        targetLanguage: targetLang,
      );

      final String translation = await translator.translateText(text);
      await translator.close();
      return translation;
    } catch (e) {
      debugPrint('TranslationService: Error translating text: $e');
      return text;
    }
  }

  /// Translates a list of strings to [targetLanguageCode].
  /// Reduces overhead by reusing the translator instance.
  /// [sourceLanguageCode] defaults to Arabic if null.
  Future<List<String>> translateList(
    List<String> texts,
    String targetLanguageCode, {
    String? sourceLanguageCode,
  }) async {
    if (texts.isEmpty) return texts;

    try {
      final targetLang = _getTranslateLanguage(targetLanguageCode);
      final sourceLang = sourceLanguageCode != null
          ? _getTranslateLanguage(sourceLanguageCode)
          : TranslateLanguage.arabic;

      if (targetLang == null ||
          sourceLang == null ||
          targetLang == sourceLang) {
        return texts;
      }

      // Ensure models are downloaded
      if (!await _modelManager.isModelDownloaded(sourceLang.bcpCode)) {
        await _modelManager.downloadModel(sourceLang.bcpCode);
      }
      if (!await _modelManager.isModelDownloaded(targetLang.bcpCode)) {
        await _modelManager.downloadModel(targetLang.bcpCode);
      }

      final translator = OnDeviceTranslator(
        sourceLanguage: sourceLang,
        targetLanguage: targetLang,
      );

      final List<String> translatedTexts = [];
      for (final text in texts) {
        if (text.isEmpty) {
          translatedTexts.add(text);
        } else {
          translatedTexts.add(await translator.translateText(text));
        }
      }

      await translator.close();
      return translatedTexts;
    } catch (e) {
      debugPrint('TranslationService: Error translating list: $e');
      return texts;
    }
  }

  /// Helper to map string code to [TranslateLanguage].
  TranslateLanguage? _getTranslateLanguage(String languageCode) {
    try {
      // Handle common codes logic
      switch (languageCode) {
        case 'ar':
          return TranslateLanguage.arabic;
        case 'en':
          return TranslateLanguage.english;
        case 'tr':
          return TranslateLanguage.turkish;
        default:
          // Try to find by BCP code matching
          return TranslateLanguage.values.firstWhere(
            (element) => element.bcpCode == languageCode,
          );
      }
    } catch (e) {
      return null;
    }
  }

  /// Deletes a model to free up space
  Future<bool> deleteModel(String languageCode) async {
    final language = _getTranslateLanguage(languageCode);
    if (language == null) return false;
    return await _modelManager.deleteModel(language.bcpCode);
  }
}
