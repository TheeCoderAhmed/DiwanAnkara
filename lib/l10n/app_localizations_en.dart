// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Yemeni Student Community - Ankara';

  @override
  String get home => 'Home';

  @override
  String get more => 'More';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get dark => 'Dark';

  @override
  String get light => 'Light';

  @override
  String get system => 'System';

  @override
  String get hello => 'Welcome';

  @override
  String get searchHint => 'Search for announcements, events...';

  @override
  String get searchResults => 'Search Results';

  @override
  String get noResults => 'No results found';

  @override
  String get announcements => 'Announcements';

  @override
  String get viewAll => 'View All';

  @override
  String get ikamet => 'Ikamet';

  @override
  String get places => 'Places';

  @override
  String get projects => 'Projects';

  @override
  String get announcement => 'Announcement';

  @override
  String get announcementNotFound => 'Announcement not found';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get openLink => 'Open Link';

  @override
  String get addComment => 'Add Comment';

  @override
  String get shareOpinion => 'Share your opinion or inquiry about this news';

  @override
  String get name => 'Name';

  @override
  String get enterName => 'Enter your name';

  @override
  String get comment => 'Comment';

  @override
  String get writeComment => 'Write your comment here...';

  @override
  String get sendComment => 'Send Comment';

  @override
  String get commentReviewNote =>
      'Your comment will be reviewed by the administration';

  @override
  String waitMinutes(int minutes) {
    return 'Please wait $minutes minutes before sending another comment';
  }

  @override
  String get commentSuccess =>
      'Your comment has been sent successfully! It will be reviewed soon.';

  @override
  String get commentError =>
      'An error occurred while sending the comment. Please try again.';

  @override
  String get nameRequired => 'Please enter your name';

  @override
  String get nameTooShort => 'Name must be at least 2 characters';

  @override
  String get nameTooLong => 'Name must not exceed 50 characters';

  @override
  String get commentRequired => 'Please enter your comment';

  @override
  String get commentTooShort => 'Comment must be at least 10 characters';

  @override
  String linkError(Object error) {
    return 'Error opening link: $error';
  }

  @override
  String get eventsCalendar => 'Events Calendar';

  @override
  String get upcomingEvents => 'Upcoming Events';

  @override
  String get previousEvents => 'Previous Events';

  @override
  String get noEventsToday => 'No events today';

  @override
  String get noUpcomingEvents => 'No upcoming events';

  @override
  String get registerNow => 'Register Now';

  @override
  String get linkLaunchError => 'Could not open registration link';

  @override
  String eventsOf(Object date) {
    return 'Events on $date';
  }

  @override
  String get ikametTracker => 'Ikamet Tracker';

  @override
  String get ikametNoDateSet => 'Ikamet expiry date not set';

  @override
  String get ikametSetDate => 'Set expiry date';

  @override
  String get ikametExpiresIn => 'Expires in:';

  @override
  String get days => 'Days';

  @override
  String get ikametSafe => 'Safe';

  @override
  String get ikametWarning => 'Warning';

  @override
  String get ikametUrgent => 'Urgent!';

  @override
  String get studentResources => 'Useful resources for students';

  @override
  String get noUniversitiesInSection => 'No universities in this section';

  @override
  String get university => 'University';

  @override
  String get universityIntro => 'About the University';

  @override
  String get bachelorPrograms => 'Bachelor Programs';

  @override
  String get associatePrograms => 'Associate Programs';

  @override
  String get universityInTurkey => 'University in Turkey';

  @override
  String get noItemsInSection => 'No items found in this section';

  @override
  String get projectDetails => 'Project Details';

  @override
  String get callNow => 'Call Now';

  @override
  String get joinWhatsapp => 'Join group on WhatsApp';

  @override
  String get aboutProject => 'About Project';

  @override
  String get reviews => 'Reviews';

  @override
  String get shareExperience => 'Share your experience with others';

  @override
  String get noReviewsYet => 'No reviews yet';

  @override
  String get beFirstToReview => 'Be the first to share your experience!';

  @override
  String get addReview => 'Add Review';

  @override
  String get rating => 'Rating';

  @override
  String get writeReview => 'Write your review here...';

  @override
  String get cancel => 'Cancel';

  @override
  String get sendReview => 'Send Review';

  @override
  String get reviewSuccess =>
      'Your review was sent successfully! It will be published after review.';

  @override
  String get reviewError => 'An error occurred. Please try again.';

  @override
  String get reviewsLoadError => 'Error loading reviews';

  @override
  String get notifications => 'Notifications';

  @override
  String get clearAll => 'Clear All';

  @override
  String get noNotifications => 'No notifications found';

  @override
  String get clearAllTitle => 'Clear all notifications?';

  @override
  String get clearAllMessage =>
      'Are you sure you want to delete the entire notification history?';

  @override
  String get delete => 'Delete';

  @override
  String get savedPlaces => 'Saved Places';

  @override
  String get savedPlacesSubtitle => 'View your favorite places';

  @override
  String get aboutUs => 'About Us';

  @override
  String get aboutUsSubtitle => 'Community guide and info';

  @override
  String get supportUs => 'Support Us';

  @override
  String get supportUsSubtitle => 'Donate to support the community';

  @override
  String get appearance => 'Appearance';

  @override
  String get committees => 'Committees';

  @override
  String get committeesSubtitle => 'Previous committees over the years';

  @override
  String get oversight => 'Oversight';

  @override
  String get oversightSubtitle => 'Oversight committee members';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get arabic => 'Arabic';

  @override
  String get english => 'English';

  @override
  String get turkish => 'Turkish';

  @override
  String get themeFollowSystem => 'Follow system settings';

  @override
  String get themeAlwaysLight => 'Always light theme';

  @override
  String get themeAlwaysDark => 'Always dark theme';

  @override
  String get selectTheme => 'Select Theme';

  @override
  String get supportDesc =>
      'You can support the Yemeni community in Ankara by donating:';

  @override
  String get copy => 'Copy';

  @override
  String get copiedIban => 'IBAN copied to clipboard';

  @override
  String get close => 'Close';

  @override
  String get loadingData => 'Loading data, please try again later';

  @override
  String get exchangeRateError =>
      'Could not update rates. Using fallback rates.';

  @override
  String get retry => 'Retry';

  @override
  String get popularPlaces => 'Popular Places';

  @override
  String get partners => 'Our Partners';

  @override
  String get noPartners => 'No partners currently';

  @override
  String get catUniversity => 'Universities';

  @override
  String get catHospital => 'Hospitals';

  @override
  String get catMall => 'Shopping Malls';

  @override
  String get catHistoric => 'Historic Landmarks';

  @override
  String get catLibrary => 'Libraries';

  @override
  String get catTransport => 'Transportation';

  @override
  String get catGovOffice => 'Government Offices';

  @override
  String get catParks => 'Parks';

  @override
  String get catHousing => 'Housing Guide';

  @override
  String get catPartners => 'Partners';

  @override
  String get catAbout => 'About Us';

  @override
  String get catProject => 'Our Projects';

  @override
  String get catActivities => 'Activities & Recreation';

  @override
  String get catRestaurant => 'Restaurants';

  @override
  String get catMarket => 'Markets';

  @override
  String get noAnnouncementFound => 'Announcement not found';

  @override
  String get shareYourOpinion =>
      'Share your thoughts or inquiries about this news';

  @override
  String get pleaseEnterName => 'Please enter your name';

  @override
  String get writeCommentHere => 'Write your comment here...';

  @override
  String get pleaseEnterComment => 'Please enter your comment';

  @override
  String get errorOpeningLink => 'Error opening link';

  @override
  String get eventCalendar => 'Events Calendar';

  @override
  String eventsOnDate(String date) {
    return 'Events on $date';
  }

  @override
  String get showAll => 'Show All';

  @override
  String get noEventsOnDay => 'No events on this day';

  @override
  String get errorOpeningRegistrationLink => 'Could not open registration link';

  @override
  String get noUniversitiesFound => 'No universities found in this section';

  @override
  String get universityIntroduction => 'University Introduction';

  @override
  String get placeNotFound => 'Place not found';

  @override
  String get place => 'Place';

  @override
  String get navigate => 'Navigate';

  @override
  String get attachedDocuments => 'Attached Documents';

  @override
  String get pdfFile => 'PDF File';

  @override
  String get introductoryDocument => 'Introductory Document';

  @override
  String cannotOpenFile(String error) {
    return 'Cannot open file: $error';
  }

  @override
  String get showLess => 'Show Less';

  @override
  String get readMore => 'Read More';

  @override
  String get noSavedPlaces => 'No saved places found';

  @override
  String errorLoadingData(String error) {
    return 'Error loading data: $error';
  }

  @override
  String get joinWhatsappGroup => 'Join WhatsApp Group';

  @override
  String get clearAllNotificationsTitle => 'Clear all notifications?';

  @override
  String get clearAllNotificationsMessage =>
      'Are you sure you want to delete all notification history?';

  @override
  String get clear => 'Clear';

  @override
  String get pastOversightCommittees => 'Past Oversight Committees';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get selectYear => 'Select Year';

  @override
  String get noMembersForYear => 'No members for this year';

  @override
  String get pastContributors => 'Past Board Members';

  @override
  String get noContributorsForYear => 'No contributors for this year';

  @override
  String get directory => 'Directory';

  @override
  String get sections => 'Sections';

  @override
  String get noResidencyGuide => 'Residency guide not available currently';

  @override
  String get fileLinkNotAvailable => 'File link not available';

  @override
  String get noHousingGuide => 'Housing guide not available currently';

  @override
  String get pdfLinkNotAvailable => 'PDF link not available';

  @override
  String get residencyGuide => 'Residency Guide (PDF)';

  @override
  String get housingGuide => 'Housing Guide (PDF)';

  @override
  String get currencyConverter => 'Currency Converter';

  @override
  String get refreshRates => 'Refresh Rates';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get contactAndInquiry => 'Contact and Inquiry';

  @override
  String get fundManager => 'Fund Manager';

  @override
  String get eventDetails => 'Event Details';

  @override
  String get pastEvents => 'Past Events';

  @override
  String get noPastEvents => 'No past events found';

  @override
  String get eventCategorySports => 'Sports';

  @override
  String get eventCategoryCulture => 'Culture & Arts';

  @override
  String get eventCategoryEducational => 'Educational';

  @override
  String get eventCategorySocial => 'Social';

  @override
  String get eventCategoryReligious => 'Religious';

  @override
  String get eventCategoryOther => 'Other';

  @override
  String get downloadingLanguageModel => 'Downloading language pack...';

  @override
  String get languageModelDownloaded =>
      'Language pack downloaded successfully.';

  @override
  String get reportSafetyConcern => 'Report a Safety Concern';

  @override
  String get reportSafetyConcernSubtitle =>
      'Contact us to report any safety issues or violations';

  @override
  String get socialConnect => 'Social Connect';

  @override
  String get location => 'Location';

  @override
  String get globalRank => 'Global Rank';

  @override
  String get degrees => 'Degrees';

  @override
  String get bachelorsAndMore => 'Bachelors +';

  @override
  String get openInGoogleMaps => 'Open in Google Maps';

  @override
  String get navigateNow => 'Navigate Now';

  @override
  String get noDescriptionAvailable => 'No description available.';

  @override
  String get established => 'Established';

  @override
  String get knownFor => 'Known For';

  @override
  String get hospitalType => 'Hospital Type';

  @override
  String get medicalAdvice => 'Medical & Hospital Advice';

  @override
  String get bookingMethod => 'Booking Method';

  @override
  String get languageTip => 'Language Tips';

  @override
  String get insuranceInfo => 'Insurance & Costs';

  @override
  String get whatToBring => 'What to Bring';

  @override
  String get howToBook => 'How to Book';

  @override
  String get hospitalAdvices => 'Hospital Advices';

  @override
  String get entryFee => 'Entry Fee';

  @override
  String get barbecue => 'Barbecue';

  @override
  String get history => 'History';

  @override
  String get parkAdvices => 'Park Advice';

  @override
  String get seasonalRules => 'Seasonal Rules';

  @override
  String get fuelTypes => 'Fuel Types';

  @override
  String get arrivalTime => 'Arrival Time';

  @override
  String get seasonalRulesContent =>
      'Seasonal Bans: Typically from June/July until September 30, the Ankara Governorate often issues a city-wide ban on all barbecues and open fires to prevent forest fires.';

  @override
  String get fuelTypesContent =>
      'Fuel Types: You are generally expected to bring your own charcoal. Using wood or large logs that create excessive flame and smoke outside the grill units is prohibited.';

  @override
  String get arrivalTimeContent =>
      'Arrival Time: On weekends, barbecue spots fill up very early (often by 9:00 AM or 10:00 AM). If you aren\'t there early, you might find the spots taken.';

  @override
  String get place_metu_uni_name =>
      'Middle East Technical University (METU/ODTÜ)';

  @override
  String get place_metu_uni_desc =>
      'Middle East Technical University (METU/ODTÜ) (Description available in Arabic/Turkish)';

  @override
  String get place_hacettepe_uni_name => 'Hacettepe University';

  @override
  String get place_hacettepe_uni_desc =>
      'Hacettepe University (Description available in Arabic/Turkish)';

  @override
  String get place_ankara_uni_name => 'Ankara University';

  @override
  String get place_ankara_uni_desc =>
      'Ankara University (Description available in Arabic/Turkish)';

  @override
  String get place_gazi_uni_name => 'Gazi University';

  @override
  String get place_gazi_uni_desc =>
      'Gazi University (Description available in Arabic/Turkish)';

  @override
  String get place_aybu_uni_name => 'Ankara Yıldırım Beyazıt University (AYBU)';

  @override
  String get place_aybu_uni_desc =>
      'Ankara Yıldırım Beyazıt University (AYBU) (Description available in Arabic/Turkish)';

  @override
  String get place_haci_bayram_veli_name =>
      'Ankara Hacı Bayram Veli University (AHBVU)';

  @override
  String get place_haci_bayram_veli_desc =>
      'Ankara Hacı Bayram Veli University (AHBVU) (Description available in Arabic/Turkish)';

  @override
  String get place_asbu_uni_name =>
      'Social Sciences University of Ankara (ASBU)';

  @override
  String get place_asbu_uni_desc =>
      'Social Sciences University of Ankara (ASBU) (Description available in Arabic/Turkish)';

  @override
  String get place_mgu_uni_name =>
      'Ankara Music and Fine Arts University (MGU)';

  @override
  String get place_mgu_uni_desc =>
      'Ankara Music and Fine Arts University (MGU) (Description available in Arabic/Turkish)';

  @override
  String get place_bilkent_uni_name => 'Bilkent University';

  @override
  String get place_bilkent_uni_desc =>
      'Bilkent University (Description available in Arabic/Turkish)';

  @override
  String get place_cankaya_uni_name => 'Çankaya University';

  @override
  String get place_cankaya_uni_desc =>
      'Çankaya University (Description available in Arabic/Turkish)';

  @override
  String get place_tobb_etu_name =>
      'TOBB University of Economics and Technology';

  @override
  String get place_tobb_etu_desc =>
      'TOBB University of Economics and Technology (Description available in Arabic/Turkish)';

  @override
  String get place_atilim_uni_name => 'Atılım University';

  @override
  String get place_atilim_uni_desc =>
      'Atılım University (Description available in Arabic/Turkish)';

  @override
  String get place_baskent_uni_name => 'Başkent University';

  @override
  String get place_baskent_uni_desc =>
      'Başkent University (Description available in Arabic/Turkish)';

  @override
  String get place_tedu_uni_name => 'TED University';

  @override
  String get place_tedu_uni_desc =>
      'TED University (Description available in Arabic/Turkish)';

  @override
  String get place_ostim_tech_name => 'OSTİM Technical University';

  @override
  String get place_ostim_tech_desc =>
      'OSTİM Technical University (Description available in Arabic/Turkish)';

  @override
  String get place_lokman_hekim_name => 'Lokman Hekim University';

  @override
  String get place_lokman_hekim_desc =>
      'Lokman Hekim University (Description available in Arabic/Turkish)';

  @override
  String get place_medipol_ankara_name => 'Ankara Medipol University';

  @override
  String get place_medipol_ankara_desc =>
      'Ankara Medipol University (Description available in Arabic/Turkish)';

  @override
  String get place_thk_uni_name =>
      'University of Turkish Aeronautical Association (THK University)';

  @override
  String get place_thk_uni_desc =>
      'University of Turkish Aeronautical Association (THK University) (Description available in Arabic/Turkish)';

  @override
  String get place_ufuk_uni_name => 'Ufuk University';

  @override
  String get place_ufuk_uni_desc =>
      'Ufuk University (Description available in Arabic/Turkish)';

  @override
  String get place_yuksek_ihtisas_name => 'Yüksek İhtisas University';

  @override
  String get place_yuksek_ihtisas_desc =>
      'Yüksek İhtisas University (Description available in Arabic/Turkish)';

  @override
  String get place_ankara_bilim_name =>
      'Ankara Science University (Ankara Bilim)';

  @override
  String get place_ankara_bilim_desc =>
      'Ankara Science University (Ankara Bilim) (Description available in Arabic/Turkish)';

  @override
  String get place_health_sciences_uni_name =>
      'University of Health Sciences (SBÜ) – Gülhane Campus';

  @override
  String get place_health_sciences_uni_desc =>
      'University of Health Sciences (SBÜ) – Gülhane Campus (Description available in Arabic/Turkish)';

  @override
  String get place_police_academy_name => 'Turkish National Police Academy';

  @override
  String get place_police_academy_desc =>
      'Turkish National Police Academy (Description available in Arabic/Turkish)';

  @override
  String get place_national_defense_uni_name =>
      'National Defense University – Turkish Military Academy';

  @override
  String get place_national_defense_uni_desc =>
      'National Defense University – Turkish Military Academy (Description available in Arabic/Turkish)';

  @override
  String get place_medical_advice_name => 'Medical Appointment Advice';

  @override
  String get place_medical_advice_desc =>
      'Medical Appointment Advice (Description available in Arabic/Turkish)';

  @override
  String get place_bilkent_city_hosp_name => 'Ankara Bilkent City Hospital';

  @override
  String get place_bilkent_city_hosp_desc =>
      'Ankara Bilkent City Hospital (Description available in Arabic/Turkish)';

  @override
  String get place_hacettepe_uni_hosp_name => 'Hacettepe University Hospitals';

  @override
  String get place_hacettepe_uni_hosp_desc =>
      'Hacettepe University Hospitals (Description available in Arabic/Turkish)';

  @override
  String get place_ankara_uni_hosp_name =>
      'Ankara University Hospitals (İbni Sina & Cebeci)';

  @override
  String get place_ankara_uni_hosp_desc =>
      'Ankara University Hospitals (İbni Sina & Cebeci) (Description available in Arabic/Turkish)';

  @override
  String get place_gazi_uni_hosp_name => 'Gazi University Hospital';

  @override
  String get place_gazi_uni_hosp_desc =>
      'Gazi University Hospital (Description available in Arabic/Turkish)';

  @override
  String get place_gulhane_hosp_name =>
      'Gülhane Training and Research Hospital (GATA)';

  @override
  String get place_gulhane_hosp_desc =>
      'Gülhane Training and Research Hospital (GATA) (Description available in Arabic/Turkish)';

  @override
  String get place_etlik_city_hosp_name => 'Etlik City Hospital';

  @override
  String get place_etlik_city_hosp_desc =>
      'Etlik City Hospital (Description available in Arabic/Turkish)';

  @override
  String get place_acibadem_ankara_name => 'Acıbadem Ankara Hospital';

  @override
  String get place_acibadem_ankara_desc =>
      'Acıbadem Ankara Hospital (Description available in Arabic/Turkish)';

  @override
  String get place_memorial_ankara_name => 'Memorial Ankara Hospital';

  @override
  String get place_memorial_ankara_desc =>
      'Memorial Ankara Hospital (Description available in Arabic/Turkish)';

  @override
  String get place_medicana_ankara_name => 'Medicana International Ankara';

  @override
  String get place_medicana_ankara_desc =>
      'Medicana International Ankara (Description available in Arabic/Turkish)';

  @override
  String get place_guven_hosp_name => 'Güven Hospital';

  @override
  String get place_guven_hosp_desc =>
      'Güven Hospital (Description available in Arabic/Turkish)';

  @override
  String get place_bayindir_hosp_name => 'Bayındır Hospital (Söğütözü)';

  @override
  String get place_bayindir_hosp_desc =>
      'Bayındır Hospital (Söğütözü) (Description available in Arabic/Turkish)';

  @override
  String get place_tobb_etu_hosp_name => 'TOBB ETÜ Hospital';

  @override
  String get place_tobb_etu_hosp_desc =>
      'TOBB ETÜ Hospital (Description available in Arabic/Turkish)';

  @override
  String get place_lokman_hekim_ank_name =>
      'Lokman Hekim University Ankara Hospital';

  @override
  String get place_lokman_hekim_ank_desc =>
      'Lokman Hekim University Ankara Hospital (Description available in Arabic/Turkish)';

  @override
  String get place_liv_hosp_ankara_name => 'Liv Hospital Ankara';

  @override
  String get place_liv_hosp_ankara_desc =>
      'Liv Hospital Ankara (Description available in Arabic/Turkish)';

  @override
  String get place_koru_hosp_ankara_name => 'Koru Ankara Hospital';

  @override
  String get place_koru_hosp_ankara_desc =>
      'Koru Ankara Hospital (Description available in Arabic/Turkish)';

  @override
  String get place_dunyagoz_ankara_name => 'Dünyagöz Ankara';

  @override
  String get place_dunyagoz_ankara_desc =>
      'Dünyagöz Ankara (Description available in Arabic/Turkish)';

  @override
  String get place_medical_park_ank_name => 'Medical Park Ankara';

  @override
  String get place_medical_park_ank_desc =>
      'Medical Park Ankara (Description available in Arabic/Turkish)';

  @override
  String get place_dental_estetik_center_name => 'Dental Estetik Center';

  @override
  String get place_dental_estetik_center_desc =>
      'Dental Estetik Center (Description available in Arabic/Turkish)';

  @override
  String get place_elos_klinik_name => 'Elos Klinik';

  @override
  String get place_elos_klinik_desc =>
      'Elos Klinik (Description available in Arabic/Turkish)';

  @override
  String get place_dr_emin_eren_clinic_name => 'Dr. Emin Eren Clinic';

  @override
  String get place_dr_emin_eren_clinic_desc =>
      'Dr. Emin Eren Clinic (Description available in Arabic/Turkish)';

  @override
  String get place_genclik_parki_new_name => 'Gençlik Parkı';

  @override
  String get place_genclik_parki_new_desc =>
      'Gençlik Parkı (Description available in Arabic/Turkish)';

  @override
  String get place_kugulu_park_new_name => 'Kuğulu Park';

  @override
  String get place_kugulu_park_new_desc =>
      'Kuğulu Park (Description available in Arabic/Turkish)';

  @override
  String get place_segmenler_parki_new_name => 'Seğmenler Parkı';

  @override
  String get place_segmenler_parki_new_desc =>
      'Seğmenler Parkı (Description available in Arabic/Turkish)';

  @override
  String get place_eymir_golu_new_name => 'Eymir Gölü';

  @override
  String get place_eymir_golu_new_desc =>
      'Eymir Gölü (Description available in Arabic/Turkish)';

  @override
  String get place_goksu_parki_new_name => 'Göksu Parkı';

  @override
  String get place_goksu_parki_new_desc =>
      'Göksu Parkı (Description available in Arabic/Turkish)';

  @override
  String get place_mogan_parki_new_name => 'Mogan Parkı (Lake Mogan)';

  @override
  String get place_mogan_parki_new_desc =>
      'Mogan Parkı (Lake Mogan) (Description available in Arabic/Turkish)';

  @override
  String get place_altinpark_new_name => 'Altınpark';

  @override
  String get place_altinpark_new_desc =>
      'Altınpark (Description available in Arabic/Turkish)';

  @override
  String get place_harikalar_diyari_new_name => 'Harikalar Diyarı (Wonderland)';

  @override
  String get place_harikalar_diyari_new_desc =>
      'Harikalar Diyarı (Wonderland) (Description available in Arabic/Turkish)';

  @override
  String get place_ataturk_cocuklari_parki_new_name =>
      'Atatürk Çocukları ve Doğal Yaşam Parkı';

  @override
  String get place_ataturk_cocuklari_parki_new_desc =>
      'Atatürk Çocukları ve Doğal Yaşam Parkı (Description available in Arabic/Turkish)';

  @override
  String get place_botanik_parki_new_name => 'Botanik Parkı';

  @override
  String get place_botanik_parki_new_desc =>
      'Botanik Parkı (Description available in Arabic/Turkish)';

  @override
  String get place_dikmen_vadisi_new_name => 'Dikmen Vadisi';

  @override
  String get place_dikmen_vadisi_new_desc =>
      'Dikmen Vadisi (Description available in Arabic/Turkish)';

  @override
  String get place_zafer_parki_30_agustos_name => '30 Ağustos Zafer Parkı';

  @override
  String get place_zafer_parki_30_agustos_desc =>
      '30 Ağustos Zafer Parkı (Description available in Arabic/Turkish)';

  @override
  String get place_yildonumu_50_new_name => '50. Yıl Parkı';

  @override
  String get place_yildonumu_50_new_desc =>
      '50. Yıl Parkı (Description available in Arabic/Turkish)';

  @override
  String get place_altinkoy_new_name => 'Altınköy Açık Hava Müzesي';

  @override
  String get place_altinkoy_new_desc =>
      'Altınköy Açık Hava Müzesي (Description available in Arabic/Turkish)';

  @override
  String get place_kurtulus_parki_new_name => 'Kurtuluş Parkı';

  @override
  String get place_kurtulus_parki_new_desc =>
      'Kurtuluş Parkı (Description available in Arabic/Turkish)';

  @override
  String get place_soguksu_milli_parki_name => 'Soğuksu Milli Parkı';

  @override
  String get place_soguksu_milli_parki_desc =>
      'Soğuksu Milli Parkı (Description available in Arabic/Turkish)';

  @override
  String get place_ankara_transport_guide_2026_name =>
      'Ankara Ulaşım Rehberi 2026';

  @override
  String get place_ankara_transport_guide_2026_desc =>
      'Ankara Ulaşım Rehberi 2026 (Description available in Arabic/Turkish)';

  @override
  String get place_migration_management_ankara_name =>
      'Ankara İl Göç İdaresi (Migration Management)';

  @override
  String get place_migration_management_ankara_desc =>
      'Ankara İl Göç İdaresi (Migration Management) (Description available in Arabic/Turkish)';

  @override
  String get place_yemen_embassy_ankara_name =>
      'Yemen Büyükelçiliği (Yemeni Embassy)';

  @override
  String get place_yemen_embassy_ankara_desc =>
      'Yemen Büyükelçiliği (Yemeni Embassy) (Description available in Arabic/Turkish)';

  @override
  String get place_yok_ankara_name => 'Yükseköğretim Kurulu (YÖK)';

  @override
  String get place_yok_ankara_desc =>
      'Yükseköğretim Kurulu (YÖK) (Description available in Arabic/Turkish)';

  @override
  String get place_nufus_mudurlugu_ankara_name =>
      'İl Nüfus ve Vatandaşlık Müdürlüğü';

  @override
  String get place_nufus_mudurlugu_ankara_desc =>
      'İl Nüfus ve Vatandaşlık Müdürlüğü (Description available in Arabic/Turkish)';

  @override
  String get place_sgk_ankara_name => 'Sosyal Güvenlik Kurumu (SGK)';

  @override
  String get place_sgk_ankara_desc =>
      'Sosyal Güvenlik Kurumu (SGK) (Description available in Arabic/Turkish)';

  @override
  String get place_tax_office_ankara_name => 'Vergi Dairesi (Tax Office)';

  @override
  String get place_tax_office_ankara_desc =>
      'Vergi Dairesi (Tax Office) (Description available in Arabic/Turkish)';

  @override
  String get place_yemeni_student_gov_checklist_name =>
      'ملخص المعاملات الحكومية للطلاب اليمنيين 2026';

  @override
  String get place_yemeni_student_gov_checklist_desc =>
      'ملخص المعاملات الحكومية للطلاب اليمنيين 2026 (Description available in Arabic/Turkish)';

  @override
  String get place_ankamall_full_name => 'ANKAmall';

  @override
  String get place_ankamall_full_desc =>
      'ANKAmall (Description available in Arabic/Turkish)';

  @override
  String get place_armada_full_name => 'Armada Shopping & Business';

  @override
  String get place_armada_full_desc =>
      'Armada Shopping & Business (Description available in Arabic/Turkish)';

  @override
  String get place_panora_full_name => 'Panora Shopping Center';

  @override
  String get place_panora_full_desc =>
      'Panora Shopping Center (Description available in Arabic/Turkish)';

  @override
  String get place_atakule_full_name => 'Atakule';

  @override
  String get place_atakule_full_desc =>
      'Atakule (Description available in Arabic/Turkish)';

  @override
  String get place_bilkent_center_name => 'Bilkent Center';

  @override
  String get place_bilkent_center_desc =>
      'Bilkent Center (Description available in Arabic/Turkish)';

  @override
  String get place_kentpark_full_name => 'Kentpark';

  @override
  String get place_kentpark_full_desc =>
      'Kentpark (Description available in Arabic/Turkish)';

  @override
  String get place_cepa_full_name => 'Cepa';

  @override
  String get place_cepa_full_desc =>
      'Cepa (Description available in Arabic/Turkish)';

  @override
  String get place_gordion_full_name => 'Gordion';

  @override
  String get place_gordion_full_desc =>
      'Gordion (Description available in Arabic/Turkish)';

  @override
  String get place_arcadium_name => 'Arcadium';

  @override
  String get place_arcadium_desc =>
      'Arcadium (Description available in Arabic/Turkish)';

  @override
  String get place_kizilay_avm_name => 'Kızılay AVM';

  @override
  String get place_kizilay_avm_desc =>
      'Kızılay AVM (Description available in Arabic/Turkish)';

  @override
  String get place_acity_outlet_name => 'ACity Outlet';

  @override
  String get place_acity_outlet_desc =>
      'ACity Outlet (Description available in Arabic/Turkish)';

  @override
  String get place_forum_ankara_name => 'Forum Ankara Outlet';

  @override
  String get place_forum_ankara_desc =>
      'Forum Ankara Outlet (Description available in Arabic/Turkish)';

  @override
  String get place_antares_mall_name => 'Antares';

  @override
  String get place_antares_mall_desc =>
      'Antares (Description available in Arabic/Turkish)';

  @override
  String get place_nata_vega_name => 'Nata Vega';

  @override
  String get place_nata_vega_desc =>
      'Nata Vega (Description available in Arabic/Turkish)';

  @override
  String get place_anatolium_ankara_name => 'Anatolium';

  @override
  String get place_anatolium_ankara_desc =>
      'Anatolium (Description available in Arabic/Turkish)';

  @override
  String get place_taurus_mall_name => 'Taurus';

  @override
  String get place_taurus_mall_desc =>
      'Taurus (Description available in Arabic/Turkish)';

  @override
  String get place_podium_mall_name => 'Podium';

  @override
  String get place_podium_mall_desc =>
      'Podium (Description available in Arabic/Turkish)';

  @override
  String get place_next_level_full_name => 'Next Level';

  @override
  String get place_next_level_full_desc =>
      'Next Level (Description available in Arabic/Turkish)';

  @override
  String get place_tepe_prime_name => 'Tepe Prime';

  @override
  String get place_tepe_prime_desc =>
      'Tepe Prime (Description available in Arabic/Turkish)';

  @override
  String get place_karum_mall_name => 'Karum';

  @override
  String get place_karum_mall_desc =>
      'Karum (Description available in Arabic/Turkish)';

  @override
  String get place_atlantis_mall_name => 'Atlantis';

  @override
  String get place_atlantis_mall_desc =>
      'Atlantis (Description available in Arabic/Turkish)';

  @override
  String get place_galleria_mall_name => 'Galleria';

  @override
  String get place_galleria_mall_desc =>
      'Galleria (Description available in Arabic/Turkish)';

  @override
  String get place_optimum_outlet_name => 'Optimum Outlet';

  @override
  String get place_optimum_outlet_desc =>
      'Optimum Outlet (Description available in Arabic/Turkish)';

  @override
  String get place_ftz_mall_name => 'FTZ';

  @override
  String get place_ftz_mall_desc =>
      'FTZ (Description available in Arabic/Turkish)';

  @override
  String get place_365_mall_name => '365 Shopping Mall';

  @override
  String get place_365_mall_desc =>
      '365 Shopping Mall (Description available in Arabic/Turkish)';

  @override
  String get place_one_tower_mall_name => 'One Tower';

  @override
  String get place_one_tower_mall_desc =>
      'One Tower (Description available in Arabic/Turkish)';

  @override
  String get place_anatolian_civil_museum_name =>
      'Anadolu Medeniyetleri Müzesi';

  @override
  String get place_anatolian_civil_museum_desc =>
      'Anadolu Medeniyetleri Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_anitkabir_full_name => 'Anıtkabir';

  @override
  String get place_anitkabir_full_desc =>
      'Anıtkabir (Description available in Arabic/Turkish)';

  @override
  String get place_ethnography_museum_name => 'Ankara Etnografya Müzesi';

  @override
  String get place_ethnography_museum_desc =>
      'Ankara Etnografya Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_rahmi_koc_museum_name => 'Rahmi M. Koç Müzesi';

  @override
  String get place_rahmi_koc_museum_desc =>
      'Rahmi M. Koç Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_ulucanlar_prison_name => 'Ulucanlar Cezaevi Müzesi';

  @override
  String get place_ulucanlar_prison_desc =>
      'Ulucanlar Cezaevi Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_erimtan_museum_name => 'Erimtan Arkeoloji ve Sanat Müzesi';

  @override
  String get place_erimtan_museum_desc =>
      'Erimtan Arkeoloji ve Sanat Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_cermodern_name => 'CerModern';

  @override
  String get place_cermodern_desc =>
      'CerModern (Description available in Arabic/Turkish)';

  @override
  String get place_first_parliament_name => 'Kurtuluş Savaşı Müzesi (I. TBMM)';

  @override
  String get place_first_parliament_desc =>
      'Kurtuluş Savaşı Müzesi (I. TBMM) (Description available in Arabic/Turkish)';

  @override
  String get place_republic_museum_name => 'Cumhuriyet Müzesi (II. TBMM)';

  @override
  String get place_republic_museum_desc =>
      'Cumhuriyet Müzesi (II. TBMM) (Description available in Arabic/Turkish)';

  @override
  String get place_state_art_sculpture_name => 'Ankara Resim ve Heykel Müzesi';

  @override
  String get place_state_art_sculpture_desc =>
      'Ankara Resim ve Heykel Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_gordion_museum_name => 'Gordion Müzesي';

  @override
  String get place_gordion_museum_desc =>
      'Gordion Müzesي (Description available in Arabic/Turkish)';

  @override
  String get place_roman_baths_name => 'Roma Hamamı';

  @override
  String get place_roman_baths_desc =>
      'Roma Hamamı (Description available in Arabic/Turkish)';

  @override
  String get place_altinkoy_museum_name => 'Altınköy Açık Hava Müzesi';

  @override
  String get place_altinkoy_museum_desc =>
      'Altınköy Açık Hava Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_mta_natural_history_name =>
      'MTA Şehit Cuma Dağ Tabiat Tarihi Müzesi';

  @override
  String get place_mta_natural_history_desc =>
      'MTA Şehit Cuma Dağ Tabiat Tarihi Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_ankara_vakif_museum_name => 'Ankara Vakıf Eserleri Müzesi';

  @override
  String get place_ankara_vakif_museum_desc =>
      'Ankara Vakıf Eserleri Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_july_15_museum_name =>
      '15 Temmuz Şehitler ve Demokrasi Müzesi';

  @override
  String get place_july_15_museum_desc =>
      '15 Temmuz Şehitler ve Demokrasi Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_haci_bayram_full_name => 'Hacı Bayram Veli Mosque & Tomb';

  @override
  String get place_haci_bayram_full_desc =>
      'Hacı Bayram Veli Mosque & Tomb (Description available in Arabic/Turkish)';

  @override
  String get place_kocatepe_mosque_full_name => 'Kocatepe Mosque';

  @override
  String get place_kocatepe_mosque_full_desc =>
      'Kocatepe Mosque (Description available in Arabic/Turkish)';

  @override
  String get place_augustus_temple_name => 'Augustus Tapınağı';

  @override
  String get place_augustus_temple_desc =>
      'Augustus Tapınağı (Description available in Arabic/Turkish)';

  @override
  String get place_feza_gursey_center_name => 'Feza Gürsey Bilim Merkezi';

  @override
  String get place_feza_gursey_center_desc =>
      'Feza Gürsey Bilim Merkezi (Description available in Arabic/Turkish)';

  @override
  String get place_metu_science_tech_name => 'ODTÜ Bilim ve Teknoloji Müzesi';

  @override
  String get place_metu_science_tech_desc =>
      'ODTÜ Bilim ve Teknoloji Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_meiif_er_soy_lit_name => 'Mehmet Akif Ersoy Edebiyat Müzesi';

  @override
  String get place_meiif_er_soy_lit_desc =>
      'Mehmet Akif Ersoy Edebiyat Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_mit_espionage_museum_name => 'MİT İstihbarat Müzesi';

  @override
  String get place_mit_espionage_museum_desc =>
      'MİT İstihbarat Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_tcdd_steam_loco_name =>
      ' TCDD Açık Hava Buharlı Lokomotif Müzesi';

  @override
  String get place_tcdd_steam_loco_desc =>
      ' TCDD Açık Hava Buharlı Lokomotif Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_ataturk_mansion_name => 'Atatürk Müze Köşkü';

  @override
  String get place_ataturk_mansion_desc =>
      'Atatürk Müze Köşkü (Description available in Arabic/Turkish)';

  @override
  String get place_pembe_kosk_name => 'Pembe Köşk (İsmet İnönü House)';

  @override
  String get place_pembe_kosk_desc =>
      'Pembe Köşk (İsmet İnönü House) (Description available in Arabic/Turkish)';

  @override
  String get place_isbank_museum_ank_name => 'Türkiye İş Bankası Müzesi';

  @override
  String get place_isbank_museum_ank_desc =>
      'Türkiye İş Bankası Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_thk_aeronautical_name => 'Türk Hava Kurumu Müzesi';

  @override
  String get place_thk_aeronautical_desc =>
      'Türk Hava Kurumu Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_stamp_museum_ank_name => 'PTT Pul Müzesي';

  @override
  String get place_stamp_museum_ank_desc =>
      'PTT Pul Müzesي (Description available in Arabic/Turkish)';

  @override
  String get place_gokyay_chess_museum_name => 'Gökyay Vakfı Satranç Müzesi';

  @override
  String get place_gokyay_chess_museum_desc =>
      'Gökyay Vakfı Satranç Müzesi (Description available in Arabic/Turkish)';

  @override
  String get place_trt_publishing_history_name =>
      'TRT Yayıncılık Tarihi Müzesي';

  @override
  String get place_trt_publishing_history_desc =>
      'TRT Yayıncılık Tarihi Müzesي (Description available in Arabic/Turkish)';

  @override
  String get place_presidential_library_full_name =>
      'Cumhurbaşkanlığı Millet Kütüphanesi';

  @override
  String get place_presidential_library_full_desc =>
      'Cumhurbaşkanlığı Millet Kütüphanesi (Description available in Arabic/Turkish)';

  @override
  String get place_national_library_full_name => 'Millî Kütüphane';

  @override
  String get place_national_library_full_desc =>
      'Millî Kütüphane (Description available in Arabic/Turkish)';

  @override
  String get place_bilkent_library_full_name =>
      'Bilkent Üniversitesi Kütüphanesi';

  @override
  String get place_bilkent_library_full_desc =>
      'Bilkent Üniversitesi Kütüphanesi (Description available in Arabic/Turkish)';

  @override
  String get place_ttk_library_full_name => 'Türk Tarih Kurumu Kütüphanesi';

  @override
  String get place_ttk_library_full_desc =>
      'Türk Tarih Kurumu Kütüphanesi (Description available in Arabic/Turkish)';

  @override
  String get place_yok_thesis_center_name => 'YÖK Ulusal Tez Merkezi';

  @override
  String get place_yok_thesis_center_desc =>
      'YÖK Ulusal Tez Merkezi (Description available in Arabic/Turkish)';

  @override
  String get place_tbmm_library_full_name => 'TBMM Kütüphanesi';

  @override
  String get place_tbmm_library_full_desc =>
      'TBMM Kütüphanesi (Description available in Arabic/Turkish)';

  @override
  String get place_metu_uni_knownFor =>
      'Engineering excellence, leading technical university, English education.';

  @override
  String get place_hacettepe_uni_knownFor =>
      'Leader in medicine and health sciences, highest national research impact.';

  @override
  String get place_ankara_uni_knownFor =>
      'First university of the Republic, distinguished in Law, Political Science (Mülkiye), and Medicine.';

  @override
  String get place_gazi_uni_knownFor =>
      'Teacher training, engineering, technology; strong industry integration.';

  @override
  String get place_aybu_uni_knownFor =>
      'English education, Medicine and Engineering, high ratio of international students.';

  @override
  String get place_haci_bayram_veli_knownFor =>
      'Social sciences, Arts, Tourism (Gastronomy), Law.';

  @override
  String get place_asbu_uni_knownFor =>
      'Specialized in Social Sciences, research-oriented; Law, Political Science, Islamic Studies.';

  @override
  String get place_mgu_uni_knownFor =>
      'Specialized university for Music and Fine Arts.';

  @override
  String get place_bilkent_uni_knownFor =>
      'First private university, world-class research, Engineering and Economics.';

  @override
  String get place_cankaya_uni_knownFor =>
      'High research impact, Engineering, Architecture, Law.';

  @override
  String get place_tobb_etu_knownFor =>
      'Cooperative education model (compulsory internship), strong business ties.';

  @override
  String get place_atilim_uni_knownFor =>
      'Civil Aviation, Engineering, Research productivity.';

  @override
  String get place_baskent_uni_knownFor =>
      'First private health university, Medicine and Dentistry, wide hospital network.';

  @override
  String get place_tedu_uni_knownFor =>
      'Liberal arts model, Architecture and Education, focus on soft skills.';

  @override
  String get place_ostim_tech_knownFor =>
      'Industrial university model, practical training and entrepreneurship.';

  @override
  String get place_lokman_hekim_knownFor =>
      'Specialized in Health; Medicine, Pharmacy, Sports Sciences.';

  @override
  String get place_medipol_ankara_knownFor =>
      'Health sciences, modern facilities, Medicine and Dentistry.';

  @override
  String get place_thk_uni_knownFor =>
      'Specialization in Aviation and Aerospace, pilot training.';

  @override
  String get place_ufuk_uni_knownFor => 'Medicine, Law, Education.';

  @override
  String get place_yuksek_ihtisas_knownFor =>
      'Specialized in Health Sciences, Medicine and Nursing.';

  @override
  String get place_ankara_bilim_knownFor =>
      'Software Engineering, Design, Sustainable Development Goals.';

  @override
  String get place_health_sciences_uni_knownFor =>
      'Medical education, formerly GATA; Medicine, Dentistry, Nursing.';

  @override
  String get place_police_academy_knownFor =>
      'Police officer training, security strategies, crime analysis, intelligence.';

  @override
  String get place_national_defense_uni_knownFor =>
      'Officer training; Engineering, Social Sciences, Management.';

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
      'Huge central lake, evening light shows, large amusement park, and cultural center.';

  @override
  String get place_genclik_parki_new_entryFee => 'Free';

  @override
  String get place_genclik_parki_new_barbecue => 'Prohibited';

  @override
  String get place_genclik_parki_new_history =>
      'Founded in 1943 on a former swamp, it is a symbol of the Republican era designed to provide modern recreation for citizens.';

  @override
  String get place_kugulu_park_new_knownFor =>
      'Beautiful swans, historic trees, located in the heart of famous Tunalı Hilmi Street.';

  @override
  String get place_kugulu_park_new_entryFee => 'Free';

  @override
  String get place_kugulu_park_new_barbecue => 'Prohibited';

  @override
  String get place_kugulu_park_new_history =>
      'A natural and historical protected area. The park\'s famous swans were originally a gift from the city of Vienna.';

  @override
  String get place_segmenler_parki_new_knownFor =>
      'Open-air amphitheater, vast green spaces, pet-friendly spot in Çankaya.';

  @override
  String get place_segmenler_parki_new_entryFee => 'Free';

  @override
  String get place_segmenler_parki_new_barbecue => 'Prohibited';

  @override
  String get place_segmenler_parki_new_history =>
      'Opened in the early 1980s, it features a monument dedicated to the \'Seğmenler\' (traditional folk dancers).';

  @override
  String get place_eymir_golu_new_knownFor =>
      '11 km track ideal for cycling and running, bird watching, and complete tranquility.';

  @override
  String get place_eymir_golu_new_entryFee =>
      'Yayalar ve bisikletler için ücretsiz. Araçlar için kısıtlı.';

  @override
  String get place_eymir_golu_new_barbecue =>
      'Kesinlikle Prohibited (Ekosistemi korumak için)';

  @override
  String get place_eymir_golu_new_history =>
      'Located on METU land; afforested in the 1960s through the efforts of rector Kemal Kurdaş to turn the steppe into green space.';

  @override
  String get place_goksu_parki_new_knownFor =>
      'Mountain coaster (Dağ Kızağı), large artificial lake, and excellent barbecue facilities.';

  @override
  String get place_goksu_parki_new_entryFee => 'Free';

  @override
  String get place_goksu_parki_new_barbecue => 'Allowed (Özel alanlarda)';

  @override
  String get place_goksu_parki_new_history =>
      'Built on a former stone quarry site and opened in 2003, transforming the dry area into a huge recreational zone.';

  @override
  String get place_mogan_parki_new_knownFor =>
      'Bird watching, wooden walkways over water, lighthouse, and large family picnics.';

  @override
  String get place_mogan_parki_new_entryFee =>
      'Yayalar için ücretsiz; Araçlar ücretli (30-50 TL)';

  @override
  String get place_mogan_parki_new_barbecue =>
      'Allowed (Geniş piknik ve mangal alanları mevcut)';

  @override
  String get place_mogan_parki_new_history =>
      'Developed around a natural alluvial set lake in Gölbaşı to become a massive recreation center.';

  @override
  String get place_altinpark_new_knownFor =>
      'Feza Gürsey Science Center, exhibition halls, skating rinks, and boats on the lake.';

  @override
  String get place_altinpark_new_entryFee =>
      'Free (Otopark ve bilim merkezi gibi alanlar ücretli olabilir)';

  @override
  String get place_altinpark_new_barbecue => 'Prohibited';

  @override
  String get place_altinpark_new_history =>
      'One of the largest recreational areas in Ankara, established on 640,000 square meters.';

  @override
  String get place_harikalar_diyari_new_knownFor =>
      'Fairytale theme with giant statues (like Gulliver), go-kart tracks, and family activities.';

  @override
  String get place_harikalar_diyari_new_entryFee => 'Free';

  @override
  String get place_harikalar_diyari_new_barbecue =>
      'Allowed (Piknik alanları mevcut)';

  @override
  String get place_harikalar_diyari_new_history =>
      'One of the largest urban parks in Europe (1.3 million sqm), opened to serve the Sincan district.';

  @override
  String get place_ataturk_cocuklari_parki_new_knownFor =>
      'Digital Zoo, restoration of Ankara Stream, and massive green spaces (940,000 sqm).';

  @override
  String get place_ataturk_cocuklari_parki_new_entryFee => 'Free';

  @override
  String get place_ataturk_cocuklari_parki_new_barbecue =>
      'Prohibited (Dumansız piknik alanı)';

  @override
  String get place_ataturk_cocuklari_parki_new_history =>
      'Recently built on the historic Atatürk Forest Farm (AOÇ) land to restore the area as a public park.';

  @override
  String get place_botanik_parki_new_knownFor =>
      'English garden design, magnificent views of Atakule Tower, and glass plant conservatory.';

  @override
  String get place_botanik_parki_new_entryFee => 'Free';

  @override
  String get place_botanik_parki_new_barbecue => 'Prohibited';

  @override
  String get place_botanik_parki_new_history =>
      'Established in 1970 by Prof. Dr. Yüksel Öztan in the Çankaya valley.';

  @override
  String get place_dikmen_vadisi_new_knownFor =>
      'Longest continuous walking track in the city, suspension bridges, and Cherry Blossoms (Sakura) in spring.';

  @override
  String get place_dikmen_vadisi_new_entryFee => 'Free';

  @override
  String get place_dikmen_vadisi_new_barbecue =>
      'Prohibited (Yürüyüş ve spor odaklı)';

  @override
  String get place_dikmen_vadisi_new_history =>
      'A massive urban transformation project turning a valley full of shanties into a modern multi-stage park.';

  @override
  String get place_zafer_parki_30_agustos_knownFor =>
      'Wide cycling paths, running tracks, and car-free design.';

  @override
  String get place_zafer_parki_30_agustos_entryFee => 'Free';

  @override
  String get place_zafer_parki_30_agustos_barbecue =>
      'Prohibited (Dumansız ve doğal konsept)';

  @override
  String get place_zafer_parki_30_agustos_history =>
      'Opened next to the AŞTİ bus terminal to provide a modern \'breath\' of fresh air amidst the traffic.';

  @override
  String get place_yildonumu_50_new_knownFor =>
      'Panoramic \'Balcony of Ankara\' view, huge flag pole, and quiet elevated spaces.';

  @override
  String get place_yildonumu_50_new_entryFee => 'Free';

  @override
  String get place_yildonumu_50_new_barbecue => 'Prohibited';

  @override
  String get place_yildonumu_50_new_history =>
      'Built to celebrate the 50th anniversary of the Republic, located on the peaks of Cebeci.';

  @override
  String get place_altinkoy_new_knownFor =>
      'Restored wooden houses, working windmill, suspension bridge, and traditional craft workshops.';

  @override
  String get place_altinkoy_new_entryFee => 'Tam: 20 TL, Öğrenci: 10 TL';

  @override
  String get place_altinkoy_new_barbecue =>
      'Prohibited (Geleneksel lokantalar mevcut)';

  @override
  String get place_altinkoy_new_history =>
      'Established by Altındağ Municipality to revive and embody traditional Anatolian village life.';

  @override
  String get place_kurtulus_parki_new_knownFor =>
      'Ice skating rink, dense trees, and easy metro access.';

  @override
  String get place_kurtulus_parki_new_entryFee => 'Free';

  @override
  String get place_kurtulus_parki_new_barbecue => 'Prohibited';

  @override
  String get place_kurtulus_parki_new_history =>
      'One of the oldest central parks serving the Kızılay and Kolej districts.';

  @override
  String get place_soguksu_milli_parki_knownFor =>
      'Thermal springs, pine forests, rare birds, and camping facilities.';

  @override
  String get place_soguksu_milli_parki_entryFee => 'Araç başı yaklaşık 40 TL';

  @override
  String get place_soguksu_milli_parki_barbecue =>
      'Allowed (Kamp ve piknik alanları mevcut)';

  @override
  String get place_soguksu_milli_parki_history =>
      'A national park established in 1959 in the volcanic region of Kızılcahamam.';

  @override
  String get medicalBookingContent =>
      'Public & University: Use MHRS app or call 182. Private: Call hospital directly or use their website.';

  @override
  String get medicalLanguageContent =>
      'Most public hospitals speak Turkish only. Bring a translator or use Google Translate. Private hospitals often have international patient units.';

  @override
  String get medicalInsuranceContent =>
      'Public: Covered by SGK/GSS. Private: SGK covers part, you pay the difference. Travel insurance accepted in some private hospitals.';

  @override
  String get medicalBringContent =>
      'Passport/ID (Kimlik), SGK/Insurance documents, and any previous medical reports.';

  @override
  String get onboarding1Title => 'Welcome to Ankara';

  @override
  String get onboarding1Desc =>
      'Your comprehensive guide to the city - explore universities, hospitals, malls and more';

  @override
  String get onboarding2Title => 'Find Everything';

  @override
  String get onboarding2Desc =>
      'Easily search and explore all important places in Ankara';

  @override
  String get onboarding3Title => 'Stay Informed';

  @override
  String get onboarding3Desc =>
      'Get notifications about events and important news';

  @override
  String get onboardingLanguageTitle => 'Choose Language';

  @override
  String get onboardingLanguageDesc =>
      'Please choose the language you would like to use in the app';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Get Started';

  @override
  String get onboardingThemeTitle => 'Choose Theme';

  @override
  String get onboardingThemeDesc => 'Select the appearance that suits you best';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get themeSystem => 'System Default';
}
