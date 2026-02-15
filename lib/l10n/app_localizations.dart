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

  /// No description provided for @catActivities.
  ///
  /// In ar, this message translates to:
  /// **'الأنشطة والترفيه'**
  String get catActivities;

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

  /// No description provided for @reportSafetyConcern.
  ///
  /// In ar, this message translates to:
  /// **'الإبلاغ عن محتوى أو انتهاك'**
  String get reportSafetyConcern;

  /// No description provided for @reportSafetyConcernSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تواصل معنا للإبلاغ عن أي مخاوف تتعلق بالسلامة'**
  String get reportSafetyConcernSubtitle;

  /// No description provided for @socialConnect.
  ///
  /// In ar, this message translates to:
  /// **'التواصل الاجتماعي'**
  String get socialConnect;

  /// No description provided for @location.
  ///
  /// In ar, this message translates to:
  /// **'الموقع'**
  String get location;

  /// No description provided for @globalRank.
  ///
  /// In ar, this message translates to:
  /// **'التصنيف العالمي'**
  String get globalRank;

  /// No description provided for @degrees.
  ///
  /// In ar, this message translates to:
  /// **'الدرجات العلمية'**
  String get degrees;

  /// No description provided for @bachelorsAndMore.
  ///
  /// In ar, this message translates to:
  /// **'بكالوريوس وأكثر'**
  String get bachelorsAndMore;

  /// No description provided for @openInGoogleMaps.
  ///
  /// In ar, this message translates to:
  /// **'فتح في خرائط جوجل'**
  String get openInGoogleMaps;

  /// No description provided for @navigateNow.
  ///
  /// In ar, this message translates to:
  /// **'التوجه الآن'**
  String get navigateNow;

  /// No description provided for @noDescriptionAvailable.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد وصف متاح.'**
  String get noDescriptionAvailable;

  /// No description provided for @established.
  ///
  /// In ar, this message translates to:
  /// **'سنة التأسيس'**
  String get established;

  /// No description provided for @knownFor.
  ///
  /// In ar, this message translates to:
  /// **'تشتهر بـ'**
  String get knownFor;

  /// No description provided for @hospitalType.
  ///
  /// In ar, this message translates to:
  /// **'نوع المستشفى'**
  String get hospitalType;

  /// No description provided for @medicalAdvice.
  ///
  /// In ar, this message translates to:
  /// **'معلومة طبية ومستشفيات'**
  String get medicalAdvice;

  /// No description provided for @bookingMethod.
  ///
  /// In ar, this message translates to:
  /// **'طريقة الحجز'**
  String get bookingMethod;

  /// No description provided for @languageTip.
  ///
  /// In ar, this message translates to:
  /// **'صعوبات اللغة'**
  String get languageTip;

  /// No description provided for @insuranceInfo.
  ///
  /// In ar, this message translates to:
  /// **'التأمين والتكاليف'**
  String get insuranceInfo;

  /// No description provided for @whatToBring.
  ///
  /// In ar, this message translates to:
  /// **'ماذا تحضر معك؟'**
  String get whatToBring;

  /// No description provided for @howToBook.
  ///
  /// In ar, this message translates to:
  /// **'كيفية الحجز'**
  String get howToBook;

  /// No description provided for @hospitalAdvices.
  ///
  /// In ar, this message translates to:
  /// **'معلومة المستشفيات'**
  String get hospitalAdvices;

  /// No description provided for @entryFee.
  ///
  /// In ar, this message translates to:
  /// **'رسوم الدخول'**
  String get entryFee;

  /// No description provided for @barbecue.
  ///
  /// In ar, this message translates to:
  /// **'الشواء / التنزه'**
  String get barbecue;

  /// No description provided for @history.
  ///
  /// In ar, this message translates to:
  /// **'لمحة تاريخية'**
  String get history;

  /// No description provided for @parkAdvices.
  ///
  /// In ar, this message translates to:
  /// **'معلومة المتنزهات'**
  String get parkAdvices;

  /// No description provided for @seasonalRules.
  ///
  /// In ar, this message translates to:
  /// **'القواعد الموسمية'**
  String get seasonalRules;

  /// No description provided for @fuelTypes.
  ///
  /// In ar, this message translates to:
  /// **'أنواع الوقود'**
  String get fuelTypes;

  /// No description provided for @arrivalTime.
  ///
  /// In ar, this message translates to:
  /// **'وقت الوصول'**
  String get arrivalTime;

  /// No description provided for @seasonalRulesContent.
  ///
  /// In ar, this message translates to:
  /// **'غالباً ما تصدر ولاية أنقرة حظراً على الشواء والنيران المفتوحة من يونيو/يوليو حتى 30 سبتمبر لحماية الغابات من الحرائق خلال الجو الجاف.'**
  String get seasonalRulesContent;

  /// No description provided for @fuelTypesContent.
  ///
  /// In ar, this message translates to:
  /// **'يمنع استخدام الأخشاب أو القطع التي تسبب دخاناً كثيفاً خارج وحدات الشواء. يُتوقع منك إحضار الفحم الخاص بك.'**
  String get fuelTypesContent;

  /// No description provided for @arrivalTimeContent.
  ///
  /// In ar, this message translates to:
  /// **'في عطلات نهاية الأسبوع، تمتلئ أماكن الشواء مبكراً (غالباً 9:00 - 10:00 صباحاً). يفضل الوصول مبكراً لضمان مكان.'**
  String get arrivalTimeContent;

  /// No description provided for @place_metu_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Middle East Technical University (METU/ODTÜ)'**
  String get place_metu_uni_name;

  /// No description provided for @place_metu_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة الشرق الأوسط التقنية (METU) هي جامعة بحثية حكومية دولية في أنقرة. لغة التدريس هي الإنجليزية وتعتبر الأفضل في تركيا في تخصصات الهندسة والعلوم الطبيعية.'**
  String get place_metu_uni_desc;

  /// No description provided for @place_hacettepe_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Hacettepe University'**
  String get place_hacettepe_uni_name;

  /// No description provided for @place_hacettepe_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة حاجيت تبه هي الوجهة الأولى لدراسة الطب في تركيا. تأسست عام 1967 وتضم حرمين جامعيين كبيرين. بجانب الطب، تتفوق في الهندسة والفنون الجميلة.'**
  String get place_hacettepe_uni_desc;

  /// No description provided for @place_ankara_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara University'**
  String get place_ankara_uni_name;

  /// No description provided for @place_ankara_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة أنقرة هي أول جامعة تأسست في الجمهورية التركية عام 1946. تشتهر بكلياتها العريقة في القانون والعلوم السياسية والطب.'**
  String get place_ankara_uni_desc;

  /// No description provided for @place_gazi_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Gazi University'**
  String get place_gazi_uni_name;

  /// No description provided for @place_gazi_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة عريقة تأسست عام 1926، وتشتهر بتخصصات التعليم والهندسة والتكنولوجيا.'**
  String get place_gazi_uni_desc;

  /// No description provided for @place_aybu_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Yıldırım Beyazıt University (AYBU)'**
  String get place_aybu_uni_name;

  /// No description provided for @place_aybu_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة حكومية حديثة تقدم معظم برامجها باللغة الإنجليزية. تشتهر بتخصصات الطب والهندسة.'**
  String get place_aybu_uni_desc;

  /// No description provided for @place_haci_bayram_veli_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Hacı Bayram Veli University (AHBVU)'**
  String get place_haci_bayram_veli_name;

  /// No description provided for @place_haci_bayram_veli_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة حكومية تركز على العلوم الاجتماعية والفنون والسياحة والقانون.'**
  String get place_haci_bayram_veli_desc;

  /// No description provided for @place_asbu_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Social Sciences University of Ankara (ASBU)'**
  String get place_asbu_uni_name;

  /// No description provided for @place_asbu_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'أول جامعة حكومية متخصصة بالكامل في العلوم الاجتماعية في تركيا، تقع في منطقة أولوس التاريخية.'**
  String get place_asbu_uni_desc;

  /// No description provided for @place_mgu_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Music and Fine Arts University (MGU)'**
  String get place_mgu_uni_name;

  /// No description provided for @place_mgu_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة حكومية متخصصة في الموسيقى والفنون الجميلة.'**
  String get place_mgu_uni_desc;

  /// No description provided for @place_bilkent_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Bilkent University'**
  String get place_bilkent_uni_name;

  /// No description provided for @place_bilkent_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'أول جامعة خاصة في تركيا، تشتهر ببحثها العلمي المتميز والتعليم باللغة الإنجليزية.'**
  String get place_bilkent_uni_desc;

  /// No description provided for @place_cankaya_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Çankaya University'**
  String get place_cankaya_uni_name;

  /// No description provided for @place_cankaya_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة خاصة تشتهر بتأثير أبحاثها العالي وبرامج الهندسة والعمارة والقانون.'**
  String get place_cankaya_uni_desc;

  /// No description provided for @place_tobb_etu_name.
  ///
  /// In ar, this message translates to:
  /// **'TOBB University of Economics and Technology'**
  String get place_tobb_etu_name;

  /// No description provided for @place_tobb_etu_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة خاصة معروفة بنظام التعليم التعاوني والعلاقات القوية مع عالم الأعمال.'**
  String get place_tobb_etu_desc;

  /// No description provided for @place_atilim_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Atılım University'**
  String get place_atilim_uni_name;

  /// No description provided for @place_atilim_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة خاصة تركز على البحث والإنتاجية، وتتميز في هندسة الطيران.'**
  String get place_atilim_uni_desc;

  /// No description provided for @place_baskent_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Başkent University'**
  String get place_baskent_uni_name;

  /// No description provided for @place_baskent_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة خاصة رائدة في العلوم الصحية والطب، وتمتلك شبكة مستشفيات واسعة.'**
  String get place_baskent_uni_desc;

  /// No description provided for @place_tedu_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'TED University'**
  String get place_tedu_uni_name;

  /// No description provided for @place_tedu_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة خاصة تركز على التعليم الليبرالي والمهارات الشخصية.'**
  String get place_tedu_uni_desc;

  /// No description provided for @place_ostim_tech_name.
  ///
  /// In ar, this message translates to:
  /// **'OSTİM Technical University'**
  String get place_ostim_tech_name;

  /// No description provided for @place_ostim_tech_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة صناعية تقع في منطقة صناعية، تركز على التدريب العملي وريادة الأعمال.'**
  String get place_ostim_tech_desc;

  /// No description provided for @place_lokman_hekim_name.
  ///
  /// In ar, this message translates to:
  /// **'Lokman Hekim University'**
  String get place_lokman_hekim_name;

  /// No description provided for @place_lokman_hekim_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة موضوعية للعلوم الصحية، مرتبطة بمستشفيات لوكمان حكيم.'**
  String get place_lokman_hekim_desc;

  /// No description provided for @place_medipol_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Medipol University'**
  String get place_medipol_ankara_name;

  /// No description provided for @place_medipol_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة تركز على العلوم الصحية والبنية التحتية التكنولوجية الحديثة.'**
  String get place_medipol_ankara_desc;

  /// No description provided for @place_thk_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'University of Turkish Aeronautical Association (THK University)'**
  String get place_thk_uni_name;

  /// No description provided for @place_thk_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'الجامعة الأولى المتخصصة في الطيران والفضاء في تركيا.'**
  String get place_thk_uni_desc;

  /// No description provided for @place_ufuk_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'Ufuk University'**
  String get place_ufuk_uni_name;

  /// No description provided for @place_ufuk_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة خاصة معروفة بكلية الطب والقانون والتربية.'**
  String get place_ufuk_uni_desc;

  /// No description provided for @place_yuksek_ihtisas_name.
  ///
  /// In ar, this message translates to:
  /// **'Yüksek İhtisas University'**
  String get place_yuksek_ihtisas_name;

  /// No description provided for @place_yuksek_ihtisas_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة متخصصة في العلوم الصحية، خاصة الطب والتمريض.'**
  String get place_yuksek_ihtisas_desc;

  /// No description provided for @place_ankara_bilim_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Science University (Ankara Bilim)'**
  String get place_ankara_bilim_name;

  /// No description provided for @place_ankara_bilim_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة حديثة تركز على هندسة البرمجيات والتصميم والتنمية المستدامة.'**
  String get place_ankara_bilim_desc;

  /// No description provided for @place_health_sciences_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'University of Health Sciences (SBÜ) – Gülhane Campus'**
  String get place_health_sciences_uni_name;

  /// No description provided for @place_health_sciences_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'جامعة حكومية متخصصة في العلوم الصحية، مقرها في مجمع جولهانه الطبي العريق.'**
  String get place_health_sciences_uni_desc;

  /// No description provided for @place_police_academy_name.
  ///
  /// In ar, this message translates to:
  /// **'Turkish National Police Academy'**
  String get place_police_academy_name;

  /// No description provided for @place_police_academy_desc.
  ///
  /// In ar, this message translates to:
  /// **'المؤسسة الرائدة لتدريب ضباط الشرطة وخبراء الأمن في تركيا.'**
  String get place_police_academy_desc;

  /// No description provided for @place_national_defense_uni_name.
  ///
  /// In ar, this message translates to:
  /// **'National Defense University – Turkish Military Academy'**
  String get place_national_defense_uni_name;

  /// No description provided for @place_national_defense_uni_desc.
  ///
  /// In ar, this message translates to:
  /// **'المؤسسة العسكرية لتدريب ضباط القوات البرية التركية، تجمع بين التدريب العسكري والتعليم الأكاديمي.'**
  String get place_national_defense_uni_desc;

  /// No description provided for @place_medical_advice_name.
  ///
  /// In ar, this message translates to:
  /// **'Medical Appointment Advice'**
  String get place_medical_advice_name;

  /// No description provided for @place_medical_advice_desc.
  ///
  /// In ar, this message translates to:
  /// **'دليل شامل حول كيفية حجز المواعيد الطبية في أنقرة، التعامل مع اللغة، وفهم التأمين الصحي للطلاب.'**
  String get place_medical_advice_desc;

  /// No description provided for @place_bilkent_city_hosp_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Bilkent City Hospital'**
  String get place_bilkent_city_hosp_name;

  /// No description provided for @place_bilkent_city_hosp_desc.
  ///
  /// In ar, this message translates to:
  /// **'واحدة من أكبر المجمعات الطبية في العالم؛ معروفة بجراحة القلب والأوعية الدموية، والأعصاب، وجراحة العظام، والأورام، والطب النفسي الشرعي عالي الأمن. تضم أكثر من 3700 سرير وهي معتمدة من JCI.'**
  String get place_bilkent_city_hosp_desc;

  /// No description provided for @place_hacettepe_uni_hosp_name.
  ///
  /// In ar, this message translates to:
  /// **'Hacettepe University Hospitals'**
  String get place_hacettepe_uni_hosp_name;

  /// No description provided for @place_hacettepe_uni_hosp_desc.
  ///
  /// In ar, this message translates to:
  /// **'مجمع يضم 4 مستشفيات (كبار، أطفال، أورام، أوران). مشهور بالتشخيصات الصعبة، وزراعة الأعضاء ونخاع العظام، وهو أول مستشفى حكومي معتمد من JCI في تركيا.'**
  String get place_hacettepe_uni_hosp_desc;

  /// No description provided for @place_ankara_uni_hosp_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara University Hospitals (İbni Sina & Cebeci)'**
  String get place_ankara_uni_hosp_name;

  /// No description provided for @place_ankara_uni_hosp_desc.
  ///
  /// In ar, this message translates to:
  /// **'مستشفى \"ابن سينا\" متخصص في الطب الباطني والجراحة وعلم الدم. مستشفى \"جيبيجي\" متخصص في طب الأطفال والقلب. يُعرف بمستشفى \"الأطباء\" لتدريب الأطباء المتميزين.'**
  String get place_ankara_uni_hosp_desc;

  /// No description provided for @place_gazi_uni_hosp_name.
  ///
  /// In ar, this message translates to:
  /// **'Gazi University Hospital'**
  String get place_gazi_uni_hosp_name;

  /// No description provided for @place_gazi_uni_hosp_desc.
  ///
  /// In ar, this message translates to:
  /// **'مركز رائد لإصابات الحوادث والرعاية الطارئة والعلاجات الباطنية والجراحية المتقدمة. يقوم بحوالي 50,000 عملية سنوياً.'**
  String get place_gazi_uni_hosp_desc;

  /// No description provided for @place_gulhane_hosp_name.
  ///
  /// In ar, this message translates to:
  /// **'Gülhane Training and Research Hospital (GATA)'**
  String get place_gulhane_hosp_name;

  /// No description provided for @place_gulhane_hosp_desc.
  ///
  /// In ar, this message translates to:
  /// **'كان سابقاً أكاديمية طبية عسكرية؛ معروف بإعادة التأهيل، رعاية الحروق، أمراض القلب، والأعصاب، والتعليم الطبي.'**
  String get place_gulhane_hosp_desc;

  /// No description provided for @place_etlik_city_hosp_name.
  ///
  /// In ar, this message translates to:
  /// **'Etlik City Hospital'**
  String get place_etlik_city_hosp_name;

  /// No description provided for @place_etlik_city_hosp_desc.
  ///
  /// In ar, this message translates to:
  /// **'ثاني أكبر مجمع مستشفيات في أنقرة، حل مكان مرافق قديمة مثل \"نمونة\". معروف ببنيته التحتية الذكية وأقسامه التخصصية المتعددة.'**
  String get place_etlik_city_hosp_desc;

  /// No description provided for @place_acibadem_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Acıbadem Ankara Hospital'**
  String get place_acibadem_ankara_name;

  /// No description provided for @place_acibadem_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'متخصص في العظام، أمراض النساء، طب الأطفال، والجراحة الروبوتية. يتميز بتقنيات مثل Flash CT وروبوتات da Vinci.'**
  String get place_acibadem_ankara_desc;

  /// No description provided for @place_memorial_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Memorial Ankara Hospital'**
  String get place_memorial_ankara_name;

  /// No description provided for @place_memorial_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'جراحة القلب والأوعية الدموية، التلقيح الاصطناعي، الأورام، وزراعة نخاع العظام. مساحته 42,000 متر مربع ويحمل اعتماد JCI.'**
  String get place_memorial_ankara_desc;

  /// No description provided for @place_medicana_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Medicana International Ankara'**
  String get place_medicana_ankara_name;

  /// No description provided for @place_medicana_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'زراعة الأعضاء (الكلى والكبد)، الأورام (بتقنية CyberKnife)، التلقيح الاصطناعي، وأمراض القلب.'**
  String get place_medicana_ankara_desc;

  /// No description provided for @place_guven_hosp_name.
  ///
  /// In ar, this message translates to:
  /// **'Güven Hospital'**
  String get place_guven_hosp_name;

  /// No description provided for @place_guven_hosp_desc.
  ///
  /// In ar, this message translates to:
  /// **'جراحة القلب والأوعية الدموية، طوارئ الأطفال، خدمات متميزة للمجتمع الدبلوماسي. يستخدم تقنيات المباني الذكية.'**
  String get place_guven_hosp_desc;

  /// No description provided for @place_bayindir_hosp_name.
  ///
  /// In ar, this message translates to:
  /// **'Bayındır Hospital (Söğütözü)'**
  String get place_bayindir_hosp_name;

  /// No description provided for @place_bayindir_hosp_desc.
  ///
  /// In ar, this message translates to:
  /// **'زراعة نخاع العظام، أمراض القلب، الأعصاب، وطب الأسنان. جزء من مجموعة بايندير للرعاية الصحية.'**
  String get place_bayindir_hosp_desc;

  /// No description provided for @place_tobb_etu_hosp_name.
  ///
  /// In ar, this message translates to:
  /// **'TOBB ETÜ Hospital'**
  String get place_tobb_etu_hosp_name;

  /// No description provided for @place_tobb_etu_hosp_desc.
  ///
  /// In ar, this message translates to:
  /// **'جراحة العمود الفقري، جراحة الثدي، جراحة الكبد والمرارة، والعمليات طفيفة التوغل. تملكه اتحاد الغرف والبورصات.'**
  String get place_tobb_etu_hosp_desc;

  /// No description provided for @place_lokman_hekim_ank_name.
  ///
  /// In ar, this message translates to:
  /// **'Lokman Hekim University Ankara Hospital'**
  String get place_lokman_hekim_ank_name;

  /// No description provided for @place_lokman_hekim_ank_desc.
  ///
  /// In ar, this message translates to:
  /// **'جراحة الأعصاب، العظام، ورعاية الأمومة \"الصديقة للطفل\". يتميز بمهبط للطائرات العمودية ووحدات عناية مركزة متخصصة.'**
  String get place_lokman_hekim_ank_desc;

  /// No description provided for @place_liv_hosp_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Liv Hospital Ankara'**
  String get place_liv_hosp_ankara_name;

  /// No description provided for @place_liv_hosp_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'الجراحة الروبوتية، جراحة السمنة، علاج السرطان، ورعاية القلب والأوعية الدموية. يحمل اعتمادات JCI و TUV.'**
  String get place_liv_hosp_ankara_desc;

  /// No description provided for @place_koru_hosp_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Koru Ankara Hospital'**
  String get place_koru_hosp_ankara_name;

  /// No description provided for @place_koru_hosp_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'جراحة السمنة الروبوتية، جراحة القلب، والتلقيح الاصطناعي. معروف براحة المرضى وبالتكنولوجيا المتقدمة.'**
  String get place_koru_hosp_ankara_desc;

  /// No description provided for @place_dunyagoz_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Dünyagöz Ankara'**
  String get place_dunyagoz_ankara_name;

  /// No description provided for @place_dunyagoz_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'متخصص حصرياً في طب العيون (ليزك، مياه بيضاء، جلوكوما). حجم جراحي كبير وتكنولوجيا ليزر متقدمة.'**
  String get place_dunyagoz_ankara_desc;

  /// No description provided for @place_medical_park_ank_name.
  ///
  /// In ar, this message translates to:
  /// **'Medical Park Ankara'**
  String get place_medical_park_ank_name;

  /// No description provided for @place_medical_park_ank_desc.
  ///
  /// In ar, this message translates to:
  /// **'رعاية شاملة مع التركيز على التكامل التكنولوجي. جزء من أكبر مجموعة مستشفيات خاصة في تركيا.'**
  String get place_medical_park_ank_desc;

  /// No description provided for @place_dental_estetik_center_name.
  ///
  /// In ar, this message translates to:
  /// **'Dental Estetik Center'**
  String get place_dental_estetik_center_name;

  /// No description provided for @place_dental_estetik_center_desc.
  ///
  /// In ar, this message translates to:
  /// **'تأسس عام 1993، متخصص في خدمات طب الأسنان التجميلية والعلاجية المتقدمة.'**
  String get place_dental_estetik_center_desc;

  /// No description provided for @place_elos_klinik_name.
  ///
  /// In ar, this message translates to:
  /// **'Elos Klinik'**
  String get place_elos_klinik_name;

  /// No description provided for @place_elos_klinik_desc.
  ///
  /// In ar, this message translates to:
  /// **'متخصص في زراعة الشعر، العلاج بالخلايا الجذعية، وشفط الدهون.'**
  String get place_elos_klinik_desc;

  /// No description provided for @place_dr_emin_eren_clinic_name.
  ///
  /// In ar, this message translates to:
  /// **'Dr. Emin Eren Clinic'**
  String get place_dr_emin_eren_clinic_name;

  /// No description provided for @place_dr_emin_eren_clinic_desc.
  ///
  /// In ar, this message translates to:
  /// **'متخصص في الجراحات التجميلية مثل تجميل الأنف.'**
  String get place_dr_emin_eren_clinic_desc;

  /// No description provided for @place_genclik_parki_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Gençlik Parkı'**
  String get place_genclik_parki_new_name;

  /// No description provided for @place_genclik_parki_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'حديقة تاريخية كبيرة في أولوس، تضم بحيرة اصطناعية وملاهي كبيرة (Luna Park) ومسارح. تعتبر رمزاً للعصر الجمهوري ومكاناً رئيسياً للترفيه.'**
  String get place_genclik_parki_new_desc;

  /// No description provided for @place_kugulu_park_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Kuğulu Park'**
  String get place_kugulu_park_new_name;

  /// No description provided for @place_kugulu_park_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'أشهر حديقة صغيرة في أنقرة، تقع في شارع \"تونالي حلمي\". مشهورة بالبجع والهدوء وسط زحام المدينة.'**
  String get place_kugulu_park_new_desc;

  /// No description provided for @place_segmenler_parki_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Seğmenler Parkı'**
  String get place_segmenler_parki_new_name;

  /// No description provided for @place_segmenler_parki_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'حديقة شاسعة وجميلة جدا بالقرب من السفارات. يفضلها الشباب والطلاب للتجمعات والجلوس على العشب.'**
  String get place_segmenler_parki_new_desc;

  /// No description provided for @place_eymir_golu_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Eymir Gölü'**
  String get place_eymir_golu_new_name;

  /// No description provided for @place_eymir_golu_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'بحيرة طبيعية تابعة لجامعة الشرق الأوسط التقنية، تعتبر ملاذاً رائعاً لممارسة الرياضة والمشي بعيداً عن ضجيج المدينة.'**
  String get place_eymir_golu_new_desc;

  /// No description provided for @place_goksu_parki_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Göksu Parkı'**
  String get place_goksu_parki_new_name;

  /// No description provided for @place_goksu_parki_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'من أكبر المناطق الترفيهية في أنقرة، تم تحويلها من منجم رمل قديم إلى منطقة سياحية رائعة ببحيرة اصطناعية ضخمة.'**
  String get place_goksu_parki_new_desc;

  /// No description provided for @place_mogan_parki_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Mogan Parkı (Lake Mogan)'**
  String get place_mogan_parki_new_name;

  /// No description provided for @place_mogan_parki_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'بحيرة طبيعية في منطقة غولباشي، تعتبر مقصداً رئيسياً للعائلات لممارسة الشواء والتمتع بالمناظر الخلابة والأنشطة المائية.'**
  String get place_mogan_parki_new_desc;

  /// No description provided for @place_altinpark_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Altınpark'**
  String get place_altinpark_new_name;

  /// No description provided for @place_altinpark_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'مجمع ترفيهي ضخم يضم معارض، حدائق، ومراكز علمية. يعتبر وجهة مثالية للعائلات والطلاب.'**
  String get place_altinpark_new_desc;

  /// No description provided for @place_harikalar_diyari_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Harikalar Diyarı (Wonderland)'**
  String get place_harikalar_diyari_new_name;

  /// No description provided for @place_harikalar_diyari_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'واحدة من أكبر حدائق الألعاب والترفيه في أوروبا، تتميز بمجسمات ضخمة لشخصيات القصص الخيالية.'**
  String get place_harikalar_diyari_new_desc;

  /// No description provided for @place_ataturk_cocuklari_parki_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Atatürk Çocukları ve Doğal Yaşam Parkı'**
  String get place_ataturk_cocuklari_parki_new_name;

  /// No description provided for @place_ataturk_cocuklari_parki_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'حديقة حديثة جداً تقع في أرض مزرعة أتاتورك، تضم مساحات خضراء شاسعة وحديقة حيوان رقمية فريدة.'**
  String get place_ataturk_cocuklari_parki_new_desc;

  /// No description provided for @place_botanik_parki_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Botanik Parkı'**
  String get place_botanik_parki_new_name;

  /// No description provided for @place_botanik_parki_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'حديقة هادئة وجميلة تحت برج أتاكولي، تتميز بتنوع النباتات والزهور ومسارات المشي المريحة.'**
  String get place_botanik_parki_new_desc;

  /// No description provided for @place_dikmen_vadisi_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Dikmen Vadisi'**
  String get place_dikmen_vadisi_new_name;

  /// No description provided for @place_dikmen_vadisi_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'أحد أجمل المسارات للمشي والجري في أنقرة، يضم جسوراً بحيرات اصطناعية ومناظر طبيعية خلابة.'**
  String get place_dikmen_vadisi_new_desc;

  /// No description provided for @place_zafer_parki_30_agustos_name.
  ///
  /// In ar, this message translates to:
  /// **'30 Ağustos Zafer Parkı'**
  String get place_zafer_parki_30_agustos_name;

  /// No description provided for @place_zafer_parki_30_agustos_desc.
  ///
  /// In ar, this message translates to:
  /// **'حديقة حديثة هادئة بجانب محطة باصات أنقرة (AŞTİ)، مثالية لركوب الدراجات والنشاط البدني.'**
  String get place_zafer_parki_30_agustos_desc;

  /// No description provided for @place_yildonumu_50_new_name.
  ///
  /// In ar, this message translates to:
  /// **'50. Yıl Parkı'**
  String get place_yildonumu_50_new_name;

  /// No description provided for @place_yildonumu_50_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'تشتهر بكونها \"شرفة أنقرة\"، حيث توفر إطلالة بانورامية كاملة على المدينة من الأعلى.'**
  String get place_yildonumu_50_new_desc;

  /// No description provided for @place_altinkoy_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Altınköy Açık Hava Müzesي'**
  String get place_altinkoy_new_name;

  /// No description provided for @place_altinkoy_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'متحف حي يحاكي حياة القرى الأناضولية القديمة، يضم طواحين هواء وورش عمل للحرف التقليدية.'**
  String get place_altinkoy_new_desc;

  /// No description provided for @place_kurtulus_parki_new_name.
  ///
  /// In ar, this message translates to:
  /// **'Kurtuluş Parkı'**
  String get place_kurtulus_parki_new_name;

  /// No description provided for @place_kurtulus_parki_new_desc.
  ///
  /// In ar, this message translates to:
  /// **'أحد أقدم المنتزهات في وسط المدينة، يتميز بأشجاره الضخمة التي توفر ظلاً عميقاً وقربه من مراكز النقل.'**
  String get place_kurtulus_parki_new_desc;

  /// No description provided for @place_soguksu_milli_parki_name.
  ///
  /// In ar, this message translates to:
  /// **'Soğuksu Milli Parkı'**
  String get place_soguksu_milli_parki_name;

  /// No description provided for @place_soguksu_milli_parki_desc.
  ///
  /// In ar, this message translates to:
  /// **'منتزه وطني بعيد قليلاً عن المركز، يتميز بغابات الصنوبر والمياه المعدنية الحرارية.'**
  String get place_soguksu_milli_parki_desc;

  /// No description provided for @place_ankara_transport_guide_2026_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Ulaşım Rehberi 2026'**
  String get place_ankara_transport_guide_2026_name;

  /// No description provided for @place_ankara_transport_guide_2026_desc.
  ///
  /// In ar, this message translates to:
  /// **'دليل شامل للمواصلات في أنقرة لعام 2026، مصمم خصيصاً للطلاب والمقيمين الجدد لتوفير التكاليف وفهم نظام النقل.'**
  String get place_ankara_transport_guide_2026_desc;

  /// No description provided for @place_migration_management_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara İl Göç İdaresi (Migration Management)'**
  String get place_migration_management_ankara_name;

  /// No description provided for @place_migration_management_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'المؤسسة الأكثر أهمية لإقامتك القانونية. في عام 2026، تحول النظام إلى نموذج \"عبر الجامعة\"، حيث يتم تسليم الملفات لمكتب الطلاب الدوليين في جامعتك.'**
  String get place_migration_management_ankara_desc;

  /// No description provided for @place_yemen_embassy_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Yemen Büyükelçiliği (Yemeni Embassy)'**
  String get place_yemen_embassy_ankara_name;

  /// No description provided for @place_yemen_embassy_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'السفارة اليمنية في أنقرة هي حلقة الوصل مع حكومتك. تضم السفارة الآن \"مركزاً لإصدار الجوازات الآلية\" بنظام البيومتري.'**
  String get place_yemen_embassy_ankara_desc;

  /// No description provided for @place_yok_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Yükseköğretim Kurulu (YÖK)'**
  String get place_yok_ankara_name;

  /// No description provided for @place_yok_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'المجلس الأعلى للتعليم. مسؤول عن معادلة الشهادات والاعتراف بالجامعات الأجنبية.'**
  String get place_yok_ankara_desc;

  /// No description provided for @place_nufus_mudurlugu_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'İl Nüfus ve Vatandaşlık Müdürlüğü'**
  String get place_nufus_mudurlugu_ankara_name;

  /// No description provided for @place_nufus_mudurlugu_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'مديرية النفوس؛ حيث يجب عليك تسجيل عنوان سكنك في السجل الوطني (MERNIS). وهذا مرتبط بصلاحية إقامتك وعملياتك البنكية.'**
  String get place_nufus_mudurlugu_ankara_desc;

  /// No description provided for @place_sgk_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Sosyal Güvenlik Kurumu (SGK)'**
  String get place_sgk_ankara_name;

  /// No description provided for @place_sgk_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'مؤسسة الضمان الاجتماعي؛ تقدم التأمين الصحي العام (GSS) وهو أشمل تأمين حكومي في تركيا.'**
  String get place_sgk_ankara_desc;

  /// No description provided for @place_tax_office_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Vergi Dairesi (Tax Office)'**
  String get place_tax_office_ankara_name;

  /// No description provided for @place_tax_office_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'مكتب الضرائب؛ ستحتاج إليه للحصول على رقم ضريبي تركي (Vergi Numarası) وهو ضروري لفتح حساب بنكي ودفع الرسوم.'**
  String get place_tax_office_ankara_desc;

  /// No description provided for @place_yemeni_student_gov_checklist_name.
  ///
  /// In ar, this message translates to:
  /// **'ملخص المعاملات الحكومية للطلاب اليمنيين 2026'**
  String get place_yemeni_student_gov_checklist_name;

  /// No description provided for @place_yemeni_student_gov_checklist_desc.
  ///
  /// In ar, this message translates to:
  /// **'قائمة مرجعية سريعة للخطوات القانونية الأساسية التي يجب على الطالب اليمني اتباعها فور وصوله إلى أنقرة.'**
  String get place_yemeni_student_gov_checklist_desc;

  /// No description provided for @place_ankamall_full_name.
  ///
  /// In ar, this message translates to:
  /// **'ANKAmall'**
  String get place_ankamall_full_name;

  /// No description provided for @place_ankamall_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'يُعرف بـ \"مركز تسوق تركيا\" وهوتاني أكبر مول في البلاد بمساحة 278,000 متر مربع. يضم أكثر من 330 علامة تجارية عالمية مثل Zara وH&M وDecathlon.'**
  String get place_ankamall_full_desc;

  /// No description provided for @place_armada_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Armada Shopping & Business'**
  String get place_armada_full_name;

  /// No description provided for @place_armada_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'مجمع حائز على جوائز معروف بـ \"شارع أرمادا\"، وهو زقاق مفتوح من المطاعم والمقاهي يربط بين كتل البيع بالتجزئة والمكاتب.'**
  String get place_armada_full_desc;

  /// No description provided for @place_panora_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Panora Shopping Center'**
  String get place_panora_full_name;

  /// No description provided for @place_panora_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'يتميز بأكبر قبة زجاجية في تركيا، وفسيفساء ضخمة لخريطة بيري ريس، وحوض أسماك متكامل.'**
  String get place_panora_full_desc;

  /// No description provided for @place_atakule_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Atakule'**
  String get place_atakule_full_name;

  /// No description provided for @place_atakule_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'معلم المدينة الشهير ببرج مراقبة يبلغ ارتفاعه 125 متراً ومطعم دوار، ويضم قاعدة تجارية حديثة جداً.'**
  String get place_atakule_full_desc;

  /// No description provided for @place_bilkent_center_name.
  ///
  /// In ar, this message translates to:
  /// **'Bilkent Center'**
  String get place_bilkent_center_name;

  /// No description provided for @place_bilkent_center_desc.
  ///
  /// In ar, this message translates to:
  /// **'مركز حياة يقع بالقرب من جامعة بيلكنت، معروف باستضافة المهرجانات الفنية والفنانين التشكيليين.'**
  String get place_bilkent_center_desc;

  /// No description provided for @place_kentpark_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Kentpark'**
  String get place_kentpark_full_name;

  /// No description provided for @place_kentpark_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'معروف بتصميمه في الهواء الطلق، ومركز اللياقة البدنية الكبير، والهندسة المعمارية الصناعية الحديثة.'**
  String get place_kentpark_full_desc;

  /// No description provided for @place_cepa_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Cepa'**
  String get place_cepa_full_name;

  /// No description provided for @place_cepa_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'مجاور مباشرة لمول كنت بارك، معروف بمزيجه العملي من العلامات التجارية المتنوعة وتراسه الشعبي.'**
  String get place_cepa_full_desc;

  /// No description provided for @place_gordion_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Gordion'**
  String get place_gordion_full_name;

  /// No description provided for @place_gordion_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'أول \"مبنى أخضر\" معتمد في أنقرة، يخدم منطقة تشايولو (Çayyolu).'**
  String get place_gordion_full_desc;

  /// No description provided for @place_arcadium_name.
  ///
  /// In ar, this message translates to:
  /// **'Arcadium'**
  String get place_arcadium_name;

  /// No description provided for @place_arcadium_desc.
  ///
  /// In ar, this message translates to:
  /// **'مول يركز على المجتمع في تشايولو، معروف بجوه \"المخلص\" وفعاليات الموسيقى الحية.'**
  String get place_arcadium_desc;

  /// No description provided for @place_kizilay_avm_name.
  ///
  /// In ar, this message translates to:
  /// **'Kızılay AVM'**
  String get place_kizilay_avm_name;

  /// No description provided for @place_kizilay_avm_desc.
  ///
  /// In ar, this message translates to:
  /// **'يقع في قلب المدينة تماماً (ساحة كيزيلاي). صغير الحجم ولكنه يشهد حركة مرور كثيفة جداً.'**
  String get place_kizilay_avm_desc;

  /// No description provided for @place_acity_outlet_name.
  ///
  /// In ar, this message translates to:
  /// **'ACity Outlet'**
  String get place_acity_outlet_name;

  /// No description provided for @place_acity_outlet_desc.
  ///
  /// In ar, this message translates to:
  /// **'مركز أوتليت كبير على طريق إسطنبول مع مسرح على السطح وصالة طعام واسعة.'**
  String get place_acity_outlet_desc;

  /// No description provided for @place_forum_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Forum Ankara Outlet'**
  String get place_forum_ankara_name;

  /// No description provided for @place_forum_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'أكبر مركز أوتليت في المدينة، يقع في منطقة كيتشي أورين (Keçiören).'**
  String get place_forum_ankara_desc;

  /// No description provided for @place_antares_mall_name.
  ///
  /// In ar, this message translates to:
  /// **'Antares'**
  String get place_antares_mall_name;

  /// No description provided for @place_antares_mall_desc.
  ///
  /// In ar, this message translates to:
  /// **'يتميز بسقف زجاجي ضخم، وصالة بولينج، و10 شاشات سينما.'**
  String get place_antares_mall_desc;

  /// No description provided for @place_nata_vega_name.
  ///
  /// In ar, this message translates to:
  /// **'Nata Vega'**
  String get place_nata_vega_name;

  /// No description provided for @place_nata_vega_desc.
  ///
  /// In ar, this message translates to:
  /// **'يحتوي على \"أكوا فيجا\"، أحد أكبر الأحواض المائية في تركيا، بالإضافة إلى متجر ايكيا (IKEA).'**
  String get place_nata_vega_desc;

  /// No description provided for @place_anatolium_ankara_name.
  ///
  /// In ar, this message translates to:
  /// **'Anatolium'**
  String get place_anatolium_ankara_name;

  /// No description provided for @place_anatolium_ankara_desc.
  ///
  /// In ar, this message translates to:
  /// **'يقع بجانب ناتا فيجا، ويركز على السلع المنزلية والتجزئة العملية.'**
  String get place_anatolium_ankara_desc;

  /// No description provided for @place_taurus_mall_name.
  ///
  /// In ar, this message translates to:
  /// **'Taurus'**
  String get place_taurus_mall_name;

  /// No description provided for @place_taurus_mall_desc.
  ///
  /// In ar, this message translates to:
  /// **'يُعرف بتراسه الكبير وسهولة الوصول إليه في منطقة تشانكايا.'**
  String get place_taurus_mall_desc;

  /// No description provided for @place_podium_mall_name.
  ///
  /// In ar, this message translates to:
  /// **'Podium'**
  String get place_podium_mall_name;

  /// No description provided for @place_podium_mall_desc.
  ///
  /// In ar, this message translates to:
  /// **'معروف بـ \"القيمة العالية للمال\" ومنطقة خارجية كبيرة مع بركة مائية.'**
  String get place_podium_mall_desc;

  /// No description provided for @place_next_level_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Next Level'**
  String get place_next_level_full_name;

  /// No description provided for @place_next_level_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'مركز حياة فاخر يضم معرضاً فنياً وتراساً خارجياً مميزاً.'**
  String get place_next_level_full_desc;

  /// No description provided for @place_tepe_prime_name.
  ///
  /// In ar, this message translates to:
  /// **'Tepe Prime'**
  String get place_tepe_prime_name;

  /// No description provided for @place_tepe_prime_desc.
  ///
  /// In ar, this message translates to:
  /// **'ساحة فاخرة في الهواء الطلق مشهورة بالحياة الليلية والمطاعم والحفلات الموسيقية.'**
  String get place_tepe_prime_desc;

  /// No description provided for @place_karum_mall_name.
  ///
  /// In ar, this message translates to:
  /// **'Karum'**
  String get place_karum_mall_name;

  /// No description provided for @place_karum_mall_desc.
  ///
  /// In ar, this message translates to:
  /// **'واحد من أقدم المولات، يقع في منطقة البعثات الدبلوماسية (Gaziosmanpaşa) مع أجواء خضراء.'**
  String get place_karum_mall_desc;

  /// No description provided for @place_atlantis_mall_name.
  ///
  /// In ar, this message translates to:
  /// **'Atlantis'**
  String get place_atlantis_mall_name;

  /// No description provided for @place_atlantis_mall_desc.
  ///
  /// In ar, this message translates to:
  /// **'يقع في منطقة \"باتيكنت\" (Batıkent)؛ ويضم مدينة ملاهي \"Joy Land\" ومنطقة مائية.'**
  String get place_atlantis_mall_desc;

  /// No description provided for @place_galleria_mall_name.
  ///
  /// In ar, this message translates to:
  /// **'Galleria'**
  String get place_galleria_mall_name;

  /// No description provided for @place_galleria_mall_desc.
  ///
  /// In ar, this message translates to:
  /// **'مول قديم في منطقة \"أوميتكوي\" (Ümitköy)، تم تجديده مؤخراً.'**
  String get place_galleria_mall_desc;

  /// No description provided for @place_optimum_outlet_name.
  ///
  /// In ar, this message translates to:
  /// **'Optimum Outlet'**
  String get place_optimum_outlet_name;

  /// No description provided for @place_optimum_outlet_desc.
  ///
  /// In ar, this message translates to:
  /// **'مفهوم أوتليت ضخم يقع في منطقة \"إريامان\" (Eryaman).'**
  String get place_optimum_outlet_desc;

  /// No description provided for @place_ftz_mall_name.
  ///
  /// In ar, this message translates to:
  /// **'FTZ'**
  String get place_ftz_mall_name;

  /// No description provided for @place_ftz_mall_desc.
  ///
  /// In ar, this message translates to:
  /// **'يقع في منطقة كيتشي أورين (Keçiören)؛ ويتميز بوجود محاكي للقفز المظلي وسينما.'**
  String get place_ftz_mall_desc;

  /// No description provided for @place_365_mall_name.
  ///
  /// In ar, this message translates to:
  /// **'365 Shopping Mall'**
  String get place_365_mall_name;

  /// No description provided for @place_365_mall_desc.
  ///
  /// In ar, this message translates to:
  /// **'مول عملي أصغر حجماً في تشانكايا (Çankaya).'**
  String get place_365_mall_desc;

  /// No description provided for @place_one_tower_mall_name.
  ///
  /// In ar, this message translates to:
  /// **'One Tower'**
  String get place_one_tower_mall_name;

  /// No description provided for @place_one_tower_mall_desc.
  ///
  /// In ar, this message translates to:
  /// **'يقع في منطقة دوران (Oran)، مع التركيز على المطاعم والعلامات التجارية الراقية.'**
  String get place_one_tower_mall_desc;

  /// No description provided for @place_anatolian_civil_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'Anadolu Medeniyetleri Müzesi'**
  String get place_anatolian_civil_museum_name;

  /// No description provided for @place_anatolian_civil_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'متحف حائز على جوائز يضم قطعاً أثرية من العصر الحجري القديم إلى العصور الكلاسيكية. يجب زيارته لكل مهتم بالتاريخ.'**
  String get place_anatolian_civil_museum_desc;

  /// No description provided for @place_anitkabir_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Anıtkabir'**
  String get place_anitkabir_full_name;

  /// No description provided for @place_anitkabir_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'ضريح مؤسس الجمهورية، مصطفى كمال أتاتورك، ومتحف حرب الاستقلال.'**
  String get place_anitkabir_full_desc;

  /// No description provided for @place_ethnography_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Etnografya Müzesi'**
  String get place_ethnography_museum_name;

  /// No description provided for @place_ethnography_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'أول متحف في الجمهورية، يتميز بعرشه السلجوقي والفن الشعبي التركي.'**
  String get place_ethnography_museum_desc;

  /// No description provided for @place_rahmi_koc_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'Rahmi M. Koç Müzesi'**
  String get place_rahmi_koc_museum_name;

  /// No description provided for @place_rahmi_koc_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الصناعة في خانات تاريخية مرممة (Çengelhan/Safranhan).'**
  String get place_rahmi_koc_museum_desc;

  /// No description provided for @place_ulucanlar_prison_name.
  ///
  /// In ar, this message translates to:
  /// **'Ulucanlar Cezaevi Müzesi'**
  String get place_ulucanlar_prison_name;

  /// No description provided for @place_ulucanlar_prison_desc.
  ///
  /// In ar, this message translates to:
  /// **'سجن سابق يضم تماثيل شمعية للمعتقلين السياسيين وزنازين العزل.'**
  String get place_ulucanlar_prison_desc;

  /// No description provided for @place_erimtan_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'Erimtan Arkeoloji ve Sanat Müzesi'**
  String get place_erimtan_museum_name;

  /// No description provided for @place_erimtan_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'مجموعة خاصة من الزجاج والمجوهرات والعملات الرومانية.'**
  String get place_erimtan_museum_desc;

  /// No description provided for @place_cermodern_name.
  ///
  /// In ar, this message translates to:
  /// **'CerModern'**
  String get place_cermodern_name;

  /// No description provided for @place_cermodern_desc.
  ///
  /// In ar, this message translates to:
  /// **'مركز للفنون الحديثة في مستودع قطارات تم تجديده.'**
  String get place_cermodern_desc;

  /// No description provided for @place_first_parliament_name.
  ///
  /// In ar, this message translates to:
  /// **'Kurtuluş Savaşı Müzesi (I. TBMM)'**
  String get place_first_parliament_name;

  /// No description provided for @place_first_parliament_desc.
  ///
  /// In ar, this message translates to:
  /// **'مبنى البرلمان الأصلي لعام 1920.'**
  String get place_first_parliament_desc;

  /// No description provided for @place_republic_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'Cumhuriyet Müzesi (II. TBMM)'**
  String get place_republic_museum_name;

  /// No description provided for @place_republic_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'حيث تم توطيد أركان الجمهورية (استخدم حتى عام 1960).'**
  String get place_republic_museum_desc;

  /// No description provided for @place_state_art_sculpture_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Resim ve Heykel Müzesi'**
  String get place_state_art_sculpture_name;

  /// No description provided for @place_state_art_sculpture_desc.
  ///
  /// In ar, this message translates to:
  /// **'عمارة رائعة؛ يضم لوحات ومنحوتات تركية كبرى.'**
  String get place_state_art_sculpture_desc;

  /// No description provided for @place_gordion_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'Gordion Müzesي'**
  String get place_gordion_museum_name;

  /// No description provided for @place_gordion_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'يقع في بولاتلي؛ يضم قبر الملك ميداس الشهير.'**
  String get place_gordion_museum_desc;

  /// No description provided for @place_roman_baths_name.
  ///
  /// In ar, this message translates to:
  /// **'Roma Hamamı'**
  String get place_roman_baths_name;

  /// No description provided for @place_roman_baths_desc.
  ///
  /// In ar, this message translates to:
  /// **'أطلال قديمة لمجمع حمامات روماني.'**
  String get place_roman_baths_desc;

  /// No description provided for @place_altinkoy_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'Altınköy Açık Hava Müzesi'**
  String get place_altinkoy_museum_name;

  /// No description provided for @place_altinkoy_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'يعيد خلق الحياة القروية التقليدية مع بيوت خشبية وطواحين هواء.'**
  String get place_altinkoy_museum_desc;

  /// No description provided for @place_mta_natural_history_name.
  ///
  /// In ar, this message translates to:
  /// **'MTA Şehit Cuma Dağ Tabiat Tarihi Müzesi'**
  String get place_mta_natural_history_name;

  /// No description provided for @place_mta_natural_history_desc.
  ///
  /// In ar, this message translates to:
  /// **'الجيولوجيا والديناصورات وعلم الحفريات.'**
  String get place_mta_natural_history_desc;

  /// No description provided for @place_ankara_vakif_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'Ankara Vakıf Eserleri Müzesi'**
  String get place_ankara_vakif_museum_name;

  /// No description provided for @place_ankara_vakif_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'يعرض السجاد والمنسوجات وأعمال المؤسسات الخيرية القديمة.'**
  String get place_ankara_vakif_museum_desc;

  /// No description provided for @place_july_15_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'15 Temmuz Şehitler ve Demokrasi Müzesi'**
  String get place_july_15_museum_name;

  /// No description provided for @place_july_15_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'متحف حديث مخصص لـ \"ملحمة الديمقراطية\" (أحداث 15 تموز).'**
  String get place_july_15_museum_desc;

  /// No description provided for @place_haci_bayram_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Hacı Bayram Veli Mosque & Tomb'**
  String get place_haci_bayram_full_name;

  /// No description provided for @place_haci_bayram_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'مركز روحي وتاريخي هام في أنقرة. يقع بجانبه \"معبد أغسطس\" الروماني، مما يمثل تلاقي الحضارات. المنطقة المحيطة بها (Hamamönü) تم ترميمها وأصبحت جميلة جدا للتمشي والتسوق التقليدي.'**
  String get place_haci_bayram_full_desc;

  /// No description provided for @place_kocatepe_mosque_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Kocatepe Mosque'**
  String get place_kocatepe_mosque_full_name;

  /// No description provided for @place_kocatepe_mosque_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'أكبر مسجد في أنقرة، يقع في منطقة كبزلاي. هندسته المعمارية رائعة ويظهر من أماكن كثيرة في المدينة. يعتبر نقطة التقاء ومركز إشعاع ثقافي.'**
  String get place_kocatepe_mosque_full_desc;

  /// No description provided for @place_augustus_temple_name.
  ///
  /// In ar, this message translates to:
  /// **'Augustus Tapınağı'**
  String get place_augustus_temple_name;

  /// No description provided for @place_augustus_temple_desc.
  ///
  /// In ar, this message translates to:
  /// **'أطلال معبد روماني به نقش لأعمال الإمبراطور أغسطس.'**
  String get place_augustus_temple_desc;

  /// No description provided for @place_feza_gursey_center_name.
  ///
  /// In ar, this message translates to:
  /// **'Feza Gürsey Bilim Merkezi'**
  String get place_feza_gursey_center_name;

  /// No description provided for @place_feza_gursey_center_desc.
  ///
  /// In ar, this message translates to:
  /// **'مركز علوم تفاعلي يوفر معارض علمية تطبيقية.'**
  String get place_feza_gursey_center_desc;

  /// No description provided for @place_metu_science_tech_name.
  ///
  /// In ar, this message translates to:
  /// **'ODTÜ Bilim ve Teknoloji Müzesi'**
  String get place_metu_science_tech_name;

  /// No description provided for @place_metu_science_tech_desc.
  ///
  /// In ar, this message translates to:
  /// **'يقع داخل حرم جامعة الشرق الأوسط التقنية.'**
  String get place_metu_science_tech_desc;

  /// No description provided for @place_meiif_er_soy_lit_name.
  ///
  /// In ar, this message translates to:
  /// **'Mehmet Akif Ersoy Edebiyat Müzesi'**
  String get place_meiif_er_soy_lit_name;

  /// No description provided for @place_meiif_er_soy_lit_desc.
  ///
  /// In ar, this message translates to:
  /// **'مخصص لشاعر النشيد الوطني التركي.'**
  String get place_meiif_er_soy_lit_desc;

  /// No description provided for @place_mit_espionage_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'MİT İstihbarat Müzesi'**
  String get place_mit_espionage_museum_name;

  /// No description provided for @place_mit_espionage_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ المخابرات التركية وأدوات التجسس.'**
  String get place_mit_espionage_museum_desc;

  /// No description provided for @place_tcdd_steam_loco_name.
  ///
  /// In ar, this message translates to:
  /// **' TCDD Açık Hava Buharlı Lokomotif Müzesi'**
  String get place_tcdd_steam_loco_name;

  /// No description provided for @place_tcdd_steam_loco_desc.
  ///
  /// In ar, this message translates to:
  /// **'قرب محطة القطار؛ عرض للقاطرات البخارية القديمة.'**
  String get place_tcdd_steam_loco_desc;

  /// No description provided for @place_ataturk_mansion_name.
  ///
  /// In ar, this message translates to:
  /// **'Atatürk Müze Köşkü'**
  String get place_ataturk_mansion_name;

  /// No description provided for @place_ataturk_mansion_desc.
  ///
  /// In ar, this message translates to:
  /// **'يقع داخل الأراضي الرئاسية في تشانكايا وهو منزل أتاتورك.'**
  String get place_ataturk_mansion_desc;

  /// No description provided for @place_pembe_kosk_name.
  ///
  /// In ar, this message translates to:
  /// **'Pembe Köşk (İsmet İnönü House)'**
  String get place_pembe_kosk_name;

  /// No description provided for @place_pembe_kosk_desc.
  ///
  /// In ar, this message translates to:
  /// **'متحف منزل تاريخي يعود للرئيس الثاني لتركيا.'**
  String get place_pembe_kosk_desc;

  /// No description provided for @place_isbank_museum_ank_name.
  ///
  /// In ar, this message translates to:
  /// **'Türkiye İş Bankası Müzesi'**
  String get place_isbank_museum_ank_name;

  /// No description provided for @place_isbank_museum_ank_desc.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الاقتصاد والمصارف في تركيا.'**
  String get place_isbank_museum_ank_desc;

  /// No description provided for @place_thk_aeronautical_name.
  ///
  /// In ar, this message translates to:
  /// **'Türk Hava Kurumu Müzesi'**
  String get place_thk_aeronautical_name;

  /// No description provided for @place_thk_aeronautical_desc.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ الطيران التركي وتاريخ القفز بالمظلات.'**
  String get place_thk_aeronautical_desc;

  /// No description provided for @place_stamp_museum_ank_name.
  ///
  /// In ar, this message translates to:
  /// **'PTT Pul Müzesي'**
  String get place_stamp_museum_ank_name;

  /// No description provided for @place_stamp_museum_ank_desc.
  ///
  /// In ar, this message translates to:
  /// **'متحف مخصص لتاريخ الطوابع والبريد.'**
  String get place_stamp_museum_ank_desc;

  /// No description provided for @place_gokyay_chess_museum_name.
  ///
  /// In ar, this message translates to:
  /// **'Gökyay Vakfı Satranç Müzesi'**
  String get place_gokyay_chess_museum_name;

  /// No description provided for @place_gokyay_chess_museum_desc.
  ///
  /// In ar, this message translates to:
  /// **'أكبر مجموعة لمجموعات الشطرنج في العالم.'**
  String get place_gokyay_chess_museum_desc;

  /// No description provided for @place_trt_publishing_history_name.
  ///
  /// In ar, this message translates to:
  /// **'TRT Yayıncılık Tarihi Müzesي'**
  String get place_trt_publishing_history_name;

  /// No description provided for @place_trt_publishing_history_desc.
  ///
  /// In ar, this message translates to:
  /// **'تاريخ البث والإعلام في تركيا عبر مؤسسة TRT.'**
  String get place_trt_publishing_history_desc;

  /// No description provided for @place_presidential_library_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Cumhurbaşkanlığı Millet Kütüphanesi'**
  String get place_presidential_library_full_name;

  /// No description provided for @place_presidential_library_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'أكبر مكتبة في تركيا (125,000 متر مربع) تضم 4 ملايين كتاب مطبوع وقاعة \"Cihannüma\" الشهيرة.'**
  String get place_presidential_library_full_desc;

  /// No description provided for @place_national_library_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Millî Kütüphane'**
  String get place_national_library_full_name;

  /// No description provided for @place_national_library_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'المكتبة القانونية التي تحتفظ بنسخة من كل عمل نُشر في تركيا. تحتوي على أرشيف أتاتورك وسجلات نادرة.'**
  String get place_national_library_full_desc;

  /// No description provided for @place_bilkent_library_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Bilkent Üniversitesi Kütüphanesi'**
  String get place_bilkent_library_full_name;

  /// No description provided for @place_bilkent_library_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'أغنى مكتبة جامعية، تضم مجموعة خليل إينالجيك وأقساماً ضخمة للفنون والموسيقى.'**
  String get place_bilkent_library_full_desc;

  /// No description provided for @place_ttk_library_full_name.
  ///
  /// In ar, this message translates to:
  /// **'Türk Tarih Kurumu Kütüphanesi'**
  String get place_ttk_library_full_name;

  /// No description provided for @place_ttk_library_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'متخصصة في التاريخ والأرشيف. في عام 2026، وسعت الوصول إلى 50,000 كتاب إلكتروني مجاني.'**
  String get place_ttk_library_full_desc;

  /// No description provided for @place_yok_thesis_center_name.
  ///
  /// In ar, this message translates to:
  /// **'YÖK Ulusal Tez Merkezi'**
  String get place_yok_thesis_center_name;

  /// No description provided for @place_yok_thesis_center_desc.
  ///
  /// In ar, this message translates to:
  /// **'المستودع المركزي لجميع أطروحات الماجستير والدكتوراه التي تمت مناقشتها في تركيا.'**
  String get place_yok_thesis_center_desc;

  /// No description provided for @place_tbmm_library_full_name.
  ///
  /// In ar, this message translates to:
  /// **'TBMM Kütüphanesi'**
  String get place_tbmm_library_full_name;

  /// No description provided for @place_tbmm_library_full_desc.
  ///
  /// In ar, this message translates to:
  /// **'متخصصة في العلوم السياسية والقانون، ومجموعة واسعة من الصحف والدوريات التاريخية.'**
  String get place_tbmm_library_full_desc;

  /// No description provided for @place_metu_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'التميز الهندسي والمعماري، جامعة تقنية رائدة، التعليم باللغة الإنجليزية.'**
  String get place_metu_uni_knownFor;

  /// No description provided for @place_hacettepe_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'الرائدة في تعليم الطب والعلوم الصحية، أعلى تأثير بحثي وطني.'**
  String get place_hacettepe_uni_knownFor;

  /// No description provided for @place_ankara_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'أول جامعة في الجمهورية، متميزة في الحقوق والعلوم السياسية (Mülkiye) والطب.'**
  String get place_ankara_uni_knownFor;

  /// No description provided for @place_gazi_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'تدريب المعلمين، الهندسة، التكنولوجيا؛ تكامل قوي مع الصناعة.'**
  String get place_gazi_uni_knownFor;

  /// No description provided for @place_aybu_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'التعليم باللغة الإنجليزية، الطب والهندسة، نسبة عالية من الطلاب الدوليين.'**
  String get place_aybu_uni_knownFor;

  /// No description provided for @place_haci_bayram_veli_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'العلوم الاجتماعية، الفنون، السياحة (فن الطهي)، القانون.'**
  String get place_haci_bayram_veli_knownFor;

  /// No description provided for @place_asbu_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'متخصصة في العلوم الاجتماعية، موجهة للبحث؛ القانون، العلوم السياسية، الدراسات الإسلامية.'**
  String get place_asbu_uni_knownFor;

  /// No description provided for @place_mgu_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'جامعة تخصصية للموسيقى والفنون الجميلة.'**
  String get place_mgu_uni_knownFor;

  /// No description provided for @place_bilkent_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'أول جامعة خاصة، أبحاث بمستوى عالمي، الهندسة والاقتصاد.'**
  String get place_bilkent_uni_knownFor;

  /// No description provided for @place_cankaya_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'تأثير بحثي عالٍ، الهندسة، العمارة، القانون.'**
  String get place_cankaya_uni_knownFor;

  /// No description provided for @place_tobb_etu_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'نموذج التعليم التعاوني (تدريب إلزامي)، علاقات قوية مع قطاع الأعمال.'**
  String get place_tobb_etu_knownFor;

  /// No description provided for @place_atilim_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'الطيران المدني، الهندسة، الإنتاجية البحثية.'**
  String get place_atilim_uni_knownFor;

  /// No description provided for @place_baskent_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'أول جامعة صحية خاصة، الطب وطب الأسنان، شبكة مستشفيات واسعة.'**
  String get place_baskent_uni_knownFor;

  /// No description provided for @place_tedu_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'نموذج الفنون الليبرالية، العمارة والتعليم، التركيز على المهارات الناعمة.'**
  String get place_tedu_uni_knownFor;

  /// No description provided for @place_ostim_tech_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'نموذج الجامعة الصناعية، التدريب العملي وريادة الأعمال.'**
  String get place_ostim_tech_knownFor;

  /// No description provided for @place_lokman_hekim_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'متخصصة في الصحة؛ الطب، الصيدلة، العلوم الرياضية.'**
  String get place_lokman_hekim_knownFor;

  /// No description provided for @place_medipol_ankara_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'العلوم الصحية، مرافق حديثة، الطب وطب الأسنان.'**
  String get place_medipol_ankara_knownFor;

  /// No description provided for @place_thk_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'التخصص في الطيران والفضاء، تدريب الطيارين.'**
  String get place_thk_uni_knownFor;

  /// No description provided for @place_ufuk_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'الطب، القانون، التربية.'**
  String get place_ufuk_uni_knownFor;

  /// No description provided for @place_yuksek_ihtisas_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'تخصص العلوم الصحية، الطب والتمريض.'**
  String get place_yuksek_ihtisas_knownFor;

  /// No description provided for @place_ankara_bilim_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'هندسة البرمجيات، التصميم، أهداف التنمية المستدامة.'**
  String get place_ankara_bilim_knownFor;

  /// No description provided for @place_health_sciences_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'التعليم الطبي، كانت سابقاً أكاديمية جولهانه الطبية العسكرية (GATA)؛ الطب، طب الأسنان، التمريض.'**
  String get place_health_sciences_uni_knownFor;

  /// No description provided for @place_police_academy_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'تدريب ضباط الشرطة، الاستراتيجيات الأمنية، تحليل الجريمة، الاستخبارات.'**
  String get place_police_academy_knownFor;

  /// No description provided for @place_national_defense_uni_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'تدريب الضباط؛ الهندسة، العلوم الاجتماعية، الإدارة.'**
  String get place_national_defense_uni_knownFor;

  /// No description provided for @place_medical_advice_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'دليل أساسي للطلاب والمغتربين.'**
  String get place_medical_advice_knownFor;

  /// No description provided for @place_bilkent_city_hosp_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'جراحة القلب والأوعية الدموية، الأعصاب، الأورام؛ سعة عالمية.'**
  String get place_bilkent_city_hosp_knownFor;

  /// No description provided for @place_hacettepe_uni_hosp_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'التشخيصات الصعبة، زراعة الأعضاء، الأورام؛ رائد في اعتماد JCI.'**
  String get place_hacettepe_uni_hosp_knownFor;

  /// No description provided for @place_ankara_uni_hosp_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'الطب الباطني، الجراحة، وعلم الدم؛ مستشفى تعليمي رئيسي.'**
  String get place_ankara_uni_hosp_knownFor;

  /// No description provided for @place_gazi_uni_hosp_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'الإصابات، الرعاية الطارئة، والعلاجات الجراحية المتقدمة.'**
  String get place_gazi_uni_hosp_knownFor;

  /// No description provided for @place_gulhane_hosp_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'إعادة التأهيل، رعاية الحروق، أمراض القلب، والأعصاب.'**
  String get place_gulhane_hosp_knownFor;

  /// No description provided for @place_etlik_city_hosp_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'بنية تحتية ذكية، أقسام تخصصية؛ أحدث مستشفى في المدينة.'**
  String get place_etlik_city_hosp_knownFor;

  /// No description provided for @place_acibadem_ankara_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'جراحة العظام، أمراض النساء، الجراحة الروبوتية.'**
  String get place_acibadem_ankara_knownFor;

  /// No description provided for @place_memorial_ankara_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'جراحة القلب والأوعية الدموية، التلقيح الاصطناعي، الأورام، وزراعة نخاع العظام.'**
  String get place_memorial_ankara_knownFor;

  /// No description provided for @place_medicana_ankara_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'زراعة الأعضاء، الأورام (سايبر نايف)، أمراض القلب.'**
  String get place_medicana_ankara_knownFor;

  /// No description provided for @place_guven_hosp_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'خدمات متميزة، تميز في القلب والأوعية الدموية، المفضل دبلوماسياً.'**
  String get place_guven_hosp_knownFor;

  /// No description provided for @place_bayindir_hosp_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'زراعة نخاع العظام، أمراض القلب، وطب الأسنان.'**
  String get place_bayindir_hosp_knownFor;

  /// No description provided for @place_tobb_etu_hosp_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'أمراض العمود الفقري، الجراحة طفيفة التوغل، رعاية كأنك من فئة رجال الأعمال.'**
  String get place_tobb_etu_hosp_knownFor;

  /// No description provided for @place_lokman_hekim_ank_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'جراحة الأعصاب، العظام، ورعاية الأمومة الصديقة للطفل.'**
  String get place_lokman_hekim_ank_knownFor;

  /// No description provided for @place_liv_hosp_ankara_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'الجراحة الروبوتية وجراحة السمنة، علاج السرطان.'**
  String get place_liv_hosp_ankara_knownFor;

  /// No description provided for @place_koru_hosp_ankara_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'جراحة السمنة الروبوتية، التلقيح الاصطناعي، وراحة المرضى.'**
  String get place_koru_hosp_ankara_knownFor;

  /// No description provided for @place_dunyagoz_ankara_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'متخصصون في طب العيون؛ حجم عمليات جراحي كبير.'**
  String get place_dunyagoz_ankara_knownFor;

  /// No description provided for @place_medical_park_ank_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'رعاية شاملة، وتكامل تكنولوجي.'**
  String get place_medical_park_ank_knownFor;

  /// No description provided for @place_dental_estetik_center_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'خدمات طب الأسنان المتقدمة، والتجميل.'**
  String get place_dental_estetik_center_knownFor;

  /// No description provided for @place_elos_klinik_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'زراعة الشعر، العلاج بالخلايا الجذعية، وشفط الدهون.'**
  String get place_elos_klinik_knownFor;

  /// No description provided for @place_dr_emin_eren_clinic_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'الجراحة التجميلية، وتجميل الأنف.'**
  String get place_dr_emin_eren_clinic_knownFor;

  /// No description provided for @place_genclik_parki_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'البحيرة المركزية الضخمة، عروض الأضواء المسائية، مدينة الملاهي الكبيرة، والمركز الثقافي.'**
  String get place_genclik_parki_new_knownFor;

  /// No description provided for @place_genclik_parki_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_genclik_parki_new_entryFee;

  /// No description provided for @place_genclik_parki_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح'**
  String get place_genclik_parki_new_barbecue;

  /// No description provided for @place_genclik_parki_new_history.
  ///
  /// In ar, this message translates to:
  /// **'تأسست في عام 1943 على أرض كانت في السابق مستنقعاً، وهي رمز للعصر الجمهوري صممت لتوفير ترفيه حديث للمواطنين.'**
  String get place_genclik_parki_new_history;

  /// No description provided for @place_kugulu_park_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'البجع الجميل، الأشجار التاريخية، وموقعها في قلب شارع تونالي حلمي الشهير.'**
  String get place_kugulu_park_new_knownFor;

  /// No description provided for @place_kugulu_park_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_kugulu_park_new_entryFee;

  /// No description provided for @place_kugulu_park_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح'**
  String get place_kugulu_park_new_barbecue;

  /// No description provided for @place_kugulu_park_new_history.
  ///
  /// In ar, this message translates to:
  /// **'منطقة طبيعية وتاريخية محمية. البجع الشهير في الحديقة كان في الأصل هدية من مدينة فيينا.'**
  String get place_kugulu_park_new_history;

  /// No description provided for @place_segmenler_parki_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'المسرح المفتوح للحفلات، المساحات الخضراء الواسعة، وكونها مكاناً صديقاً للحيوانات الأليفة في حي تشانكايا.'**
  String get place_segmenler_parki_new_knownFor;

  /// No description provided for @place_segmenler_parki_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_segmenler_parki_new_entryFee;

  /// No description provided for @place_segmenler_parki_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح'**
  String get place_segmenler_parki_new_barbecue;

  /// No description provided for @place_segmenler_parki_new_history.
  ///
  /// In ar, this message translates to:
  /// **'افتتحت في أوائل الثمانينيات، وتضم نصباً تذكارياً مخصصاً لـ \"Seğmenler\" (الراقصين الشعبيين التقليديين).'**
  String get place_segmenler_parki_new_history;

  /// No description provided for @place_eymir_golu_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'مسار بطول 11 كم مثالي لركوب الدراجات والجري، مراقبة الطيور، والهدوء التام.'**
  String get place_eymir_golu_new_knownFor;

  /// No description provided for @place_eymir_golu_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني للمشاة والدرجات. رسوم للسيارات (تتطلب بطاقة جامعة METU أو الدخول بشروط)'**
  String get place_eymir_golu_new_entryFee;

  /// No description provided for @place_eymir_golu_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'ممنوع تماماً (لحماية النظام البيئي)'**
  String get place_eymir_golu_new_barbecue;

  /// No description provided for @place_eymir_golu_new_history.
  ///
  /// In ar, this message translates to:
  /// **'تقع على أرض جامعة الشرق الأوسط التقنية؛ تم تشجيرها في الستينيات من خلال جهود رئيس الجامعة كمال كورداش لتحويل السهوب إلى مساحات خضراء.'**
  String get place_eymir_golu_new_history;

  /// No description provided for @place_goksu_parki_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'الزحليقة الجبلية (Dağ Kızağı)، البحيرة الاصطناعية الكبيرة، ومرافق الشواء الممتازة.'**
  String get place_goksu_parki_new_knownFor;

  /// No description provided for @place_goksu_parki_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_goksu_parki_new_entryFee;

  /// No description provided for @place_goksu_parki_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'مسموح (في الأماكن المخصصة)'**
  String get place_goksu_parki_new_barbecue;

  /// No description provided for @place_goksu_parki_new_history.
  ///
  /// In ar, this message translates to:
  /// **'بنيت على موقع مقلع حجارة سابق وافتتحت في عام 2003، حيث تحولت المنطقة الجافة إلى منطقة ترفيهية ضخمة في غضون أشهر قليلة.'**
  String get place_goksu_parki_new_history;

  /// No description provided for @place_mogan_parki_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'مراقبة الطيور، المسارات الخشبية فوق الماء، المنارة، والنزهات العائلية الكبيرة.'**
  String get place_mogan_parki_new_knownFor;

  /// No description provided for @place_mogan_parki_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني للمشاة؛ رسوم للسيارات (تقريباً 30–50 ليرة)'**
  String get place_mogan_parki_new_entryFee;

  /// No description provided for @place_mogan_parki_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'مسموح (تتوفر مناطق واسعة ومعدات للإيجار)'**
  String get place_mogan_parki_new_barbecue;

  /// No description provided for @place_mogan_parki_new_history.
  ///
  /// In ar, this message translates to:
  /// **'تم تطويرها حول بحيرة ترسبية طبيعية في منطقة غولباشي لتصبح مركز استجمام ضخم.'**
  String get place_mogan_parki_new_history;

  /// No description provided for @place_altinpark_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'مركز فيزا غورسيه للعلوم، القاعات الخاصة بالمعارض، حلبات التزلج، والقوارب في البحيرة.'**
  String get place_altinpark_new_knownFor;

  /// No description provided for @place_altinpark_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني (قد تفرض رسوم على المواقف وبعض المراكز مثل\\nمركز العلوم)'**
  String get place_altinpark_new_entryFee;

  /// No description provided for @place_altinpark_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح'**
  String get place_altinpark_new_barbecue;

  /// No description provided for @place_altinpark_new_history.
  ///
  /// In ar, this message translates to:
  /// **'واحدة من أكبر المناطق الترفيهية في أنقرة، تأسست على مساحة 640 ألف متر مربع.'**
  String get place_altinpark_new_history;

  /// No description provided for @place_harikalar_diyari_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'طابع \"القصص الخيالية\" مع مجسمات ضخمة (مثل غوليفر)، مسارات الكارتينج، والأنشطة العائلية.'**
  String get place_harikalar_diyari_new_knownFor;

  /// No description provided for @place_harikalar_diyari_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_harikalar_diyari_new_entryFee;

  /// No description provided for @place_harikalar_diyari_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'مسموح (تتوفر أماكن مخصصة للنزهات)'**
  String get place_harikalar_diyari_new_barbecue;

  /// No description provided for @place_harikalar_diyari_new_history.
  ///
  /// In ar, this message translates to:
  /// **'تعد واحدة من أكبر المنتزهات الحضرية في أوروبا (1.3 مليون متر مربع)، افتتحت لخدمة منطقة سينجان.'**
  String get place_harikalar_diyari_new_history;

  /// No description provided for @place_ataturk_cocuklari_parki_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'حديقة الحيوان الرقمية (Digital Zoo)، استعادة مجرى نهر أنقرة، والمساحات الخضراء الضخمة (940 ألف متر مربع).'**
  String get place_ataturk_cocuklari_parki_new_knownFor;

  /// No description provided for @place_ataturk_cocuklari_parki_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_ataturk_cocuklari_parki_new_entryFee;

  /// No description provided for @place_ataturk_cocuklari_parki_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح (نزهات بدون دخان)'**
  String get place_ataturk_cocuklari_parki_new_barbecue;

  /// No description provided for @place_ataturk_cocuklari_parki_new_history.
  ///
  /// In ar, this message translates to:
  /// **'بنيت مؤخراً على أرض مزرعة أتاتورك التاريخية (AOÇ)، لاستعادة المنطقة كمتنزه عام بعد إغلاق حديقة أنكابارك المجاروة. افتتحت على مراحل حوالي 2024-2025.'**
  String get place_ataturk_cocuklari_parki_new_history;

  /// No description provided for @place_botanik_parki_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'تصميمها على طراز الحديقة الإنجليزية، إطلالاتها الرائعة على برج أتاكولي، والدفيئة الزجاجية للنباتات.'**
  String get place_botanik_parki_new_knownFor;

  /// No description provided for @place_botanik_parki_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_botanik_parki_new_entryFee;

  /// No description provided for @place_botanik_parki_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح'**
  String get place_botanik_parki_new_barbecue;

  /// No description provided for @place_botanik_parki_new_history.
  ///
  /// In ar, this message translates to:
  /// **'تأسست في عام 1970 من قبل البروفيسور د. يوكسيل أوزتان في وادي تشانكايا.'**
  String get place_botanik_parki_new_history;

  /// No description provided for @place_dikmen_vadisi_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'أطول مسار مشي مستمر في المدينة، جسورها المعلقة، وبراعم أشجار الكرز (Sakura) في الربيع.'**
  String get place_dikmen_vadisi_new_knownFor;

  /// No description provided for @place_dikmen_vadisi_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_dikmen_vadisi_new_entryFee;

  /// No description provided for @place_dikmen_vadisi_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح (التركيز على الرياضة والمشي)'**
  String get place_dikmen_vadisi_new_barbecue;

  /// No description provided for @place_dikmen_vadisi_new_history.
  ///
  /// In ar, this message translates to:
  /// **'مشروع تحول حضري ضخم حول وادي كان مليئاً بالعشوائيات إلى منتزه مكون من عدة مراحل.'**
  String get place_dikmen_vadisi_new_history;

  /// No description provided for @place_zafer_parki_30_agustos_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'مسارات الدراجات الواسعة، مسارات الجري، وتصميمها الذي يمنع دخول السيارات للداخل.'**
  String get place_zafer_parki_30_agustos_knownFor;

  /// No description provided for @place_zafer_parki_30_agustos_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_zafer_parki_30_agustos_entryFee;

  /// No description provided for @place_zafer_parki_30_agustos_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح (مفهوم طبيعي بدون دخان)'**
  String get place_zafer_parki_30_agustos_barbecue;

  /// No description provided for @place_zafer_parki_30_agustos_history.
  ///
  /// In ar, this message translates to:
  /// **'افتتحت بجوار محطة حافلات AŞTİ لتكون \"نفساً\" حديثاً وسط ضجيج حركة المواصلات.'**
  String get place_zafer_parki_30_agustos_history;

  /// No description provided for @place_yildonumu_50_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'إطلالة \"شرفة أنقرة\" البانورامية، سارية العلم الضخمة، والمساحات المرتفعة الهادئة.'**
  String get place_yildonumu_50_new_knownFor;

  /// No description provided for @place_yildonumu_50_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_yildonumu_50_new_entryFee;

  /// No description provided for @place_yildonumu_50_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح'**
  String get place_yildonumu_50_new_barbecue;

  /// No description provided for @place_yildonumu_50_new_history.
  ///
  /// In ar, this message translates to:
  /// **'بنيت احتفالاً بالذكرى الخمسين للجمهورية، وتقع على قمم جبل سيبيجي.'**
  String get place_yildonumu_50_new_history;

  /// No description provided for @place_altinkoy_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'البيوت الخشبية المرممة، طاحونة الهواء العاملة، الجسر المعلق، وورش الحرف التقليدية.'**
  String get place_altinkoy_new_knownFor;

  /// No description provided for @place_altinkoy_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'20 ليرة (للكبار)، 10 ليرات (للطلاب)'**
  String get place_altinkoy_new_entryFee;

  /// No description provided for @place_altinkoy_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح (تتوفر مطاعم تقدم أطعمة تقليدية)'**
  String get place_altinkoy_new_barbecue;

  /// No description provided for @place_altinkoy_new_history.
  ///
  /// In ar, this message translates to:
  /// **'أنشأته بلدية ألتنداغ لإحياء وتجسيد حياة القرية الأناضولية التقليدية من فترة الثلاثينيات إلى الخمسينيات.'**
  String get place_altinkoy_new_history;

  /// No description provided for @place_kurtulus_parki_new_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'صالة التزلج على الجليد، الأشجار الكثيفة، وسهولة الوصول عبر المترو.'**
  String get place_kurtulus_parki_new_knownFor;

  /// No description provided for @place_kurtulus_parki_new_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'مجاني'**
  String get place_kurtulus_parki_new_entryFee;

  /// No description provided for @place_kurtulus_parki_new_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'غير مسموح'**
  String get place_kurtulus_parki_new_barbecue;

  /// No description provided for @place_kurtulus_parki_new_history.
  ///
  /// In ar, this message translates to:
  /// **'أحد أقدم الحديقة المركزية التي تخدم مناطق كيزيلاي وكوليج.'**
  String get place_kurtulus_parki_new_history;

  /// No description provided for @place_soguksu_milli_parki_knownFor.
  ///
  /// In ar, this message translates to:
  /// **'الينابيع الحرارية، غابات الصنوبر، الطيور النادرة، ومرافق التخييم.'**
  String get place_soguksu_milli_parki_knownFor;

  /// No description provided for @place_soguksu_milli_parki_entryFee.
  ///
  /// In ar, this message translates to:
  /// **'تقريباً 40 ليرة للسيارات (رسوم دخول منتزه وطني)'**
  String get place_soguksu_milli_parki_entryFee;

  /// No description provided for @place_soguksu_milli_parki_barbecue.
  ///
  /// In ar, this message translates to:
  /// **'مسموح (تتوفر مرافق تخييم ونزهات واسعة)'**
  String get place_soguksu_milli_parki_barbecue;

  /// No description provided for @place_soguksu_milli_parki_history.
  ///
  /// In ar, this message translates to:
  /// **'منتزه وطني تأسس عام 1959 في المنطقة البركانية في كيزيلجاهامام.'**
  String get place_soguksu_milli_parki_history;

  /// No description provided for @medicalBookingContent.
  ///
  /// In ar, this message translates to:
  /// **'الدولة والجامعة (MHRS/182): تطبيق MHRS أو اتصل بـ 182. الخاص: اتصل بالمستشفى مباشرة أو عبر موقعهم.'**
  String get medicalBookingContent;

  /// No description provided for @medicalLanguageContent.
  ///
  /// In ar, this message translates to:
  /// **'معظم المستشفيات الحكومية تتحدث التركية فقط. اصطحب معك مترجماً أو استخدم ترجمة جوجل. المستشفيات الخاصة غالباً ما توفر مترجمين.'**
  String get medicalLanguageContent;

  /// No description provided for @medicalInsuranceContent.
  ///
  /// In ar, this message translates to:
  /// **'الحكومي: يغطيه تأمين الطالب (GSS/SGK). الخاص: يغطي التأمين جزءاً وتدفع الفرق. تأمين السفر مقبول في بعض المستشفيات الخاصة.'**
  String get medicalInsuranceContent;

  /// No description provided for @medicalBringContent.
  ///
  /// In ar, this message translates to:
  /// **'الإقامة/الجواز (Kimlik)، أوراق التأمين، وأي تقارير طبية سابقة.'**
  String get medicalBringContent;

  /// No description provided for @onboarding1Title.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بكم في أنقرة'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Desc.
  ///
  /// In ar, this message translates to:
  /// **'دليلك الشامل للمدينة - اكتشف الجامعات، المستشفيات، المولات والمزيد'**
  String get onboarding1Desc;

  /// No description provided for @onboarding2Title.
  ///
  /// In ar, this message translates to:
  /// **'اعثر على كل شيء'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Desc.
  ///
  /// In ar, this message translates to:
  /// **'ابحث واستكشف جميع الأماكن المهمة في أنقرة بسهولة'**
  String get onboarding2Desc;

  /// No description provided for @onboarding3Title.
  ///
  /// In ar, this message translates to:
  /// **'ابقَ على اطلاع'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Desc.
  ///
  /// In ar, this message translates to:
  /// **'احصل على إشعارات حول الفعاليات والأخبار المهمة'**
  String get onboarding3Desc;

  /// No description provided for @onboardingLanguageTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة'**
  String get onboardingLanguageTitle;

  /// No description provided for @onboardingLanguageDesc.
  ///
  /// In ar, this message translates to:
  /// **'يرجى اختيار اللغة التي تود استخدامها في التطبيق'**
  String get onboardingLanguageDesc;

  /// No description provided for @onboardingSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطي'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ'**
  String get onboardingStart;
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
