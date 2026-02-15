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
  String get catActivities => 'الأنشطة والترفيه';

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

  @override
  String get reportSafetyConcern => 'الإبلاغ عن محتوى أو انتهاك';

  @override
  String get reportSafetyConcernSubtitle =>
      'تواصل معنا للإبلاغ عن أي مخاوف تتعلق بالسلامة';

  @override
  String get socialConnect => 'التواصل الاجتماعي';

  @override
  String get location => 'الموقع';

  @override
  String get globalRank => 'التصنيف العالمي';

  @override
  String get degrees => 'الدرجات العلمية';

  @override
  String get bachelorsAndMore => 'بكالوريوس وأكثر';

  @override
  String get openInGoogleMaps => 'فتح في خرائط جوجل';

  @override
  String get navigateNow => 'التوجه الآن';

  @override
  String get noDescriptionAvailable => 'لا يوجد وصف متاح.';

  @override
  String get established => 'سنة التأسيس';

  @override
  String get knownFor => 'تشتهر بـ';

  @override
  String get hospitalType => 'نوع المستشفى';

  @override
  String get medicalAdvice => 'معلومة طبية ومستشفيات';

  @override
  String get bookingMethod => 'طريقة الحجز';

  @override
  String get languageTip => 'صعوبات اللغة';

  @override
  String get insuranceInfo => 'التأمين والتكاليف';

  @override
  String get whatToBring => 'ماذا تحضر معك؟';

  @override
  String get howToBook => 'كيفية الحجز';

  @override
  String get hospitalAdvices => 'معلومة المستشفيات';

  @override
  String get entryFee => 'رسوم الدخول';

  @override
  String get barbecue => 'الشواء / التنزه';

  @override
  String get history => 'لمحة تاريخية';

  @override
  String get parkAdvices => 'معلومة المتنزهات';

  @override
  String get seasonalRules => 'القواعد الموسمية';

  @override
  String get fuelTypes => 'أنواع الوقود';

  @override
  String get arrivalTime => 'وقت الوصول';

  @override
  String get seasonalRulesContent =>
      'غالباً ما تصدر ولاية أنقرة حظراً على الشواء والنيران المفتوحة من يونيو/يوليو حتى 30 سبتمبر لحماية الغابات من الحرائق خلال الجو الجاف.';

  @override
  String get fuelTypesContent =>
      'يمنع استخدام الأخشاب أو القطع التي تسبب دخاناً كثيفاً خارج وحدات الشواء. يُتوقع منك إحضار الفحم الخاص بك.';

  @override
  String get arrivalTimeContent =>
      'في عطلات نهاية الأسبوع، تمتلئ أماكن الشواء مبكراً (غالباً 9:00 - 10:00 صباحاً). يفضل الوصول مبكراً لضمان مكان.';

  @override
  String get place_metu_uni_name =>
      'Middle East Technical University (METU/ODTÜ)';

  @override
  String get place_metu_uni_desc =>
      'جامعة الشرق الأوسط التقنية (METU) هي جامعة بحثية حكومية دولية في أنقرة. لغة التدريس هي الإنجليزية وتعتبر الأفضل في تركيا في تخصصات الهندسة والعلوم الطبيعية.';

  @override
  String get place_hacettepe_uni_name => 'Hacettepe University';

  @override
  String get place_hacettepe_uni_desc =>
      'جامعة حاجيت تبه هي الوجهة الأولى لدراسة الطب في تركيا. تأسست عام 1967 وتضم حرمين جامعيين كبيرين. بجانب الطب، تتفوق في الهندسة والفنون الجميلة.';

  @override
  String get place_ankara_uni_name => 'Ankara University';

  @override
  String get place_ankara_uni_desc =>
      'جامعة أنقرة هي أول جامعة تأسست في الجمهورية التركية عام 1946. تشتهر بكلياتها العريقة في القانون والعلوم السياسية والطب.';

  @override
  String get place_gazi_uni_name => 'Gazi University';

  @override
  String get place_gazi_uni_desc =>
      'جامعة عريقة تأسست عام 1926، وتشتهر بتخصصات التعليم والهندسة والتكنولوجيا.';

  @override
  String get place_aybu_uni_name => 'Ankara Yıldırım Beyazıt University (AYBU)';

  @override
  String get place_aybu_uni_desc =>
      'جامعة حكومية حديثة تقدم معظم برامجها باللغة الإنجليزية. تشتهر بتخصصات الطب والهندسة.';

  @override
  String get place_haci_bayram_veli_name =>
      'Ankara Hacı Bayram Veli University (AHBVU)';

  @override
  String get place_haci_bayram_veli_desc =>
      'جامعة حكومية تركز على العلوم الاجتماعية والفنون والسياحة والقانون.';

  @override
  String get place_asbu_uni_name =>
      'Social Sciences University of Ankara (ASBU)';

  @override
  String get place_asbu_uni_desc =>
      'أول جامعة حكومية متخصصة بالكامل في العلوم الاجتماعية في تركيا، تقع في منطقة أولوس التاريخية.';

  @override
  String get place_mgu_uni_name =>
      'Ankara Music and Fine Arts University (MGU)';

  @override
  String get place_mgu_uni_desc =>
      'جامعة حكومية متخصصة في الموسيقى والفنون الجميلة.';

  @override
  String get place_bilkent_uni_name => 'Bilkent University';

  @override
  String get place_bilkent_uni_desc =>
      'أول جامعة خاصة في تركيا، تشتهر ببحثها العلمي المتميز والتعليم باللغة الإنجليزية.';

  @override
  String get place_cankaya_uni_name => 'Çankaya University';

  @override
  String get place_cankaya_uni_desc =>
      'جامعة خاصة تشتهر بتأثير أبحاثها العالي وبرامج الهندسة والعمارة والقانون.';

  @override
  String get place_tobb_etu_name =>
      'TOBB University of Economics and Technology';

  @override
  String get place_tobb_etu_desc =>
      'جامعة خاصة معروفة بنظام التعليم التعاوني والعلاقات القوية مع عالم الأعمال.';

  @override
  String get place_atilim_uni_name => 'Atılım University';

  @override
  String get place_atilim_uni_desc =>
      'جامعة خاصة تركز على البحث والإنتاجية، وتتميز في هندسة الطيران.';

  @override
  String get place_baskent_uni_name => 'Başkent University';

  @override
  String get place_baskent_uni_desc =>
      'جامعة خاصة رائدة في العلوم الصحية والطب، وتمتلك شبكة مستشفيات واسعة.';

  @override
  String get place_tedu_uni_name => 'TED University';

  @override
  String get place_tedu_uni_desc =>
      'جامعة خاصة تركز على التعليم الليبرالي والمهارات الشخصية.';

  @override
  String get place_ostim_tech_name => 'OSTİM Technical University';

  @override
  String get place_ostim_tech_desc =>
      'جامعة صناعية تقع في منطقة صناعية، تركز على التدريب العملي وريادة الأعمال.';

  @override
  String get place_lokman_hekim_name => 'Lokman Hekim University';

  @override
  String get place_lokman_hekim_desc =>
      'جامعة موضوعية للعلوم الصحية، مرتبطة بمستشفيات لوكمان حكيم.';

  @override
  String get place_medipol_ankara_name => 'Ankara Medipol University';

  @override
  String get place_medipol_ankara_desc =>
      'جامعة تركز على العلوم الصحية والبنية التحتية التكنولوجية الحديثة.';

  @override
  String get place_thk_uni_name =>
      'University of Turkish Aeronautical Association (THK University)';

  @override
  String get place_thk_uni_desc =>
      'الجامعة الأولى المتخصصة في الطيران والفضاء في تركيا.';

  @override
  String get place_ufuk_uni_name => 'Ufuk University';

  @override
  String get place_ufuk_uni_desc =>
      'جامعة خاصة معروفة بكلية الطب والقانون والتربية.';

  @override
  String get place_yuksek_ihtisas_name => 'Yüksek İhtisas University';

  @override
  String get place_yuksek_ihtisas_desc =>
      'جامعة متخصصة في العلوم الصحية، خاصة الطب والتمريض.';

  @override
  String get place_ankara_bilim_name =>
      'Ankara Science University (Ankara Bilim)';

  @override
  String get place_ankara_bilim_desc =>
      'جامعة حديثة تركز على هندسة البرمجيات والتصميم والتنمية المستدامة.';

  @override
  String get place_health_sciences_uni_name =>
      'University of Health Sciences (SBÜ) – Gülhane Campus';

  @override
  String get place_health_sciences_uni_desc =>
      'جامعة حكومية متخصصة في العلوم الصحية، مقرها في مجمع جولهانه الطبي العريق.';

  @override
  String get place_police_academy_name => 'Turkish National Police Academy';

  @override
  String get place_police_academy_desc =>
      'المؤسسة الرائدة لتدريب ضباط الشرطة وخبراء الأمن في تركيا.';

  @override
  String get place_national_defense_uni_name =>
      'National Defense University – Turkish Military Academy';

  @override
  String get place_national_defense_uni_desc =>
      'المؤسسة العسكرية لتدريب ضباط القوات البرية التركية، تجمع بين التدريب العسكري والتعليم الأكاديمي.';

  @override
  String get place_medical_advice_name => 'Medical Appointment Advice';

  @override
  String get place_medical_advice_desc =>
      'دليل شامل حول كيفية حجز المواعيد الطبية في أنقرة، التعامل مع اللغة، وفهم التأمين الصحي للطلاب.';

  @override
  String get place_bilkent_city_hosp_name => 'Ankara Bilkent City Hospital';

  @override
  String get place_bilkent_city_hosp_desc =>
      'واحدة من أكبر المجمعات الطبية في العالم؛ معروفة بجراحة القلب والأوعية الدموية، والأعصاب، وجراحة العظام، والأورام، والطب النفسي الشرعي عالي الأمن. تضم أكثر من 3700 سرير وهي معتمدة من JCI.';

  @override
  String get place_hacettepe_uni_hosp_name => 'Hacettepe University Hospitals';

  @override
  String get place_hacettepe_uni_hosp_desc =>
      'مجمع يضم 4 مستشفيات (كبار، أطفال، أورام، أوران). مشهور بالتشخيصات الصعبة، وزراعة الأعضاء ونخاع العظام، وهو أول مستشفى حكومي معتمد من JCI في تركيا.';

  @override
  String get place_ankara_uni_hosp_name =>
      'Ankara University Hospitals (İbni Sina & Cebeci)';

  @override
  String get place_ankara_uni_hosp_desc =>
      'مستشفى \"ابن سينا\" متخصص في الطب الباطني والجراحة وعلم الدم. مستشفى \"جيبيجي\" متخصص في طب الأطفال والقلب. يُعرف بمستشفى \"الأطباء\" لتدريب الأطباء المتميزين.';

  @override
  String get place_gazi_uni_hosp_name => 'Gazi University Hospital';

  @override
  String get place_gazi_uni_hosp_desc =>
      'مركز رائد لإصابات الحوادث والرعاية الطارئة والعلاجات الباطنية والجراحية المتقدمة. يقوم بحوالي 50,000 عملية سنوياً.';

  @override
  String get place_gulhane_hosp_name =>
      'Gülhane Training and Research Hospital (GATA)';

  @override
  String get place_gulhane_hosp_desc =>
      'كان سابقاً أكاديمية طبية عسكرية؛ معروف بإعادة التأهيل، رعاية الحروق، أمراض القلب، والأعصاب، والتعليم الطبي.';

  @override
  String get place_etlik_city_hosp_name => 'Etlik City Hospital';

  @override
  String get place_etlik_city_hosp_desc =>
      'ثاني أكبر مجمع مستشفيات في أنقرة، حل مكان مرافق قديمة مثل \"نمونة\". معروف ببنيته التحتية الذكية وأقسامه التخصصية المتعددة.';

  @override
  String get place_acibadem_ankara_name => 'Acıbadem Ankara Hospital';

  @override
  String get place_acibadem_ankara_desc =>
      'متخصص في العظام، أمراض النساء، طب الأطفال، والجراحة الروبوتية. يتميز بتقنيات مثل Flash CT وروبوتات da Vinci.';

  @override
  String get place_memorial_ankara_name => 'Memorial Ankara Hospital';

  @override
  String get place_memorial_ankara_desc =>
      'جراحة القلب والأوعية الدموية، التلقيح الاصطناعي، الأورام، وزراعة نخاع العظام. مساحته 42,000 متر مربع ويحمل اعتماد JCI.';

  @override
  String get place_medicana_ankara_name => 'Medicana International Ankara';

  @override
  String get place_medicana_ankara_desc =>
      'زراعة الأعضاء (الكلى والكبد)، الأورام (بتقنية CyberKnife)، التلقيح الاصطناعي، وأمراض القلب.';

  @override
  String get place_guven_hosp_name => 'Güven Hospital';

  @override
  String get place_guven_hosp_desc =>
      'جراحة القلب والأوعية الدموية، طوارئ الأطفال، خدمات متميزة للمجتمع الدبلوماسي. يستخدم تقنيات المباني الذكية.';

  @override
  String get place_bayindir_hosp_name => 'Bayındır Hospital (Söğütözü)';

  @override
  String get place_bayindir_hosp_desc =>
      'زراعة نخاع العظام، أمراض القلب، الأعصاب، وطب الأسنان. جزء من مجموعة بايندير للرعاية الصحية.';

  @override
  String get place_tobb_etu_hosp_name => 'TOBB ETÜ Hospital';

  @override
  String get place_tobb_etu_hosp_desc =>
      'جراحة العمود الفقري، جراحة الثدي، جراحة الكبد والمرارة، والعمليات طفيفة التوغل. تملكه اتحاد الغرف والبورصات.';

  @override
  String get place_lokman_hekim_ank_name =>
      'Lokman Hekim University Ankara Hospital';

  @override
  String get place_lokman_hekim_ank_desc =>
      'جراحة الأعصاب، العظام، ورعاية الأمومة \"الصديقة للطفل\". يتميز بمهبط للطائرات العمودية ووحدات عناية مركزة متخصصة.';

  @override
  String get place_liv_hosp_ankara_name => 'Liv Hospital Ankara';

  @override
  String get place_liv_hosp_ankara_desc =>
      'الجراحة الروبوتية، جراحة السمنة، علاج السرطان، ورعاية القلب والأوعية الدموية. يحمل اعتمادات JCI و TUV.';

  @override
  String get place_koru_hosp_ankara_name => 'Koru Ankara Hospital';

  @override
  String get place_koru_hosp_ankara_desc =>
      'جراحة السمنة الروبوتية، جراحة القلب، والتلقيح الاصطناعي. معروف براحة المرضى وبالتكنولوجيا المتقدمة.';

  @override
  String get place_dunyagoz_ankara_name => 'Dünyagöz Ankara';

  @override
  String get place_dunyagoz_ankara_desc =>
      'متخصص حصرياً في طب العيون (ليزك، مياه بيضاء، جلوكوما). حجم جراحي كبير وتكنولوجيا ليزر متقدمة.';

  @override
  String get place_medical_park_ank_name => 'Medical Park Ankara';

  @override
  String get place_medical_park_ank_desc =>
      'رعاية شاملة مع التركيز على التكامل التكنولوجي. جزء من أكبر مجموعة مستشفيات خاصة في تركيا.';

  @override
  String get place_dental_estetik_center_name => 'Dental Estetik Center';

  @override
  String get place_dental_estetik_center_desc =>
      'تأسس عام 1993، متخصص في خدمات طب الأسنان التجميلية والعلاجية المتقدمة.';

  @override
  String get place_elos_klinik_name => 'Elos Klinik';

  @override
  String get place_elos_klinik_desc =>
      'متخصص في زراعة الشعر، العلاج بالخلايا الجذعية، وشفط الدهون.';

  @override
  String get place_dr_emin_eren_clinic_name => 'Dr. Emin Eren Clinic';

  @override
  String get place_dr_emin_eren_clinic_desc =>
      'متخصص في الجراحات التجميلية مثل تجميل الأنف.';

  @override
  String get place_genclik_parki_new_name => 'Gençlik Parkı';

  @override
  String get place_genclik_parki_new_desc =>
      'حديقة تاريخية كبيرة في أولوس، تضم بحيرة اصطناعية وملاهي كبيرة (Luna Park) ومسارح. تعتبر رمزاً للعصر الجمهوري ومكاناً رئيسياً للترفيه.';

  @override
  String get place_kugulu_park_new_name => 'Kuğulu Park';

  @override
  String get place_kugulu_park_new_desc =>
      'أشهر حديقة صغيرة في أنقرة، تقع في شارع \"تونالي حلمي\". مشهورة بالبجع والهدوء وسط زحام المدينة.';

  @override
  String get place_segmenler_parki_new_name => 'Seğmenler Parkı';

  @override
  String get place_segmenler_parki_new_desc =>
      'حديقة شاسعة وجميلة جدا بالقرب من السفارات. يفضلها الشباب والطلاب للتجمعات والجلوس على العشب.';

  @override
  String get place_eymir_golu_new_name => 'Eymir Gölü';

  @override
  String get place_eymir_golu_new_desc =>
      'بحيرة طبيعية تابعة لجامعة الشرق الأوسط التقنية، تعتبر ملاذاً رائعاً لممارسة الرياضة والمشي بعيداً عن ضجيج المدينة.';

  @override
  String get place_goksu_parki_new_name => 'Göksu Parkı';

  @override
  String get place_goksu_parki_new_desc =>
      'من أكبر المناطق الترفيهية في أنقرة، تم تحويلها من منجم رمل قديم إلى منطقة سياحية رائعة ببحيرة اصطناعية ضخمة.';

  @override
  String get place_mogan_parki_new_name => 'Mogan Parkı (Lake Mogan)';

  @override
  String get place_mogan_parki_new_desc =>
      'بحيرة طبيعية في منطقة غولباشي، تعتبر مقصداً رئيسياً للعائلات لممارسة الشواء والتمتع بالمناظر الخلابة والأنشطة المائية.';

  @override
  String get place_altinpark_new_name => 'Altınpark';

  @override
  String get place_altinpark_new_desc =>
      'مجمع ترفيهي ضخم يضم معارض، حدائق، ومراكز علمية. يعتبر وجهة مثالية للعائلات والطلاب.';

  @override
  String get place_harikalar_diyari_new_name => 'Harikalar Diyarı (Wonderland)';

  @override
  String get place_harikalar_diyari_new_desc =>
      'واحدة من أكبر حدائق الألعاب والترفيه في أوروبا، تتميز بمجسمات ضخمة لشخصيات القصص الخيالية.';

  @override
  String get place_ataturk_cocuklari_parki_new_name =>
      'Atatürk Çocukları ve Doğal Yaşam Parkı';

  @override
  String get place_ataturk_cocuklari_parki_new_desc =>
      'حديقة حديثة جداً تقع في أرض مزرعة أتاتورك، تضم مساحات خضراء شاسعة وحديقة حيوان رقمية فريدة.';

  @override
  String get place_botanik_parki_new_name => 'Botanik Parkı';

  @override
  String get place_botanik_parki_new_desc =>
      'حديقة هادئة وجميلة تحت برج أتاكولي، تتميز بتنوع النباتات والزهور ومسارات المشي المريحة.';

  @override
  String get place_dikmen_vadisi_new_name => 'Dikmen Vadisi';

  @override
  String get place_dikmen_vadisi_new_desc =>
      'أحد أجمل المسارات للمشي والجري في أنقرة، يضم جسوراً بحيرات اصطناعية ومناظر طبيعية خلابة.';

  @override
  String get place_zafer_parki_30_agustos_name => '30 Ağustos Zafer Parkı';

  @override
  String get place_zafer_parki_30_agustos_desc =>
      'حديقة حديثة هادئة بجانب محطة باصات أنقرة (AŞTİ)، مثالية لركوب الدراجات والنشاط البدني.';

  @override
  String get place_yildonumu_50_new_name => '50. Yıl Parkı';

  @override
  String get place_yildonumu_50_new_desc =>
      'تشتهر بكونها \"شرفة أنقرة\"، حيث توفر إطلالة بانورامية كاملة على المدينة من الأعلى.';

  @override
  String get place_altinkoy_new_name => 'Altınköy Açık Hava Müzesي';

  @override
  String get place_altinkoy_new_desc =>
      'متحف حي يحاكي حياة القرى الأناضولية القديمة، يضم طواحين هواء وورش عمل للحرف التقليدية.';

  @override
  String get place_kurtulus_parki_new_name => 'Kurtuluş Parkı';

  @override
  String get place_kurtulus_parki_new_desc =>
      'أحد أقدم المنتزهات في وسط المدينة، يتميز بأشجاره الضخمة التي توفر ظلاً عميقاً وقربه من مراكز النقل.';

  @override
  String get place_soguksu_milli_parki_name => 'Soğuksu Milli Parkı';

  @override
  String get place_soguksu_milli_parki_desc =>
      'منتزه وطني بعيد قليلاً عن المركز، يتميز بغابات الصنوبر والمياه المعدنية الحرارية.';

  @override
  String get place_ankara_transport_guide_2026_name =>
      'Ankara Ulaşım Rehberi 2026';

  @override
  String get place_ankara_transport_guide_2026_desc =>
      'دليل شامل للمواصلات في أنقرة لعام 2026، مصمم خصيصاً للطلاب والمقيمين الجدد لتوفير التكاليف وفهم نظام النقل.';

  @override
  String get place_migration_management_ankara_name =>
      'Ankara İl Göç İdaresi (Migration Management)';

  @override
  String get place_migration_management_ankara_desc =>
      'المؤسسة الأكثر أهمية لإقامتك القانونية. في عام 2026، تحول النظام إلى نموذج \"عبر الجامعة\"، حيث يتم تسليم الملفات لمكتب الطلاب الدوليين في جامعتك.';

  @override
  String get place_yemen_embassy_ankara_name =>
      'Yemen Büyükelçiliği (Yemeni Embassy)';

  @override
  String get place_yemen_embassy_ankara_desc =>
      'السفارة اليمنية في أنقرة هي حلقة الوصل مع حكومتك. تضم السفارة الآن \"مركزاً لإصدار الجوازات الآلية\" بنظام البيومتري.';

  @override
  String get place_yok_ankara_name => 'Yükseköğretim Kurulu (YÖK)';

  @override
  String get place_yok_ankara_desc =>
      'المجلس الأعلى للتعليم. مسؤول عن معادلة الشهادات والاعتراف بالجامعات الأجنبية.';

  @override
  String get place_nufus_mudurlugu_ankara_name =>
      'İl Nüfus ve Vatandaşlık Müdürlüğü';

  @override
  String get place_nufus_mudurlugu_ankara_desc =>
      'مديرية النفوس؛ حيث يجب عليك تسجيل عنوان سكنك في السجل الوطني (MERNIS). وهذا مرتبط بصلاحية إقامتك وعملياتك البنكية.';

  @override
  String get place_sgk_ankara_name => 'Sosyal Güvenlik Kurumu (SGK)';

  @override
  String get place_sgk_ankara_desc =>
      'مؤسسة الضمان الاجتماعي؛ تقدم التأمين الصحي العام (GSS) وهو أشمل تأمين حكومي في تركيا.';

  @override
  String get place_tax_office_ankara_name => 'Vergi Dairesi (Tax Office)';

  @override
  String get place_tax_office_ankara_desc =>
      'مكتب الضرائب؛ ستحتاج إليه للحصول على رقم ضريبي تركي (Vergi Numarası) وهو ضروري لفتح حساب بنكي ودفع الرسوم.';

  @override
  String get place_yemeni_student_gov_checklist_name =>
      'ملخص المعاملات الحكومية للطلاب اليمنيين 2026';

  @override
  String get place_yemeni_student_gov_checklist_desc =>
      'قائمة مرجعية سريعة للخطوات القانونية الأساسية التي يجب على الطالب اليمني اتباعها فور وصوله إلى أنقرة.';

  @override
  String get place_ankamall_full_name => 'ANKAmall';

  @override
  String get place_ankamall_full_desc =>
      'يُعرف بـ \"مركز تسوق تركيا\" وهوتاني أكبر مول في البلاد بمساحة 278,000 متر مربع. يضم أكثر من 330 علامة تجارية عالمية مثل Zara وH&M وDecathlon.';

  @override
  String get place_armada_full_name => 'Armada Shopping & Business';

  @override
  String get place_armada_full_desc =>
      'مجمع حائز على جوائز معروف بـ \"شارع أرمادا\"، وهو زقاق مفتوح من المطاعم والمقاهي يربط بين كتل البيع بالتجزئة والمكاتب.';

  @override
  String get place_panora_full_name => 'Panora Shopping Center';

  @override
  String get place_panora_full_desc =>
      'يتميز بأكبر قبة زجاجية في تركيا، وفسيفساء ضخمة لخريطة بيري ريس، وحوض أسماك متكامل.';

  @override
  String get place_atakule_full_name => 'Atakule';

  @override
  String get place_atakule_full_desc =>
      'معلم المدينة الشهير ببرج مراقبة يبلغ ارتفاعه 125 متراً ومطعم دوار، ويضم قاعدة تجارية حديثة جداً.';

  @override
  String get place_bilkent_center_name => 'Bilkent Center';

  @override
  String get place_bilkent_center_desc =>
      'مركز حياة يقع بالقرب من جامعة بيلكنت، معروف باستضافة المهرجانات الفنية والفنانين التشكيليين.';

  @override
  String get place_kentpark_full_name => 'Kentpark';

  @override
  String get place_kentpark_full_desc =>
      'معروف بتصميمه في الهواء الطلق، ومركز اللياقة البدنية الكبير، والهندسة المعمارية الصناعية الحديثة.';

  @override
  String get place_cepa_full_name => 'Cepa';

  @override
  String get place_cepa_full_desc =>
      'مجاور مباشرة لمول كنت بارك، معروف بمزيجه العملي من العلامات التجارية المتنوعة وتراسه الشعبي.';

  @override
  String get place_gordion_full_name => 'Gordion';

  @override
  String get place_gordion_full_desc =>
      'أول \"مبنى أخضر\" معتمد في أنقرة، يخدم منطقة تشايولو (Çayyolu).';

  @override
  String get place_arcadium_name => 'Arcadium';

  @override
  String get place_arcadium_desc =>
      'مول يركز على المجتمع في تشايولو، معروف بجوه \"المخلص\" وفعاليات الموسيقى الحية.';

  @override
  String get place_kizilay_avm_name => 'Kızılay AVM';

  @override
  String get place_kizilay_avm_desc =>
      'يقع في قلب المدينة تماماً (ساحة كيزيلاي). صغير الحجم ولكنه يشهد حركة مرور كثيفة جداً.';

  @override
  String get place_acity_outlet_name => 'ACity Outlet';

  @override
  String get place_acity_outlet_desc =>
      'مركز أوتليت كبير على طريق إسطنبول مع مسرح على السطح وصالة طعام واسعة.';

  @override
  String get place_forum_ankara_name => 'Forum Ankara Outlet';

  @override
  String get place_forum_ankara_desc =>
      'أكبر مركز أوتليت في المدينة، يقع في منطقة كيتشي أورين (Keçiören).';

  @override
  String get place_antares_mall_name => 'Antares';

  @override
  String get place_antares_mall_desc =>
      'يتميز بسقف زجاجي ضخم، وصالة بولينج، و10 شاشات سينما.';

  @override
  String get place_nata_vega_name => 'Nata Vega';

  @override
  String get place_nata_vega_desc =>
      'يحتوي على \"أكوا فيجا\"، أحد أكبر الأحواض المائية في تركيا، بالإضافة إلى متجر ايكيا (IKEA).';

  @override
  String get place_anatolium_ankara_name => 'Anatolium';

  @override
  String get place_anatolium_ankara_desc =>
      'يقع بجانب ناتا فيجا، ويركز على السلع المنزلية والتجزئة العملية.';

  @override
  String get place_taurus_mall_name => 'Taurus';

  @override
  String get place_taurus_mall_desc =>
      'يُعرف بتراسه الكبير وسهولة الوصول إليه في منطقة تشانكايا.';

  @override
  String get place_podium_mall_name => 'Podium';

  @override
  String get place_podium_mall_desc =>
      'معروف بـ \"القيمة العالية للمال\" ومنطقة خارجية كبيرة مع بركة مائية.';

  @override
  String get place_next_level_full_name => 'Next Level';

  @override
  String get place_next_level_full_desc =>
      'مركز حياة فاخر يضم معرضاً فنياً وتراساً خارجياً مميزاً.';

  @override
  String get place_tepe_prime_name => 'Tepe Prime';

  @override
  String get place_tepe_prime_desc =>
      'ساحة فاخرة في الهواء الطلق مشهورة بالحياة الليلية والمطاعم والحفلات الموسيقية.';

  @override
  String get place_karum_mall_name => 'Karum';

  @override
  String get place_karum_mall_desc =>
      'واحد من أقدم المولات، يقع في منطقة البعثات الدبلوماسية (Gaziosmanpaşa) مع أجواء خضراء.';

  @override
  String get place_atlantis_mall_name => 'Atlantis';

  @override
  String get place_atlantis_mall_desc =>
      'يقع في منطقة \"باتيكنت\" (Batıkent)؛ ويضم مدينة ملاهي \"Joy Land\" ومنطقة مائية.';

  @override
  String get place_galleria_mall_name => 'Galleria';

  @override
  String get place_galleria_mall_desc =>
      'مول قديم في منطقة \"أوميتكوي\" (Ümitköy)، تم تجديده مؤخراً.';

  @override
  String get place_optimum_outlet_name => 'Optimum Outlet';

  @override
  String get place_optimum_outlet_desc =>
      'مفهوم أوتليت ضخم يقع في منطقة \"إريامان\" (Eryaman).';

  @override
  String get place_ftz_mall_name => 'FTZ';

  @override
  String get place_ftz_mall_desc =>
      'يقع في منطقة كيتشي أورين (Keçiören)؛ ويتميز بوجود محاكي للقفز المظلي وسينما.';

  @override
  String get place_365_mall_name => '365 Shopping Mall';

  @override
  String get place_365_mall_desc =>
      'مول عملي أصغر حجماً في تشانكايا (Çankaya).';

  @override
  String get place_one_tower_mall_name => 'One Tower';

  @override
  String get place_one_tower_mall_desc =>
      'يقع في منطقة دوران (Oran)، مع التركيز على المطاعم والعلامات التجارية الراقية.';

  @override
  String get place_anatolian_civil_museum_name =>
      'Anadolu Medeniyetleri Müzesi';

  @override
  String get place_anatolian_civil_museum_desc =>
      'متحف حائز على جوائز يضم قطعاً أثرية من العصر الحجري القديم إلى العصور الكلاسيكية. يجب زيارته لكل مهتم بالتاريخ.';

  @override
  String get place_anitkabir_full_name => 'Anıtkabir';

  @override
  String get place_anitkabir_full_desc =>
      'ضريح مؤسس الجمهورية، مصطفى كمال أتاتورك، ومتحف حرب الاستقلال.';

  @override
  String get place_ethnography_museum_name => 'Ankara Etnografya Müzesi';

  @override
  String get place_ethnography_museum_desc =>
      'أول متحف في الجمهورية، يتميز بعرشه السلجوقي والفن الشعبي التركي.';

  @override
  String get place_rahmi_koc_museum_name => 'Rahmi M. Koç Müzesi';

  @override
  String get place_rahmi_koc_museum_desc =>
      'تاريخ الصناعة في خانات تاريخية مرممة (Çengelhan/Safranhan).';

  @override
  String get place_ulucanlar_prison_name => 'Ulucanlar Cezaevi Müzesi';

  @override
  String get place_ulucanlar_prison_desc =>
      'سجن سابق يضم تماثيل شمعية للمعتقلين السياسيين وزنازين العزل.';

  @override
  String get place_erimtan_museum_name => 'Erimtan Arkeoloji ve Sanat Müzesi';

  @override
  String get place_erimtan_museum_desc =>
      'مجموعة خاصة من الزجاج والمجوهرات والعملات الرومانية.';

  @override
  String get place_cermodern_name => 'CerModern';

  @override
  String get place_cermodern_desc =>
      'مركز للفنون الحديثة في مستودع قطارات تم تجديده.';

  @override
  String get place_first_parliament_name => 'Kurtuluş Savaşı Müzesi (I. TBMM)';

  @override
  String get place_first_parliament_desc => 'مبنى البرلمان الأصلي لعام 1920.';

  @override
  String get place_republic_museum_name => 'Cumhuriyet Müzesi (II. TBMM)';

  @override
  String get place_republic_museum_desc =>
      'حيث تم توطيد أركان الجمهورية (استخدم حتى عام 1960).';

  @override
  String get place_state_art_sculpture_name => 'Ankara Resim ve Heykel Müzesi';

  @override
  String get place_state_art_sculpture_desc =>
      'عمارة رائعة؛ يضم لوحات ومنحوتات تركية كبرى.';

  @override
  String get place_gordion_museum_name => 'Gordion Müzesي';

  @override
  String get place_gordion_museum_desc =>
      'يقع في بولاتلي؛ يضم قبر الملك ميداس الشهير.';

  @override
  String get place_roman_baths_name => 'Roma Hamamı';

  @override
  String get place_roman_baths_desc => 'أطلال قديمة لمجمع حمامات روماني.';

  @override
  String get place_altinkoy_museum_name => 'Altınköy Açık Hava Müzesi';

  @override
  String get place_altinkoy_museum_desc =>
      'يعيد خلق الحياة القروية التقليدية مع بيوت خشبية وطواحين هواء.';

  @override
  String get place_mta_natural_history_name =>
      'MTA Şehit Cuma Dağ Tabiat Tarihi Müzesi';

  @override
  String get place_mta_natural_history_desc =>
      'الجيولوجيا والديناصورات وعلم الحفريات.';

  @override
  String get place_ankara_vakif_museum_name => 'Ankara Vakıf Eserleri Müzesi';

  @override
  String get place_ankara_vakif_museum_desc =>
      'يعرض السجاد والمنسوجات وأعمال المؤسسات الخيرية القديمة.';

  @override
  String get place_july_15_museum_name =>
      '15 Temmuz Şehitler ve Demokrasi Müzesi';

  @override
  String get place_july_15_museum_desc =>
      'متحف حديث مخصص لـ \"ملحمة الديمقراطية\" (أحداث 15 تموز).';

  @override
  String get place_haci_bayram_full_name => 'Hacı Bayram Veli Mosque & Tomb';

  @override
  String get place_haci_bayram_full_desc =>
      'مركز روحي وتاريخي هام في أنقرة. يقع بجانبه \"معبد أغسطس\" الروماني، مما يمثل تلاقي الحضارات. المنطقة المحيطة بها (Hamamönü) تم ترميمها وأصبحت جميلة جدا للتمشي والتسوق التقليدي.';

  @override
  String get place_kocatepe_mosque_full_name => 'Kocatepe Mosque';

  @override
  String get place_kocatepe_mosque_full_desc =>
      'أكبر مسجد في أنقرة، يقع في منطقة كبزلاي. هندسته المعمارية رائعة ويظهر من أماكن كثيرة في المدينة. يعتبر نقطة التقاء ومركز إشعاع ثقافي.';

  @override
  String get place_augustus_temple_name => 'Augustus Tapınağı';

  @override
  String get place_augustus_temple_desc =>
      'أطلال معبد روماني به نقش لأعمال الإمبراطور أغسطس.';

  @override
  String get place_feza_gursey_center_name => 'Feza Gürsey Bilim Merkezi';

  @override
  String get place_feza_gursey_center_desc =>
      'مركز علوم تفاعلي يوفر معارض علمية تطبيقية.';

  @override
  String get place_metu_science_tech_name => 'ODTÜ Bilim ve Teknoloji Müzesi';

  @override
  String get place_metu_science_tech_desc =>
      'يقع داخل حرم جامعة الشرق الأوسط التقنية.';

  @override
  String get place_meiif_er_soy_lit_name => 'Mehmet Akif Ersoy Edebiyat Müzesi';

  @override
  String get place_meiif_er_soy_lit_desc => 'مخصص لشاعر النشيد الوطني التركي.';

  @override
  String get place_mit_espionage_museum_name => 'MİT İstihbarat Müzesi';

  @override
  String get place_mit_espionage_museum_desc =>
      'تاريخ المخابرات التركية وأدوات التجسس.';

  @override
  String get place_tcdd_steam_loco_name =>
      ' TCDD Açık Hava Buharlı Lokomotif Müzesi';

  @override
  String get place_tcdd_steam_loco_desc =>
      'قرب محطة القطار؛ عرض للقاطرات البخارية القديمة.';

  @override
  String get place_ataturk_mansion_name => 'Atatürk Müze Köşkü';

  @override
  String get place_ataturk_mansion_desc =>
      'يقع داخل الأراضي الرئاسية في تشانكايا وهو منزل أتاتورك.';

  @override
  String get place_pembe_kosk_name => 'Pembe Köşk (İsmet İnönü House)';

  @override
  String get place_pembe_kosk_desc =>
      'متحف منزل تاريخي يعود للرئيس الثاني لتركيا.';

  @override
  String get place_isbank_museum_ank_name => 'Türkiye İş Bankası Müzesi';

  @override
  String get place_isbank_museum_ank_desc =>
      'تاريخ الاقتصاد والمصارف في تركيا.';

  @override
  String get place_thk_aeronautical_name => 'Türk Hava Kurumu Müzesi';

  @override
  String get place_thk_aeronautical_desc =>
      'تاريخ الطيران التركي وتاريخ القفز بالمظلات.';

  @override
  String get place_stamp_museum_ank_name => 'PTT Pul Müzesي';

  @override
  String get place_stamp_museum_ank_desc => 'متحف مخصص لتاريخ الطوابع والبريد.';

  @override
  String get place_gokyay_chess_museum_name => 'Gökyay Vakfı Satranç Müzesi';

  @override
  String get place_gokyay_chess_museum_desc =>
      'أكبر مجموعة لمجموعات الشطرنج في العالم.';

  @override
  String get place_trt_publishing_history_name =>
      'TRT Yayıncılık Tarihi Müzesي';

  @override
  String get place_trt_publishing_history_desc =>
      'تاريخ البث والإعلام في تركيا عبر مؤسسة TRT.';

  @override
  String get place_presidential_library_full_name =>
      'Cumhurbaşkanlığı Millet Kütüphanesi';

  @override
  String get place_presidential_library_full_desc =>
      'أكبر مكتبة في تركيا (125,000 متر مربع) تضم 4 ملايين كتاب مطبوع وقاعة \"Cihannüma\" الشهيرة.';

  @override
  String get place_national_library_full_name => 'Millî Kütüphane';

  @override
  String get place_national_library_full_desc =>
      'المكتبة القانونية التي تحتفظ بنسخة من كل عمل نُشر في تركيا. تحتوي على أرشيف أتاتورك وسجلات نادرة.';

  @override
  String get place_bilkent_library_full_name =>
      'Bilkent Üniversitesi Kütüphanesi';

  @override
  String get place_bilkent_library_full_desc =>
      'أغنى مكتبة جامعية، تضم مجموعة خليل إينالجيك وأقساماً ضخمة للفنون والموسيقى.';

  @override
  String get place_ttk_library_full_name => 'Türk Tarih Kurumu Kütüphanesi';

  @override
  String get place_ttk_library_full_desc =>
      'متخصصة في التاريخ والأرشيف. في عام 2026، وسعت الوصول إلى 50,000 كتاب إلكتروني مجاني.';

  @override
  String get place_yok_thesis_center_name => 'YÖK Ulusal Tez Merkezi';

  @override
  String get place_yok_thesis_center_desc =>
      'المستودع المركزي لجميع أطروحات الماجستير والدكتوراه التي تمت مناقشتها في تركيا.';

  @override
  String get place_tbmm_library_full_name => 'TBMM Kütüphanesi';

  @override
  String get place_tbmm_library_full_desc =>
      'متخصصة في العلوم السياسية والقانون، ومجموعة واسعة من الصحف والدوريات التاريخية.';

  @override
  String get place_metu_uni_knownFor =>
      'التميز الهندسي والمعماري، جامعة تقنية رائدة، التعليم باللغة الإنجليزية.';

  @override
  String get place_hacettepe_uni_knownFor =>
      'الرائدة في تعليم الطب والعلوم الصحية، أعلى تأثير بحثي وطني.';

  @override
  String get place_ankara_uni_knownFor =>
      'أول جامعة في الجمهورية، متميزة في الحقوق والعلوم السياسية (Mülkiye) والطب.';

  @override
  String get place_gazi_uni_knownFor =>
      'تدريب المعلمين، الهندسة، التكنولوجيا؛ تكامل قوي مع الصناعة.';

  @override
  String get place_aybu_uni_knownFor =>
      'التعليم باللغة الإنجليزية، الطب والهندسة، نسبة عالية من الطلاب الدوليين.';

  @override
  String get place_haci_bayram_veli_knownFor =>
      'العلوم الاجتماعية، الفنون، السياحة (فن الطهي)، القانون.';

  @override
  String get place_asbu_uni_knownFor =>
      'متخصصة في العلوم الاجتماعية، موجهة للبحث؛ القانون، العلوم السياسية، الدراسات الإسلامية.';

  @override
  String get place_mgu_uni_knownFor => 'جامعة تخصصية للموسيقى والفنون الجميلة.';

  @override
  String get place_bilkent_uni_knownFor =>
      'أول جامعة خاصة، أبحاث بمستوى عالمي، الهندسة والاقتصاد.';

  @override
  String get place_cankaya_uni_knownFor =>
      'تأثير بحثي عالٍ، الهندسة، العمارة، القانون.';

  @override
  String get place_tobb_etu_knownFor =>
      'نموذج التعليم التعاوني (تدريب إلزامي)، علاقات قوية مع قطاع الأعمال.';

  @override
  String get place_atilim_uni_knownFor =>
      'الطيران المدني، الهندسة، الإنتاجية البحثية.';

  @override
  String get place_baskent_uni_knownFor =>
      'أول جامعة صحية خاصة، الطب وطب الأسنان، شبكة مستشفيات واسعة.';

  @override
  String get place_tedu_uni_knownFor =>
      'نموذج الفنون الليبرالية، العمارة والتعليم، التركيز على المهارات الناعمة.';

  @override
  String get place_ostim_tech_knownFor =>
      'نموذج الجامعة الصناعية، التدريب العملي وريادة الأعمال.';

  @override
  String get place_lokman_hekim_knownFor =>
      'متخصصة في الصحة؛ الطب، الصيدلة، العلوم الرياضية.';

  @override
  String get place_medipol_ankara_knownFor =>
      'العلوم الصحية، مرافق حديثة، الطب وطب الأسنان.';

  @override
  String get place_thk_uni_knownFor =>
      'التخصص في الطيران والفضاء، تدريب الطيارين.';

  @override
  String get place_ufuk_uni_knownFor => 'الطب، القانون، التربية.';

  @override
  String get place_yuksek_ihtisas_knownFor =>
      'تخصص العلوم الصحية، الطب والتمريض.';

  @override
  String get place_ankara_bilim_knownFor =>
      'هندسة البرمجيات، التصميم، أهداف التنمية المستدامة.';

  @override
  String get place_health_sciences_uni_knownFor =>
      'التعليم الطبي، كانت سابقاً أكاديمية جولهانه الطبية العسكرية (GATA)؛ الطب، طب الأسنان، التمريض.';

  @override
  String get place_police_academy_knownFor =>
      'تدريب ضباط الشرطة، الاستراتيجيات الأمنية، تحليل الجريمة، الاستخبارات.';

  @override
  String get place_national_defense_uni_knownFor =>
      'تدريب الضباط؛ الهندسة، العلوم الاجتماعية، الإدارة.';

  @override
  String get place_medical_advice_knownFor => 'دليل أساسي للطلاب والمغتربين.';

  @override
  String get place_bilkent_city_hosp_knownFor =>
      'جراحة القلب والأوعية الدموية، الأعصاب، الأورام؛ سعة عالمية.';

  @override
  String get place_hacettepe_uni_hosp_knownFor =>
      'التشخيصات الصعبة، زراعة الأعضاء، الأورام؛ رائد في اعتماد JCI.';

  @override
  String get place_ankara_uni_hosp_knownFor =>
      'الطب الباطني، الجراحة، وعلم الدم؛ مستشفى تعليمي رئيسي.';

  @override
  String get place_gazi_uni_hosp_knownFor =>
      'الإصابات، الرعاية الطارئة، والعلاجات الجراحية المتقدمة.';

  @override
  String get place_gulhane_hosp_knownFor =>
      'إعادة التأهيل، رعاية الحروق، أمراض القلب، والأعصاب.';

  @override
  String get place_etlik_city_hosp_knownFor =>
      'بنية تحتية ذكية، أقسام تخصصية؛ أحدث مستشفى في المدينة.';

  @override
  String get place_acibadem_ankara_knownFor =>
      'جراحة العظام، أمراض النساء، الجراحة الروبوتية.';

  @override
  String get place_memorial_ankara_knownFor =>
      'جراحة القلب والأوعية الدموية، التلقيح الاصطناعي، الأورام، وزراعة نخاع العظام.';

  @override
  String get place_medicana_ankara_knownFor =>
      'زراعة الأعضاء، الأورام (سايبر نايف)، أمراض القلب.';

  @override
  String get place_guven_hosp_knownFor =>
      'خدمات متميزة، تميز في القلب والأوعية الدموية، المفضل دبلوماسياً.';

  @override
  String get place_bayindir_hosp_knownFor =>
      'زراعة نخاع العظام، أمراض القلب، وطب الأسنان.';

  @override
  String get place_tobb_etu_hosp_knownFor =>
      'أمراض العمود الفقري، الجراحة طفيفة التوغل، رعاية كأنك من فئة رجال الأعمال.';

  @override
  String get place_lokman_hekim_ank_knownFor =>
      'جراحة الأعصاب، العظام، ورعاية الأمومة الصديقة للطفل.';

  @override
  String get place_liv_hosp_ankara_knownFor =>
      'الجراحة الروبوتية وجراحة السمنة، علاج السرطان.';

  @override
  String get place_koru_hosp_ankara_knownFor =>
      'جراحة السمنة الروبوتية، التلقيح الاصطناعي، وراحة المرضى.';

  @override
  String get place_dunyagoz_ankara_knownFor =>
      'متخصصون في طب العيون؛ حجم عمليات جراحي كبير.';

  @override
  String get place_medical_park_ank_knownFor => 'رعاية شاملة، وتكامل تكنولوجي.';

  @override
  String get place_dental_estetik_center_knownFor =>
      'خدمات طب الأسنان المتقدمة، والتجميل.';

  @override
  String get place_elos_klinik_knownFor =>
      'زراعة الشعر، العلاج بالخلايا الجذعية، وشفط الدهون.';

  @override
  String get place_dr_emin_eren_clinic_knownFor =>
      'الجراحة التجميلية، وتجميل الأنف.';

  @override
  String get place_genclik_parki_new_knownFor =>
      'البحيرة المركزية الضخمة، عروض الأضواء المسائية، مدينة الملاهي الكبيرة، والمركز الثقافي.';

  @override
  String get place_genclik_parki_new_entryFee => 'مجاني';

  @override
  String get place_genclik_parki_new_barbecue => 'غير مسموح';

  @override
  String get place_genclik_parki_new_history =>
      'تأسست في عام 1943 على أرض كانت في السابق مستنقعاً، وهي رمز للعصر الجمهوري صممت لتوفير ترفيه حديث للمواطنين.';

  @override
  String get place_kugulu_park_new_knownFor =>
      'البجع الجميل، الأشجار التاريخية، وموقعها في قلب شارع تونالي حلمي الشهير.';

  @override
  String get place_kugulu_park_new_entryFee => 'مجاني';

  @override
  String get place_kugulu_park_new_barbecue => 'غير مسموح';

  @override
  String get place_kugulu_park_new_history =>
      'منطقة طبيعية وتاريخية محمية. البجع الشهير في الحديقة كان في الأصل هدية من مدينة فيينا.';

  @override
  String get place_segmenler_parki_new_knownFor =>
      'المسرح المفتوح للحفلات، المساحات الخضراء الواسعة، وكونها مكاناً صديقاً للحيوانات الأليفة في حي تشانكايا.';

  @override
  String get place_segmenler_parki_new_entryFee => 'مجاني';

  @override
  String get place_segmenler_parki_new_barbecue => 'غير مسموح';

  @override
  String get place_segmenler_parki_new_history =>
      'افتتحت في أوائل الثمانينيات، وتضم نصباً تذكارياً مخصصاً لـ \"Seğmenler\" (الراقصين الشعبيين التقليديين).';

  @override
  String get place_eymir_golu_new_knownFor =>
      'مسار بطول 11 كم مثالي لركوب الدراجات والجري، مراقبة الطيور، والهدوء التام.';

  @override
  String get place_eymir_golu_new_entryFee =>
      'مجاني للمشاة والدرجات. رسوم للسيارات (تتطلب بطاقة جامعة METU أو الدخول بشروط)';

  @override
  String get place_eymir_golu_new_barbecue =>
      'ممنوع تماماً (لحماية النظام البيئي)';

  @override
  String get place_eymir_golu_new_history =>
      'تقع على أرض جامعة الشرق الأوسط التقنية؛ تم تشجيرها في الستينيات من خلال جهود رئيس الجامعة كمال كورداش لتحويل السهوب إلى مساحات خضراء.';

  @override
  String get place_goksu_parki_new_knownFor =>
      'الزحليقة الجبلية (Dağ Kızağı)، البحيرة الاصطناعية الكبيرة، ومرافق الشواء الممتازة.';

  @override
  String get place_goksu_parki_new_entryFee => 'مجاني';

  @override
  String get place_goksu_parki_new_barbecue => 'مسموح (في الأماكن المخصصة)';

  @override
  String get place_goksu_parki_new_history =>
      'بنيت على موقع مقلع حجارة سابق وافتتحت في عام 2003، حيث تحولت المنطقة الجافة إلى منطقة ترفيهية ضخمة في غضون أشهر قليلة.';

  @override
  String get place_mogan_parki_new_knownFor =>
      'مراقبة الطيور، المسارات الخشبية فوق الماء، المنارة، والنزهات العائلية الكبيرة.';

  @override
  String get place_mogan_parki_new_entryFee =>
      'مجاني للمشاة؛ رسوم للسيارات (تقريباً 30–50 ليرة)';

  @override
  String get place_mogan_parki_new_barbecue =>
      'مسموح (تتوفر مناطق واسعة ومعدات للإيجار)';

  @override
  String get place_mogan_parki_new_history =>
      'تم تطويرها حول بحيرة ترسبية طبيعية في منطقة غولباشي لتصبح مركز استجمام ضخم.';

  @override
  String get place_altinpark_new_knownFor =>
      'مركز فيزا غورسيه للعلوم، القاعات الخاصة بالمعارض، حلبات التزلج، والقوارب في البحيرة.';

  @override
  String get place_altinpark_new_entryFee =>
      'مجاني (قد تفرض رسوم على المواقف وبعض المراكز مثل\\nمركز العلوم)';

  @override
  String get place_altinpark_new_barbecue => 'غير مسموح';

  @override
  String get place_altinpark_new_history =>
      'واحدة من أكبر المناطق الترفيهية في أنقرة، تأسست على مساحة 640 ألف متر مربع.';

  @override
  String get place_harikalar_diyari_new_knownFor =>
      'طابع \"القصص الخيالية\" مع مجسمات ضخمة (مثل غوليفر)، مسارات الكارتينج، والأنشطة العائلية.';

  @override
  String get place_harikalar_diyari_new_entryFee => 'مجاني';

  @override
  String get place_harikalar_diyari_new_barbecue =>
      'مسموح (تتوفر أماكن مخصصة للنزهات)';

  @override
  String get place_harikalar_diyari_new_history =>
      'تعد واحدة من أكبر المنتزهات الحضرية في أوروبا (1.3 مليون متر مربع)، افتتحت لخدمة منطقة سينجان.';

  @override
  String get place_ataturk_cocuklari_parki_new_knownFor =>
      'حديقة الحيوان الرقمية (Digital Zoo)، استعادة مجرى نهر أنقرة، والمساحات الخضراء الضخمة (940 ألف متر مربع).';

  @override
  String get place_ataturk_cocuklari_parki_new_entryFee => 'مجاني';

  @override
  String get place_ataturk_cocuklari_parki_new_barbecue =>
      'غير مسموح (نزهات بدون دخان)';

  @override
  String get place_ataturk_cocuklari_parki_new_history =>
      'بنيت مؤخراً على أرض مزرعة أتاتورك التاريخية (AOÇ)، لاستعادة المنطقة كمتنزه عام بعد إغلاق حديقة أنكابارك المجاروة. افتتحت على مراحل حوالي 2024-2025.';

  @override
  String get place_botanik_parki_new_knownFor =>
      'تصميمها على طراز الحديقة الإنجليزية، إطلالاتها الرائعة على برج أتاكولي، والدفيئة الزجاجية للنباتات.';

  @override
  String get place_botanik_parki_new_entryFee => 'مجاني';

  @override
  String get place_botanik_parki_new_barbecue => 'غير مسموح';

  @override
  String get place_botanik_parki_new_history =>
      'تأسست في عام 1970 من قبل البروفيسور د. يوكسيل أوزتان في وادي تشانكايا.';

  @override
  String get place_dikmen_vadisi_new_knownFor =>
      'أطول مسار مشي مستمر في المدينة، جسورها المعلقة، وبراعم أشجار الكرز (Sakura) في الربيع.';

  @override
  String get place_dikmen_vadisi_new_entryFee => 'مجاني';

  @override
  String get place_dikmen_vadisi_new_barbecue =>
      'غير مسموح (التركيز على الرياضة والمشي)';

  @override
  String get place_dikmen_vadisi_new_history =>
      'مشروع تحول حضري ضخم حول وادي كان مليئاً بالعشوائيات إلى منتزه مكون من عدة مراحل.';

  @override
  String get place_zafer_parki_30_agustos_knownFor =>
      'مسارات الدراجات الواسعة، مسارات الجري، وتصميمها الذي يمنع دخول السيارات للداخل.';

  @override
  String get place_zafer_parki_30_agustos_entryFee => 'مجاني';

  @override
  String get place_zafer_parki_30_agustos_barbecue =>
      'غير مسموح (مفهوم طبيعي بدون دخان)';

  @override
  String get place_zafer_parki_30_agustos_history =>
      'افتتحت بجوار محطة حافلات AŞTİ لتكون \"نفساً\" حديثاً وسط ضجيج حركة المواصلات.';

  @override
  String get place_yildonumu_50_new_knownFor =>
      'إطلالة \"شرفة أنقرة\" البانورامية، سارية العلم الضخمة، والمساحات المرتفعة الهادئة.';

  @override
  String get place_yildonumu_50_new_entryFee => 'مجاني';

  @override
  String get place_yildonumu_50_new_barbecue => 'غير مسموح';

  @override
  String get place_yildonumu_50_new_history =>
      'بنيت احتفالاً بالذكرى الخمسين للجمهورية، وتقع على قمم جبل سيبيجي.';

  @override
  String get place_altinkoy_new_knownFor =>
      'البيوت الخشبية المرممة، طاحونة الهواء العاملة، الجسر المعلق، وورش الحرف التقليدية.';

  @override
  String get place_altinkoy_new_entryFee =>
      '20 ليرة (للكبار)، 10 ليرات (للطلاب)';

  @override
  String get place_altinkoy_new_barbecue =>
      'غير مسموح (تتوفر مطاعم تقدم أطعمة تقليدية)';

  @override
  String get place_altinkoy_new_history =>
      'أنشأته بلدية ألتنداغ لإحياء وتجسيد حياة القرية الأناضولية التقليدية من فترة الثلاثينيات إلى الخمسينيات.';

  @override
  String get place_kurtulus_parki_new_knownFor =>
      'صالة التزلج على الجليد، الأشجار الكثيفة، وسهولة الوصول عبر المترو.';

  @override
  String get place_kurtulus_parki_new_entryFee => 'مجاني';

  @override
  String get place_kurtulus_parki_new_barbecue => 'غير مسموح';

  @override
  String get place_kurtulus_parki_new_history =>
      'أحد أقدم الحديقة المركزية التي تخدم مناطق كيزيلاي وكوليج.';

  @override
  String get place_soguksu_milli_parki_knownFor =>
      'الينابيع الحرارية، غابات الصنوبر، الطيور النادرة، ومرافق التخييم.';

  @override
  String get place_soguksu_milli_parki_entryFee =>
      'تقريباً 40 ليرة للسيارات (رسوم دخول منتزه وطني)';

  @override
  String get place_soguksu_milli_parki_barbecue =>
      'مسموح (تتوفر مرافق تخييم ونزهات واسعة)';

  @override
  String get place_soguksu_milli_parki_history =>
      'منتزه وطني تأسس عام 1959 في المنطقة البركانية في كيزيلجاهامام.';

  @override
  String get medicalBookingContent =>
      'الدولة والجامعة (MHRS/182): تطبيق MHRS أو اتصل بـ 182. الخاص: اتصل بالمستشفى مباشرة أو عبر موقعهم.';

  @override
  String get medicalLanguageContent =>
      'معظم المستشفيات الحكومية تتحدث التركية فقط. اصطحب معك مترجماً أو استخدم ترجمة جوجل. المستشفيات الخاصة غالباً ما توفر مترجمين.';

  @override
  String get medicalInsuranceContent =>
      'الحكومي: يغطيه تأمين الطالب (GSS/SGK). الخاص: يغطي التأمين جزءاً وتدفع الفرق. تأمين السفر مقبول في بعض المستشفيات الخاصة.';

  @override
  String get medicalBringContent =>
      'الإقامة/الجواز (Kimlik)، أوراق التأمين، وأي تقارير طبية سابقة.';

  @override
  String get onboarding1Title => 'مرحباً بكم في أنقرة';

  @override
  String get onboarding1Desc =>
      'دليلك الشامل للمدينة - اكتشف الجامعات، المستشفيات، المولات والمزيد';

  @override
  String get onboarding2Title => 'اعثر على كل شيء';

  @override
  String get onboarding2Desc =>
      'ابحث واستكشف جميع الأماكن المهمة في أنقرة بسهولة';

  @override
  String get onboarding3Title => 'ابقَ على اطلاع';

  @override
  String get onboarding3Desc =>
      'احصل على إشعارات حول الفعاليات والأخبار المهمة';

  @override
  String get onboardingLanguageTitle => 'اختر اللغة';

  @override
  String get onboardingLanguageDesc =>
      'يرجى اختيار اللغة التي تود استخدامها في التطبيق';

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingStart => 'ابدأ';
}
