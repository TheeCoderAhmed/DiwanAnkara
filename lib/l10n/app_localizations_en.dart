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
}
