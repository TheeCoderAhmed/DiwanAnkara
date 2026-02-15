import 'package:flutter/material.dart';
import 'package:yc_ankara_app/l10n/app_localizations.dart';

enum PlaceCategory {
  university,
  hospital,
  mall,
  historic,
  library,
  transport,
  govOffice,
  parks,
  housing,
  partners,
  about,  // Who We Are (من نحن)
  project, // Our Projects
  other, // Fallback for unknown categories
}

extension PlaceCategoryX on PlaceCategory {
  String get jsonValue => switch (this) {
        PlaceCategory.university => 'university',
        PlaceCategory.hospital => 'hospital',
        PlaceCategory.mall => 'mall',
        PlaceCategory.historic => 'historic',
        PlaceCategory.library => 'library',
        PlaceCategory.transport => 'transport',
        PlaceCategory.govOffice => 'gov_office',
        PlaceCategory.parks => 'parks',
        PlaceCategory.housing => 'housing',
        PlaceCategory.partners => 'partners',
        PlaceCategory.about => 'about',
        PlaceCategory.project => 'project',
        PlaceCategory.other => 'other',
      };

  String getLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (this) {
      PlaceCategory.university => l10n.catUniversity,
      PlaceCategory.hospital => l10n.catHospital,
      PlaceCategory.mall => l10n.catMall,
      PlaceCategory.historic => l10n.catHistoric,
      PlaceCategory.library => l10n.catLibrary,
      PlaceCategory.transport => l10n.catTransport,
      PlaceCategory.govOffice => l10n.catGovOffice,
      PlaceCategory.parks => l10n.catParks,
      PlaceCategory.housing => l10n.catHousing,
      PlaceCategory.partners => l10n.catPartners,
      PlaceCategory.about => l10n.catAbout,
      PlaceCategory.project => l10n.catProject,
      PlaceCategory.other => '',
    };
  }

  String get arabicLabel => switch (this) {
        PlaceCategory.university => 'الجامعات',
        PlaceCategory.hospital => 'المستشفيات',
        PlaceCategory.mall => 'المولات',
        PlaceCategory.historic => 'المعالم',
        PlaceCategory.library => 'المكتبات',
        PlaceCategory.transport => 'المواصلات',
        PlaceCategory.govOffice => 'الدوائر الحكومية',
        PlaceCategory.parks => 'الحدائق',
        PlaceCategory.housing => 'دليل السكنات',
        PlaceCategory.partners => 'شركاء النجاح',
        PlaceCategory.about => 'من نحن',
        PlaceCategory.project => 'مشاريعنا',
        PlaceCategory.other => '',
      };

  /// Maps raw category strings (including Arabic) to PlaceCategory enum.
  /// Returns [PlaceCategory.other] as fallback to prevent crashes.
  static PlaceCategory fromJsonValue(String v) {
    // First, try English enum values
    final englishMatch = switch (v.toLowerCase()) {
      'university' => PlaceCategory.university,
      'hospital' => PlaceCategory.hospital,
      'mall' => PlaceCategory.mall,
      'historic' => PlaceCategory.historic,
      'library' => PlaceCategory.library,
      'transport' => PlaceCategory.transport,
      'gov_office' => PlaceCategory.govOffice,
      'parks' => PlaceCategory.parks,
      'housing' => PlaceCategory.housing,
      'partners' => PlaceCategory.partners,
      'about' => PlaceCategory.about,
      'project' => PlaceCategory.project,
      'other' => PlaceCategory.other,
      _ => null,
    };
    if (englishMatch != null) return englishMatch;

    // Arabic category mapping - must match Firebase data EXACTLY
    // These strings MUST match the folder names used in the Python upload script
    final trimmed = v.trim();
    
    final result = switch (trimmed) {
      // --- ANKARA PLACES (From Python Script Folder Names) ---
      
      // Malls - PRIMARY mapping is from Python script folder name
      'مراكز التسوق' => PlaceCategory.mall,  // matches Python script
      'المولات' => PlaceCategory.mall,        // alias for UI compatibility
      
      // Hospitals
      'المستشفيات' => PlaceCategory.hospital,  // matches Python script
      
      // Historic places
      'مناطق تاريخية' => PlaceCategory.historic,  // matches Python script
      'المعالم' => PlaceCategory.historic,         // alias
      
      // Parks - Check both variants
      'الحدائق' => PlaceCategory.parks,  // with definite article
      'حدائق' => PlaceCategory.parks,    // without definite article
      
      // Government Offices
      'المعاملات الحكومية' => PlaceCategory.govOffice,  // matches Python script
      'الدوائر الحكومية' => PlaceCategory.govOffice,    // alias
      
      // Libraries
      'المكتبات' => PlaceCategory.library,  // matches Python script
      
      // Hotels
      'الفنادق' => PlaceCategory.other,  // matches Python script (no hotel enum yet)
      
      // --- OTHER SECTIONS ---
      
      // Housing Guide
      'دليل السكنات' => PlaceCategory.housing,  // matches Python script
      'السكنات' => PlaceCategory.housing,       // alias
      
      // Blog
      'المدونة' => PlaceCategory.other,  // matches Python script
      // Note: Transport might be inside Blog. Check if you need to map it differently.
      
      // Partners/Homepage
      'الرئيسية' => PlaceCategory.partners,      // matches Python script
      'شركاء النجاح' => PlaceCategory.partners,  // alias
      
      // Universities
      'الجامعات' => PlaceCategory.university,
      
      // Transportation
      'المواصلات' => PlaceCategory.transport,
      
      // Projects
      'مشاريعنا' => PlaceCategory.project,  // matches Python script
      
      // About Us / Who We Are
      'من نحن' => PlaceCategory.about,  // matches Python script
      
      // Student Residency
      'الاقامة الطلابية' => PlaceCategory.housing,  // Student residency guide
      
      // Ankara Places parent folder
      'أماكن أنقرة' => PlaceCategory.other,
      
      // Unknown → safe fallback
      _ => PlaceCategory.other,
    };
    
    // Debug print for unmapped categories (excluding known 'other' categories)
    if (result == PlaceCategory.other && trimmed.isNotEmpty && 
        trimmed != 'المدونة' && trimmed != 'أماكن أنقرة' && 
        trimmed != 'الفنادق' && trimmed != 'مشاريعنا') {
      debugPrint('⚠️ Unmapped Category in DB: "$trimmed"');
    }
    
    return result;
  }
}

enum GuideCategory {
  residency,
}

extension GuideCategoryX on GuideCategory {
  String get jsonValue => switch (this) {
        GuideCategory.residency => 'residency',
      };
}


