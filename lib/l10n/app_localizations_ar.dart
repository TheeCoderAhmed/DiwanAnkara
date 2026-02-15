// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مجتمع الطلاب اليمنيين - أنقرة';

  @override
  String get home => 'الرئيسية';

  @override
  String get more => 'المزيد';

  @override
  String get language => 'اللغة';

  @override
  String get theme => 'المظهر';

  @override
  String get dark => 'داكن';

  @override
  String get light => 'فاتح';

  @override
  String get system => 'تلقائي';

  @override
  String get hello => 'أهلاً بك';

  @override
  String get searchHint => 'ابحث عن إعلانات، فعاليات...';

  @override
  String get searchResults => 'نتائج البحث';

  @override
  String get noResults => 'لا توجد نتائج';

  @override
  String get announcements => 'الإعلانات';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get ikamet => 'الإقامة';

  @override
  String get places => 'الأماكن';

  @override
  String get projects => 'المشاريع';

  @override
  String get announcement => 'الإعلان';

  @override
  String get announcementNotFound => 'لم يتم العثور على الإعلان';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get error => 'خطأ';

  @override
  String get openLink => 'فتح الرابط';

  @override
  String get addComment => 'إضافة تعليق';

  @override
  String get shareOpinion => 'شارك رأيك أو استفسارك حول هذا الخبر';

  @override
  String get name => 'الاسم';

  @override
  String get enterName => 'أدخل اسمك';

  @override
  String get comment => 'التعليق';

  @override
  String get writeComment => 'اكتب تعليقك هنا...';

  @override
  String get sendComment => 'إرسال التعليق';

  @override
  String get commentReviewNote => 'سيتم مراجعة تعليقك من قبل الإدارة';

  @override
  String waitMinutes(int minutes) {
    return 'يرجى الانتظار $minutes دقيقة قبل إرسال تعليق آخر';
  }

  @override
  String get commentSuccess => 'تم إرسال تعليقك بنجاح! سيتم مراجعته قريباً.';

  @override
  String get commentError =>
      'حدث خطأ أثناء إرسال التعليق. يرجى المحاولة مرة أخرى.';

  @override
  String get nameRequired => 'الرجاء إدخال الاسم';

  @override
  String get nameTooShort => 'الاسم يجب أن يكون على الأقل حرفين';

  @override
  String get nameTooLong => 'الاسم يجب أن لا يتجاوز 50 حرفاً';

  @override
  String get commentRequired => 'الرجاء إدخال التعليق';

  @override
  String get commentTooShort => 'التعليق يجب أن يكون على الأقل 10 أحرف';

  @override
  String linkError(Object error) {
    return 'خطأ في فتح الرابط: $error';
  }

  @override
  String get eventsCalendar => 'تقويم الفعاليات';

  @override
  String get upcomingEvents => 'فعاليات قادمة';

  @override
  String get previousEvents => 'فعاليات سابقة';

  @override
  String get noEventsToday => 'لا توجد فعاليات في هذا اليوم';

  @override
  String get noUpcomingEvents => 'لا توجد فعاليات قادمة';

  @override
  String get registerNow => 'سجل الآن';

  @override
  String get linkLaunchError => 'تعذر فتح رابط التسجيل';

  @override
  String eventsOf(Object date) {
    return 'فعاليات $date';
  }

  @override
  String get ikametTracker => 'متتبع الإقامة';

  @override
  String get ikametNoDateSet => 'لم يتم تعيين تاريخ انتهاء الإقامة';

  @override
  String get ikametSetDate => 'تعيين تاريخ الانتهاء';

  @override
  String get ikametExpiresIn => 'تنتهي في:';

  @override
  String get days => 'يوم';

  @override
  String get ikametSafe => 'آمن';

  @override
  String get ikametWarning => 'تحذير';

  @override
  String get ikametUrgent => 'عاجل!';

  @override
  String get studentResources => 'مصادر مفيدة للطلاب';

  @override
  String get noUniversitiesInSection => 'لا توجد جامعات في هذا القسم';

  @override
  String get university => 'جامعة';

  @override
  String get universityIntro => 'مقدمة عن الجامعة';

  @override
  String get bachelorPrograms => 'برامج البكالوريوس';

  @override
  String get associatePrograms => 'برامج الدبلوم';

  @override
  String get universityInTurkey => 'جامعة في تركيا';

  @override
  String get noItemsInSection => 'لا توجد عناصر في هذا القسم';

  @override
  String get projectDetails => 'تفاصيل المشروع';

  @override
  String get callNow => 'اتصل الآن';

  @override
  String get joinWhatsapp => 'انضم للمجموعة عبر ياتساب';

  @override
  String get aboutProject => 'نبذة عن المشروع';

  @override
  String get reviews => 'التقييمات';

  @override
  String get shareExperience => 'شارك تجربتك مع الآخرين';

  @override
  String get noReviewsYet => 'لا توجد تقييمات بعد';

  @override
  String get beFirstToReview => 'كن أول من يشارك تجربته!';

  @override
  String get addReview => 'إضافة تقييم';

  @override
  String get rating => 'التقييم';

  @override
  String get writeReview => 'اكتب تقييمك هنا...';

  @override
  String get cancel => 'إلغاء';

  @override
  String get sendReview => 'إرسال التقييم';

  @override
  String get reviewSuccess => 'تم إرسال تقييمك بنجاح! سيتم نشره بعد المراجعة.';

  @override
  String get reviewError => 'حدث خطأ. يرجى المحاولة مرة أخرى.';

  @override
  String get reviewsLoadError => 'خطأ في تحميل التقييمات';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get noNotifications => 'لا توجد إشعارات حالياً';

  @override
  String get clearAllTitle => 'مسح جميع الإشعارات؟';

  @override
  String get clearAllMessage =>
      'هل أنت متأكد من رغبتك في حذف سجل الإشعارات بالكامل؟';

  @override
  String get delete => 'حذف';

  @override
  String get savedPlaces => 'الأماكن المحفوظة';

  @override
  String get savedPlacesSubtitle => 'شاهد قائمة الأماكن المفضلة';

  @override
  String get aboutUs => 'من نحن';

  @override
  String get aboutUsSubtitle => 'دليل الاتحاد والمعلومات';

  @override
  String get supportUs => 'دعمنا';

  @override
  String get supportUsSubtitle => 'تبرع لدعم المجتمع';

  @override
  String get appearance => 'المظهر';

  @override
  String get committees => 'الهيئات';

  @override
  String get committeesSubtitle => 'الهيئات السابقة عبر السنوات';

  @override
  String get oversight => 'لجان الرقابة';

  @override
  String get oversightSubtitle => 'أعضاء لجان الرقابة عبر السنوات';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'الإنجليزية';

  @override
  String get turkish => 'التركية';

  @override
  String get themeFollowSystem => 'يتبع إعدادات الجهاز';

  @override
  String get themeAlwaysLight => 'المظهر الفاتح دائماً';

  @override
  String get themeAlwaysDark => 'المظهر الداكن دائماً';

  @override
  String get selectTheme => 'اختر المظهر';

  @override
  String get supportDesc =>
      'يمكنك دعم مجتمع الطلاب اليمنيين في أنقرة من خلال التبرع:';

  @override
  String get copy => 'نسخ';

  @override
  String get copiedIban => 'تم نسخ رقم الـ IBAN';

  @override
  String get close => 'إغلاق';

  @override
  String get loadingData => 'جاري تحميل البيانات، يرجى المحاولة لاحقاً';

  @override
  String get exchangeRateError =>
      'تعذر تحديث الأسعار. استخدام الأسعار الاحتياطية.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get popularPlaces => 'أماكن مشهورة';

  @override
  String get partners => 'شركاؤنا';

  @override
  String get noPartners => 'لا يوجد شركاء حالياً';

  @override
  String get catUniversity => 'الجامعات';

  @override
  String get catHospital => 'المستشفيات';

  @override
  String get catMall => 'المولات';

  @override
  String get catHistoric => 'المعالم';

  @override
  String get catLibrary => 'المكتبات';

  @override
  String get catTransport => 'المواصلات';

  @override
  String get catGovOffice => 'الدوائر الحكومية';

  @override
  String get catParks => 'الحدائق';

  @override
  String get catHousing => 'دليل السكنات';

  @override
  String get catPartners => 'شركاء النجاح';

  @override
  String get catAbout => 'من نحن';

  @override
  String get catProject => 'مشاريعنا';

  @override
  String get noAnnouncementFound => 'لم يتم العثور على الإعلان';

  @override
  String get shareYourOpinion => 'شارك رأيك أو استفسارك حول هذا الخبر';

  @override
  String get pleaseEnterName => 'الرجاء إدخال الاسم';

  @override
  String get writeCommentHere => 'اكتب تعليقك هنا...';

  @override
  String get pleaseEnterComment => 'الرجاء إدخال التعليق';

  @override
  String get errorOpeningLink => 'خطأ في فتح الرابط';

  @override
  String get eventCalendar => 'تقويم الفعاليات';

  @override
  String eventsOnDate(String date) {
    return 'فعاليات $date';
  }

  @override
  String get showAll => 'عرض الكل';

  @override
  String get noEventsOnDay => 'لا توجد فعاليات في هذا اليوم';

  @override
  String get errorOpeningRegistrationLink => 'تعذر فتح رابط التسجيل';

  @override
  String get noUniversitiesFound => 'لا توجد جامعات في هذا القسم';

  @override
  String get universityIntroduction => 'مقدمة عن الجامعة';

  @override
  String get placeNotFound => 'المكان غير موجود';

  @override
  String get place => 'المكان';

  @override
  String get navigate => 'تنقّل';

  @override
  String get attachedDocuments => 'الوثائق المرفقة';

  @override
  String get pdfFile => 'ملف PDF';

  @override
  String get introductoryDocument => 'مستند تعريفي';

  @override
  String cannotOpenFile(String error) {
    return 'لا يمكن فتح الملف: $error';
  }

  @override
  String get showLess => 'عرض أقل';

  @override
  String get readMore => 'اقرأ المزيد';

  @override
  String get noSavedPlaces => 'لا توجد أماكن محفوظة';

  @override
  String errorLoadingData(String error) {
    return 'خطأ في تحميل البيانات: $error';
  }

  @override
  String get joinWhatsappGroup => 'انضم للمجموعة عبر واتساب';

  @override
  String get clearAllNotificationsTitle => 'مسح جميع الإشعارات؟';

  @override
  String get clearAllNotificationsMessage =>
      'هل أنت متأكد من رغبتك في حذف سجل الإشعارات بالكامل؟';

  @override
  String get clear => 'مسح';

  @override
  String get pastOversightCommittees => 'لجان الرقابة السابقة';

  @override
  String get noDataAvailable => 'لا توجد بيانات متاحة';

  @override
  String get selectYear => 'اختر السنة';

  @override
  String get noMembersForYear => 'لا يوجد أعضاء لهذه السنة';

  @override
  String get pastContributors => 'الهيئات السابقة';

  @override
  String get noContributorsForYear => 'لا يوجد مساهمون لهذه السنة';

  @override
  String get directory => 'الدليل';

  @override
  String get sections => 'الأقسام';

  @override
  String get noResidencyGuide => 'لا يوجد دليل الإقامة حالياً';

  @override
  String get fileLinkNotAvailable => 'رابط الملف غير متوفر';

  @override
  String get noHousingGuide => 'لا يوجد دليل السكنات حالياً';

  @override
  String get pdfLinkNotAvailable => 'رابط PDF غير متوفر';

  @override
  String get residencyGuide => 'دليل الإقامة (PDF)';

  @override
  String get housingGuide => 'دليل السكنات (PDF)';

  @override
  String get currencyConverter => 'تحويل العملات';

  @override
  String get refreshRates => 'تحديث الأسعار';

  @override
  String get from => 'من';

  @override
  String get to => 'إلى';

  @override
  String get contactAndInquiry => 'للتواصل والاستفسار';

  @override
  String get fundManager => 'مسؤول الصندوق';

  @override
  String get eventDetails => 'تفاصيل الفعالية';

  @override
  String get pastEvents => 'الفعاليات السابقة';

  @override
  String get noPastEvents => 'لا توجد فعاليات سابقة';

  @override
  String get eventCategorySports => 'رياضة';

  @override
  String get eventCategoryCulture => 'ثقافة وفنون';

  @override
  String get eventCategoryEducational => 'تعليم';

  @override
  String get eventCategorySocial => 'اجتماعي';

  @override
  String get eventCategoryReligious => 'ديني';

  @override
  String get eventCategoryOther => 'عام';

  @override
  String get downloadingLanguageModel => 'جاري تحميل حزمة اللغة...';

  @override
  String get languageModelDownloaded => 'تم تحميل حزمة اللغة بنجاح.';
}
