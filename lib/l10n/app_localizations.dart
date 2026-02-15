import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'مجتمع الطلاب اليمنيين - أنقرة'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get home;

  /// No description provided for @more.
  ///
  /// In ar, this message translates to:
  /// **'المزيد'**
  String get more;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In ar, this message translates to:
  /// **'داكن'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In ar, this message translates to:
  /// **'فاتح'**
  String get light;

  /// No description provided for @system.
  ///
  /// In ar, this message translates to:
  /// **'تلقائي'**
  String get system;

  /// No description provided for @hello.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً بك'**
  String get hello;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن إعلانات، فعاليات...'**
  String get searchHint;

  /// No description provided for @searchResults.
  ///
  /// In ar, this message translates to:
  /// **'نتائج البحث'**
  String get searchResults;

  /// No description provided for @noResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get noResults;

  /// No description provided for @announcements.
  ///
  /// In ar, this message translates to:
  /// **'الإعلانات'**
  String get announcements;

  /// No description provided for @viewAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get viewAll;

  /// No description provided for @ikamet.
  ///
  /// In ar, this message translates to:
  /// **'الإقامة'**
  String get ikamet;

  /// No description provided for @places.
  ///
  /// In ar, this message translates to:
  /// **'الأماكن'**
  String get places;

  /// No description provided for @projects.
  ///
  /// In ar, this message translates to:
  /// **'المشاريع'**
  String get projects;

  /// No description provided for @announcement.
  ///
  /// In ar, this message translates to:
  /// **'الإعلان'**
  String get announcement;

  /// No description provided for @announcementNotFound.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على الإعلان'**
  String get announcementNotFound;

  /// No description provided for @loading.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحميل...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get error;

  /// No description provided for @openLink.
  ///
  /// In ar, this message translates to:
  /// **'فتح الرابط'**
  String get openLink;

  /// No description provided for @addComment.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تعليق'**
  String get addComment;

  /// No description provided for @shareOpinion.
  ///
  /// In ar, this message translates to:
  /// **'شارك رأيك أو استفسارك حول هذا الخبر'**
  String get shareOpinion;

  /// No description provided for @name.
  ///
  /// In ar, this message translates to:
  /// **'الاسم'**
  String get name;

  /// No description provided for @enterName.
  ///
  /// In ar, this message translates to:
  /// **'أدخل اسمك'**
  String get enterName;

  /// No description provided for @comment.
  ///
  /// In ar, this message translates to:
  /// **'التعليق'**
  String get comment;

  /// No description provided for @writeComment.
  ///
  /// In ar, this message translates to:
  /// **'اكتب تعليقك هنا...'**
  String get writeComment;

  /// No description provided for @sendComment.
  ///
  /// In ar, this message translates to:
  /// **'إرسال التعليق'**
  String get sendComment;

  /// No description provided for @commentReviewNote.
  ///
  /// In ar, this message translates to:
  /// **'سيتم مراجعة تعليقك من قبل الإدارة'**
  String get commentReviewNote;

  /// No description provided for @waitMinutes.
  ///
  /// In ar, this message translates to:
  /// **'يرجى الانتظار {minutes} دقيقة قبل إرسال تعليق آخر'**
  String waitMinutes(int minutes);

  /// No description provided for @commentSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال تعليقك بنجاح! سيتم مراجعته قريباً.'**
  String get commentSuccess;

  /// No description provided for @commentError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء إرسال التعليق. يرجى المحاولة مرة أخرى.'**
  String get commentError;

  /// No description provided for @nameRequired.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء إدخال الاسم'**
  String get nameRequired;

  /// No description provided for @nameTooShort.
  ///
  /// In ar, this message translates to:
  /// **'الاسم يجب أن يكون على الأقل حرفين'**
  String get nameTooShort;

  /// No description provided for @nameTooLong.
  ///
  /// In ar, this message translates to:
  /// **'الاسم يجب أن لا يتجاوز 50 حرفاً'**
  String get nameTooLong;

  /// No description provided for @commentRequired.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء إدخال التعليق'**
  String get commentRequired;

  /// No description provided for @commentTooShort.
  ///
  /// In ar, this message translates to:
  /// **'التعليق يجب أن يكون على الأقل 10 أحرف'**
  String get commentTooShort;

  /// No description provided for @linkError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في فتح الرابط: {error}'**
  String linkError(Object error);

  /// No description provided for @eventsCalendar.
  ///
  /// In ar, this message translates to:
  /// **'تقويم الفعاليات'**
  String get eventsCalendar;

  /// No description provided for @upcomingEvents.
  ///
  /// In ar, this message translates to:
  /// **'فعاليات قادمة'**
  String get upcomingEvents;

  /// No description provided for @previousEvents.
  ///
  /// In ar, this message translates to:
  /// **'فعاليات سابقة'**
  String get previousEvents;

  /// No description provided for @noEventsToday.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد فعاليات في هذا اليوم'**
  String get noEventsToday;

  /// No description provided for @noUpcomingEvents.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد فعاليات قادمة'**
  String get noUpcomingEvents;

  /// No description provided for @registerNow.
  ///
  /// In ar, this message translates to:
  /// **'سجل الآن'**
  String get registerNow;

  /// No description provided for @linkLaunchError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر فتح رابط التسجيل'**
  String get linkLaunchError;

  /// No description provided for @eventsOf.
  ///
  /// In ar, this message translates to:
  /// **'فعاليات {date}'**
  String eventsOf(Object date);

  /// No description provided for @ikametTracker.
  ///
  /// In ar, this message translates to:
  /// **'متتبع الإقامة'**
  String get ikametTracker;

  /// No description provided for @ikametNoDateSet.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم تعيين تاريخ انتهاء الإقامة'**
  String get ikametNoDateSet;

  /// No description provided for @ikametSetDate.
  ///
  /// In ar, this message translates to:
  /// **'تعيين تاريخ الانتهاء'**
  String get ikametSetDate;

  /// No description provided for @ikametExpiresIn.
  ///
  /// In ar, this message translates to:
  /// **'تنتهي في:'**
  String get ikametExpiresIn;

  /// No description provided for @days.
  ///
  /// In ar, this message translates to:
  /// **'يوم'**
  String get days;

  /// No description provided for @ikametSafe.
  ///
  /// In ar, this message translates to:
  /// **'آمن'**
  String get ikametSafe;

  /// No description provided for @ikametWarning.
  ///
  /// In ar, this message translates to:
  /// **'تحذير'**
  String get ikametWarning;

  /// No description provided for @ikametUrgent.
  ///
  /// In ar, this message translates to:
  /// **'عاجل!'**
  String get ikametUrgent;

  /// No description provided for @studentResources.
  ///
  /// In ar, this message translates to:
  /// **'مصادر مفيدة للطلاب'**
  String get studentResources;

  /// No description provided for @noUniversitiesInSection.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد جامعات في هذا القسم'**
  String get noUniversitiesInSection;

  /// No description provided for @university.
  ///
  /// In ar, this message translates to:
  /// **'جامعة'**
  String get university;

  /// No description provided for @universityIntro.
  ///
  /// In ar, this message translates to:
  /// **'مقدمة عن الجامعة'**
  String get universityIntro;

  /// No description provided for @bachelorPrograms.
  ///
  /// In ar, this message translates to:
  /// **'برامج البكالوريوس'**
  String get bachelorPrograms;

  /// No description provided for @associatePrograms.
  ///
  /// In ar, this message translates to:
  /// **'برامج الدبلوم'**
  String get associatePrograms;

  /// No description provided for @universityInTurkey.
  ///
  /// In ar, this message translates to:
  /// **'جامعة في تركيا'**
  String get universityInTurkey;

  /// No description provided for @noItemsInSection.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عناصر في هذا القسم'**
  String get noItemsInSection;

  /// No description provided for @projectDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل المشروع'**
  String get projectDetails;

  /// No description provided for @callNow.
  ///
  /// In ar, this message translates to:
  /// **'اتصل الآن'**
  String get callNow;

  /// No description provided for @joinWhatsapp.
  ///
  /// In ar, this message translates to:
  /// **'انضم للمجموعة عبر ياتساب'**
  String get joinWhatsapp;

  /// No description provided for @aboutProject.
  ///
  /// In ar, this message translates to:
  /// **'نبذة عن المشروع'**
  String get aboutProject;

  /// No description provided for @reviews.
  ///
  /// In ar, this message translates to:
  /// **'التقييمات'**
  String get reviews;

  /// No description provided for @shareExperience.
  ///
  /// In ar, this message translates to:
  /// **'شارك تجربتك مع الآخرين'**
  String get shareExperience;

  /// No description provided for @noReviewsYet.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تقييمات بعد'**
  String get noReviewsYet;

  /// No description provided for @beFirstToReview.
  ///
  /// In ar, this message translates to:
  /// **'كن أول من يشارك تجربته!'**
  String get beFirstToReview;

  /// No description provided for @addReview.
  ///
  /// In ar, this message translates to:
  /// **'إضافة تقييم'**
  String get addReview;

  /// No description provided for @rating.
  ///
  /// In ar, this message translates to:
  /// **'التقييم'**
  String get rating;

  /// No description provided for @writeReview.
  ///
  /// In ar, this message translates to:
  /// **'اكتب تقييمك هنا...'**
  String get writeReview;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @sendReview.
  ///
  /// In ar, this message translates to:
  /// **'إرسال التقييم'**
  String get sendReview;

  /// No description provided for @reviewSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إرسال تقييمك بنجاح! سيتم نشره بعد المراجعة.'**
  String get reviewSuccess;

  /// No description provided for @reviewError.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ. يرجى المحاولة مرة أخرى.'**
  String get reviewError;

  /// No description provided for @reviewsLoadError.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في تحميل التقييمات'**
  String get reviewsLoadError;

  /// No description provided for @notifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get notifications;

  /// No description provided for @clearAll.
  ///
  /// In ar, this message translates to:
  /// **'مسح الكل'**
  String get clearAll;

  /// No description provided for @noNotifications.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد إشعارات حالياً'**
  String get noNotifications;

  /// No description provided for @clearAllTitle.
  ///
  /// In ar, this message translates to:
  /// **'مسح جميع الإشعارات؟'**
  String get clearAllTitle;

  /// No description provided for @clearAllMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من رغبتك في حذف سجل الإشعارات بالكامل؟'**
  String get clearAllMessage;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @savedPlaces.
  ///
  /// In ar, this message translates to:
  /// **'الأماكن المحفوظة'**
  String get savedPlaces;

  /// No description provided for @savedPlacesSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'شاهد قائمة الأماكن المفضلة'**
  String get savedPlacesSubtitle;

  /// No description provided for @aboutUs.
  ///
  /// In ar, this message translates to:
  /// **'من نحن'**
  String get aboutUs;

  /// No description provided for @aboutUsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'دليل الاتحاد والمعلومات'**
  String get aboutUsSubtitle;

  /// No description provided for @supportUs.
  ///
  /// In ar, this message translates to:
  /// **'دعمنا'**
  String get supportUs;

  /// No description provided for @supportUsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تبرع لدعم المجتمع'**
  String get supportUsSubtitle;

  /// No description provided for @appearance.
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get appearance;

  /// No description provided for @committees.
  ///
  /// In ar, this message translates to:
  /// **'الهيئات'**
  String get committees;

  /// No description provided for @committeesSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'الهيئات السابقة عبر السنوات'**
  String get committeesSubtitle;

  /// No description provided for @oversight.
  ///
  /// In ar, this message translates to:
  /// **'لجان الرقابة'**
  String get oversight;

  /// No description provided for @oversightSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أعضاء لجان الرقابة عبر السنوات'**
  String get oversightSubtitle;

  /// No description provided for @selectLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة'**
  String get selectLanguage;

  /// No description provided for @arabic.
  ///
  /// In ar, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In ar, this message translates to:
  /// **'الإنجليزية'**
  String get english;

  /// No description provided for @turkish.
  ///
  /// In ar, this message translates to:
  /// **'التركية'**
  String get turkish;

  /// No description provided for @themeFollowSystem.
  ///
  /// In ar, this message translates to:
  /// **'يتبع إعدادات الجهاز'**
  String get themeFollowSystem;

  /// No description provided for @themeAlwaysLight.
  ///
  /// In ar, this message translates to:
  /// **'المظهر الفاتح دائماً'**
  String get themeAlwaysLight;

  /// No description provided for @themeAlwaysDark.
  ///
  /// In ar, this message translates to:
  /// **'المظهر الداكن دائماً'**
  String get themeAlwaysDark;

  /// No description provided for @selectTheme.
  ///
  /// In ar, this message translates to:
  /// **'اختر المظهر'**
  String get selectTheme;

  /// No description provided for @supportDesc.
  ///
  /// In ar, this message translates to:
  /// **'يمكنك دعم مجتمع الطلاب اليمنيين في أنقرة من خلال التبرع:'**
  String get supportDesc;

  /// No description provided for @copy.
  ///
  /// In ar, this message translates to:
  /// **'نسخ'**
  String get copy;

  /// No description provided for @copiedIban.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ رقم الـ IBAN'**
  String get copiedIban;

  /// No description provided for @close.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get close;

  /// No description provided for @loadingData.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحميل البيانات، يرجى المحاولة لاحقاً'**
  String get loadingData;

  /// No description provided for @exchangeRateError.
  ///
  /// In ar, this message translates to:
  /// **'تعذر تحديث الأسعار. استخدام الأسعار الاحتياطية.'**
  String get exchangeRateError;

  /// No description provided for @retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// No description provided for @popularPlaces.
  ///
  /// In ar, this message translates to:
  /// **'أماكن مشهورة'**
  String get popularPlaces;

  /// No description provided for @partners.
  ///
  /// In ar, this message translates to:
  /// **'شركاؤنا'**
  String get partners;

  /// No description provided for @noPartners.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد شركاء حالياً'**
  String get noPartners;

  /// No description provided for @catUniversity.
  ///
  /// In ar, this message translates to:
  /// **'الجامعات'**
  String get catUniversity;

  /// No description provided for @catHospital.
  ///
  /// In ar, this message translates to:
  /// **'المستشفيات'**
  String get catHospital;

  /// No description provided for @catMall.
  ///
  /// In ar, this message translates to:
  /// **'المولات'**
  String get catMall;

  /// No description provided for @catHistoric.
  ///
  /// In ar, this message translates to:
  /// **'المعالم'**
  String get catHistoric;

  /// No description provided for @catLibrary.
  ///
  /// In ar, this message translates to:
  /// **'المكتبات'**
  String get catLibrary;

  /// No description provided for @catTransport.
  ///
  /// In ar, this message translates to:
  /// **'المواصلات'**
  String get catTransport;

  /// No description provided for @catGovOffice.
  ///
  /// In ar, this message translates to:
  /// **'الدوائر الحكومية'**
  String get catGovOffice;

  /// No description provided for @catParks.
  ///
  /// In ar, this message translates to:
  /// **'الحدائق'**
  String get catParks;

  /// No description provided for @catHousing.
  ///
  /// In ar, this message translates to:
  /// **'دليل السكنات'**
  String get catHousing;

  /// No description provided for @catPartners.
  ///
  /// In ar, this message translates to:
  /// **'شركاء النجاح'**
  String get catPartners;

  /// No description provided for @catAbout.
  ///
  /// In ar, this message translates to:
  /// **'من نحن'**
  String get catAbout;

  /// No description provided for @catProject.
  ///
  /// In ar, this message translates to:
  /// **'مشاريعنا'**
  String get catProject;

  /// No description provided for @noAnnouncementFound.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم العثور على الإعلان'**
  String get noAnnouncementFound;

  /// No description provided for @shareYourOpinion.
  ///
  /// In ar, this message translates to:
  /// **'شارك رأيك أو استفسارك حول هذا الخبر'**
  String get shareYourOpinion;

  /// No description provided for @pleaseEnterName.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء إدخال الاسم'**
  String get pleaseEnterName;

  /// No description provided for @writeCommentHere.
  ///
  /// In ar, this message translates to:
  /// **'اكتب تعليقك هنا...'**
  String get writeCommentHere;

  /// No description provided for @pleaseEnterComment.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء إدخال التعليق'**
  String get pleaseEnterComment;

  /// No description provided for @errorOpeningLink.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في فتح الرابط'**
  String get errorOpeningLink;

  /// No description provided for @eventCalendar.
  ///
  /// In ar, this message translates to:
  /// **'تقويم الفعاليات'**
  String get eventCalendar;

  /// No description provided for @eventsOnDate.
  ///
  /// In ar, this message translates to:
  /// **'فعاليات {date}'**
  String eventsOnDate(String date);

  /// No description provided for @showAll.
  ///
  /// In ar, this message translates to:
  /// **'عرض الكل'**
  String get showAll;

  /// No description provided for @noEventsOnDay.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد فعاليات في هذا اليوم'**
  String get noEventsOnDay;

  /// No description provided for @errorOpeningRegistrationLink.
  ///
  /// In ar, this message translates to:
  /// **'تعذر فتح رابط التسجيل'**
  String get errorOpeningRegistrationLink;

  /// No description provided for @noUniversitiesFound.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد جامعات في هذا القسم'**
  String get noUniversitiesFound;

  /// No description provided for @universityIntroduction.
  ///
  /// In ar, this message translates to:
  /// **'مقدمة عن الجامعة'**
  String get universityIntroduction;

  /// No description provided for @placeNotFound.
  ///
  /// In ar, this message translates to:
  /// **'المكان غير موجود'**
  String get placeNotFound;

  /// No description provided for @place.
  ///
  /// In ar, this message translates to:
  /// **'المكان'**
  String get place;

  /// No description provided for @navigate.
  ///
  /// In ar, this message translates to:
  /// **'تنقّل'**
  String get navigate;

  /// No description provided for @attachedDocuments.
  ///
  /// In ar, this message translates to:
  /// **'الوثائق المرفقة'**
  String get attachedDocuments;

  /// No description provided for @pdfFile.
  ///
  /// In ar, this message translates to:
  /// **'ملف PDF'**
  String get pdfFile;

  /// No description provided for @introductoryDocument.
  ///
  /// In ar, this message translates to:
  /// **'مستند تعريفي'**
  String get introductoryDocument;

  /// No description provided for @cannotOpenFile.
  ///
  /// In ar, this message translates to:
  /// **'لا يمكن فتح الملف: {error}'**
  String cannotOpenFile(String error);

  /// No description provided for @showLess.
  ///
  /// In ar, this message translates to:
  /// **'عرض أقل'**
  String get showLess;

  /// No description provided for @readMore.
  ///
  /// In ar, this message translates to:
  /// **'اقرأ المزيد'**
  String get readMore;

  /// No description provided for @noSavedPlaces.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أماكن محفوظة'**
  String get noSavedPlaces;

  /// No description provided for @errorLoadingData.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في تحميل البيانات: {error}'**
  String errorLoadingData(String error);

  /// No description provided for @joinWhatsappGroup.
  ///
  /// In ar, this message translates to:
  /// **'انضم للمجموعة عبر واتساب'**
  String get joinWhatsappGroup;

  /// No description provided for @clearAllNotificationsTitle.
  ///
  /// In ar, this message translates to:
  /// **'مسح جميع الإشعارات؟'**
  String get clearAllNotificationsTitle;

  /// No description provided for @clearAllNotificationsMessage.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من رغبتك في حذف سجل الإشعارات بالكامل؟'**
  String get clearAllNotificationsMessage;

  /// No description provided for @clear.
  ///
  /// In ar, this message translates to:
  /// **'مسح'**
  String get clear;

  /// No description provided for @pastOversightCommittees.
  ///
  /// In ar, this message translates to:
  /// **'لجان الرقابة السابقة'**
  String get pastOversightCommittees;

  /// No description provided for @noDataAvailable.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات متاحة'**
  String get noDataAvailable;

  /// No description provided for @selectYear.
  ///
  /// In ar, this message translates to:
  /// **'اختر السنة'**
  String get selectYear;

  /// No description provided for @noMembersForYear.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد أعضاء لهذه السنة'**
  String get noMembersForYear;

  /// No description provided for @pastContributors.
  ///
  /// In ar, this message translates to:
  /// **'الهيئات السابقة'**
  String get pastContributors;

  /// No description provided for @noContributorsForYear.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد مساهمون لهذه السنة'**
  String get noContributorsForYear;

  /// No description provided for @directory.
  ///
  /// In ar, this message translates to:
  /// **'الدليل'**
  String get directory;

  /// No description provided for @sections.
  ///
  /// In ar, this message translates to:
  /// **'الأقسام'**
  String get sections;

  /// No description provided for @noResidencyGuide.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد دليل الإقامة حالياً'**
  String get noResidencyGuide;

  /// No description provided for @fileLinkNotAvailable.
  ///
  /// In ar, this message translates to:
  /// **'رابط الملف غير متوفر'**
  String get fileLinkNotAvailable;

  /// No description provided for @noHousingGuide.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد دليل السكنات حالياً'**
  String get noHousingGuide;

  /// No description provided for @pdfLinkNotAvailable.
  ///
  /// In ar, this message translates to:
  /// **'رابط PDF غير متوفر'**
  String get pdfLinkNotAvailable;

  /// No description provided for @residencyGuide.
  ///
  /// In ar, this message translates to:
  /// **'دليل الإقامة (PDF)'**
  String get residencyGuide;

  /// No description provided for @housingGuide.
  ///
  /// In ar, this message translates to:
  /// **'دليل السكنات (PDF)'**
  String get housingGuide;

  /// No description provided for @currencyConverter.
  ///
  /// In ar, this message translates to:
  /// **'تحويل العملات'**
  String get currencyConverter;

  /// No description provided for @refreshRates.
  ///
  /// In ar, this message translates to:
  /// **'تحديث الأسعار'**
  String get refreshRates;

  /// No description provided for @from.
  ///
  /// In ar, this message translates to:
  /// **'من'**
  String get from;

  /// No description provided for @to.
  ///
  /// In ar, this message translates to:
  /// **'إلى'**
  String get to;

  /// No description provided for @contactAndInquiry.
  ///
  /// In ar, this message translates to:
  /// **'للتواصل والاستفسار'**
  String get contactAndInquiry;

  /// No description provided for @fundManager.
  ///
  /// In ar, this message translates to:
  /// **'مسؤول الصندوق'**
  String get fundManager;

  /// No description provided for @eventDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل الفعالية'**
  String get eventDetails;

  /// No description provided for @pastEvents.
  ///
  /// In ar, this message translates to:
  /// **'الفعاليات السابقة'**
  String get pastEvents;

  /// No description provided for @noPastEvents.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد فعاليات سابقة'**
  String get noPastEvents;

  /// No description provided for @eventCategorySports.
  ///
  /// In ar, this message translates to:
  /// **'رياضة'**
  String get eventCategorySports;

  /// No description provided for @eventCategoryCulture.
  ///
  /// In ar, this message translates to:
  /// **'ثقافة وفنون'**
  String get eventCategoryCulture;

  /// No description provided for @eventCategoryEducational.
  ///
  /// In ar, this message translates to:
  /// **'تعليم'**
  String get eventCategoryEducational;

  /// No description provided for @eventCategorySocial.
  ///
  /// In ar, this message translates to:
  /// **'اجتماعي'**
  String get eventCategorySocial;

  /// No description provided for @eventCategoryReligious.
  ///
  /// In ar, this message translates to:
  /// **'ديني'**
  String get eventCategoryReligious;

  /// No description provided for @eventCategoryOther.
  ///
  /// In ar, this message translates to:
  /// **'عام'**
  String get eventCategoryOther;

  /// No description provided for @downloadingLanguageModel.
  ///
  /// In ar, this message translates to:
  /// **'جاري تحميل حزمة اللغة...'**
  String get downloadingLanguageModel;

  /// No description provided for @languageModelDownloaded.
  ///
  /// In ar, this message translates to:
  /// **'تم تحميل حزمة اللغة بنجاح.'**
  String get languageModelDownloaded;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
