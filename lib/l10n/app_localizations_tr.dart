// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Yemenli Öğrenci Topluluğu - Ankara';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get more => 'Daha Fazla';

  @override
  String get language => 'Dil';

  @override
  String get theme => 'Görونüm';

  @override
  String get dark => 'Koyu';

  @override
  String get light => 'Açık';

  @override
  String get system => 'Varsayılan';

  @override
  String get hello => 'Hoş Geldiniz';

  @override
  String get searchHint => 'Duyuru, etkinlik ara...';

  @override
  String get searchResults => 'Arama Sonuçları';

  @override
  String get noResults => 'Sonuç bulunamadı';

  @override
  String get announcements => 'Duyurular';

  @override
  String get viewAll => 'Hepsini Gör';

  @override
  String get ikamet => 'İkamet';

  @override
  String get places => 'Mekanlar';

  @override
  String get projects => 'Projeler';

  @override
  String get announcement => 'Duyuru';

  @override
  String get announcementNotFound => 'Duyuru bulunamadı';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get error => 'Hata';

  @override
  String get openLink => 'Bağlantıyı Aç';

  @override
  String get addComment => 'Yorum Ekle';

  @override
  String get shareOpinion =>
      'Bu haberle ilgili görüşünüzü veya sorunuzu paylaşın';

  @override
  String get name => 'İsim';

  @override
  String get enterName => 'İsminizi girin';

  @override
  String get comment => 'Yorum';

  @override
  String get writeComment => 'Yorumunuzu buraya yazın...';

  @override
  String get sendComment => 'Yorum Gönder';

  @override
  String get commentReviewNote => 'Yorumunuz yönetim tarafından incelenecektir';

  @override
  String waitMinutes(int minutes) {
    return 'Başka bir yorum göndermeden önce lütfen $minutes dakika bekleyin';
  }

  @override
  String get commentSuccess =>
      'Yorumunuz başarıyla gönderildi! Yakında incelenecektir.';

  @override
  String get commentError =>
      'Yorum gönderilirken bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get nameRequired => 'Lütfen isim giriniz';

  @override
  String get nameTooShort => 'İsim en az 2 karakter olmalıdır';

  @override
  String get nameTooLong => 'İsim 50 karakteri geçmemelidir';

  @override
  String get commentRequired => 'Lütfen yorum giriniz';

  @override
  String get commentTooShort => 'Yorum en az 10 karakter olmalıdır';

  @override
  String linkError(Object error) {
    return 'Bağlantı açılırken hata: $error';
  }

  @override
  String get eventsCalendar => 'Etkinlik Takvimi';

  @override
  String get upcomingEvents => 'Gelecek Etkinlikler';

  @override
  String get previousEvents => 'Geçmiş Etkinlikler';

  @override
  String get noEventsToday => 'Bugün etkinlik yok';

  @override
  String get noUpcomingEvents => 'Gelecek etkinlik bulunmamaktadır';

  @override
  String get registerNow => 'Şimdi Kaydol';

  @override
  String get linkLaunchError => 'Kayıt bağlantısı açılamadı';

  @override
  String eventsOf(Object date) {
    return '$date tarihindeki etkinlikler';
  }

  @override
  String get ikametTracker => 'İkamet Takibi';

  @override
  String get ikametNoDateSet => 'İkamet bitiş tarihi ayarlanmadı';

  @override
  String get ikametSetDate => 'Bitiş tarihini ayarla';

  @override
  String get ikametExpiresIn => 'Bitiş süresi:';

  @override
  String get days => 'Gün';

  @override
  String get ikametSafe => 'Güvenli';

  @override
  String get ikametWarning => 'Uyarı';

  @override
  String get ikametUrgent => 'Acil!';

  @override
  String get studentResources => 'Öğrenciler için faydalı kaynaklar';

  @override
  String get noUniversitiesInSection => 'Bu bölümde üniversite bulunamadı';

  @override
  String get university => 'Üniversite';

  @override
  String get universityIntro => 'Üniversite Hakkında';

  @override
  String get bachelorPrograms => 'Lisans Programları';

  @override
  String get associatePrograms => 'Önlisans Programları';

  @override
  String get universityInTurkey => 'Türkiye\'de bir üniversite';

  @override
  String get noItemsInSection => 'Bu bölümde öğe bulunamadı';

  @override
  String get projectDetails => 'Proje Detayları';

  @override
  String get callNow => 'Şimdi Ara';

  @override
  String get joinWhatsapp => 'WhatsApp grubuna katıl';

  @override
  String get aboutProject => 'Proje Hakkında';

  @override
  String get reviews => 'Değerlendirmeler';

  @override
  String get shareExperience => 'Deneyiminizi başkalarıyla paylaşın';

  @override
  String get noReviewsYet => 'Henüz değerlendirme yok';

  @override
  String get beFirstToReview => 'Deneyiminizi ilk paylaşan siz olun!';

  @override
  String get addReview => 'Değerlendirme Ekle';

  @override
  String get rating => 'Değerlendirme';

  @override
  String get writeReview => 'Değerlendirmenizi buraya yazın...';

  @override
  String get cancel => 'İptal';

  @override
  String get sendReview => 'Değerlendirme Gönder';

  @override
  String get reviewSuccess =>
      'Değerlendirmeniz başarıyla gönderildi! İncelemeden sonra yayınlanacaktır.';

  @override
  String get reviewError => 'Bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get reviewsLoadError => 'Hatalar yüklenirken hata oluştu';

  @override
  String get notifications => 'Bildirimler';

  @override
  String get clearAll => 'Hepsini Temizle';

  @override
  String get noNotifications => 'Henüz bildirim yok';

  @override
  String get clearAllTitle => 'Tüm bildirimler temizlensin mi?';

  @override
  String get clearAllMessage =>
      'Tüm bildirim geçmişini silmek istediğinizden emin misiniz?';

  @override
  String get delete => 'Sil';

  @override
  String get savedPlaces => 'Kaydedilen Mekanlar';

  @override
  String get savedPlacesSubtitle => 'Favori mekanlarınızı görün';

  @override
  String get aboutUs => 'Hakkımızda';

  @override
  String get aboutUsSubtitle => 'Topluluk rehberi ve bilgileri';

  @override
  String get supportUs => 'Bizi Destekleyin';

  @override
  String get supportUsSubtitle => 'Topluluğu desteklemek için bağış yapın';

  @override
  String get appearance => 'Görünüm';

  @override
  String get committees => 'Kurullar';

  @override
  String get committeesSubtitle => 'Yıllar boyunca önceki kurullar';

  @override
  String get oversight => 'Denetim';

  @override
  String get oversightSubtitle => 'Denetim kurulu üyeleri';

  @override
  String get selectLanguage => 'Dil Seçin';

  @override
  String get arabic => 'Arapça';

  @override
  String get english => 'İngilizce';

  @override
  String get turkish => 'Türkçe';

  @override
  String get themeFollowSystem => 'Sistem ayarlarını takip et';

  @override
  String get themeAlwaysLight => 'Her zaman açık tema';

  @override
  String get themeAlwaysDark => 'Her zaman koyu tema';

  @override
  String get selectTheme => 'Tema Seçin';

  @override
  String get supportDesc =>
      'Ankara\'daki Yemen topluluğunu bağış yaparak destekleyebilirsiniz:';

  @override
  String get copy => 'Kopyala';

  @override
  String get copiedIban => 'IBAN panoya kopyalandı';

  @override
  String get close => 'Kapat';

  @override
  String get loadingData =>
      'Veriler yükleniyor, lütfen daha sonra tekrar deneyin';

  @override
  String get exchangeRateError =>
      'Kurlar güncellenemedi. Yedek kurlar kullanılıyor.';

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get popularPlaces => 'Popüler Mekanlar';

  @override
  String get partners => 'Ortaklarımız';

  @override
  String get noPartners => 'Henüz ortak bulunmamaktadır';

  @override
  String get catUniversity => 'Üniversiteler';

  @override
  String get catHospital => 'Hastaneler';

  @override
  String get catMall => 'AVM\'ler';

  @override
  String get catHistoric => 'Tarihi Mekanlar';

  @override
  String get catLibrary => 'Kütüphaneler';

  @override
  String get catTransport => 'Ulaşım';

  @override
  String get catGovOffice => 'Resmi Daireler';

  @override
  String get catParks => 'Parklar';

  @override
  String get catHousing => 'Konaklama Rehberi';

  @override
  String get catPartners => 'Ortaklar';

  @override
  String get catAbout => 'Hakkımızda';

  @override
  String get catProject => 'Projelerimiz';

  @override
  String get noAnnouncementFound => 'Duyuru bulunamadı';

  @override
  String get shareYourOpinion =>
      'Bu haberle ilgili düşüncelerinizi veya sorularınızı paylaşın';

  @override
  String get pleaseEnterName => 'Lütfen isminizi girin';

  @override
  String get writeCommentHere => 'Yorumunuzu buraya yazın...';

  @override
  String get pleaseEnterComment => 'Lütfen yorumunuzu girin';

  @override
  String get errorOpeningLink => 'Bağlantı açılırken hata oluştu';

  @override
  String get eventCalendar => 'Etkinlik Takvimi';

  @override
  String eventsOnDate(String date) {
    return '$date Etkinlikleri';
  }

  @override
  String get showAll => 'Tümünü Göster';

  @override
  String get noEventsOnDay => 'Bu günde etkinlik bulunmamaktadır';

  @override
  String get errorOpeningRegistrationLink => 'Kayıt bağlantısı açılamadı';

  @override
  String get noUniversitiesFound => 'Bu bölümde üniversite bulunamadı';

  @override
  String get universityIntroduction => 'Üniversite Tanıtımı';

  @override
  String get placeNotFound => 'Mekan bulunamadı';

  @override
  String get place => 'Mekan';

  @override
  String get navigate => 'Yol Tarifi';

  @override
  String get attachedDocuments => 'Ekli Belgeler';

  @override
  String get pdfFile => 'PDF Dosyası';

  @override
  String get introductoryDocument => 'Tanıtım Belgesi';

  @override
  String cannotOpenFile(String error) {
    return 'Dosya açılamıyor: $error';
  }

  @override
  String get showLess => 'Daha Az Göster';

  @override
  String get readMore => 'Devamını Oku';

  @override
  String get noSavedPlaces => 'Kaydedilen mekan bulunamadı';

  @override
  String errorLoadingData(String error) {
    return 'Veri yüklenirken hata oluştu: $error';
  }

  @override
  String get joinWhatsappGroup => 'WhatsApp Grubuna Katıl';

  @override
  String get clearAllNotificationsTitle => 'Tüm bildirimler silinsin mi?';

  @override
  String get clearAllNotificationsMessage =>
      'Tüm bildirim geçmişini silmek istediğinizden emin misiniz?';

  @override
  String get clear => 'Temizle';

  @override
  String get pastOversightCommittees => 'Geçmiş Denetleme Kurulları';

  @override
  String get noDataAvailable => 'Veri bulunamadı';

  @override
  String get selectYear => 'Yıl Seçin';

  @override
  String get noMembersForYear => 'Bu yıl için üye bulunamadı';

  @override
  String get pastContributors => 'Geçmiş Yönetim Kurulları';

  @override
  String get noContributorsForYear => 'Bu yıl için katkıda bulunan bulunamadı';

  @override
  String get directory => 'Rehber';

  @override
  String get sections => 'Bölümler';

  @override
  String get noResidencyGuide => 'İkamet rehberi şu an mevcut değil';

  @override
  String get fileLinkNotAvailable => 'Dosya bağlantısı mevcut değil';

  @override
  String get noHousingGuide => 'Konaklama rehberi şu an mevcut değil';

  @override
  String get pdfLinkNotAvailable => 'PDF bağlantısı mevcut değil';

  @override
  String get residencyGuide => 'İkamet Rehberi (PDF)';

  @override
  String get housingGuide => 'Konaklama Rehberi (PDF)';

  @override
  String get currencyConverter => 'Döviz Çevirici';

  @override
  String get refreshRates => 'Kurları Yenile';

  @override
  String get from => 'Kimden';

  @override
  String get to => 'Kime';

  @override
  String get contactAndInquiry => 'İletişim ve Bilgi';

  @override
  String get fundManager => 'Fon Yöneticisi';

  @override
  String get eventDetails => 'Etkinlik Detayları';

  @override
  String get pastEvents => 'Geçmiş Etkinlikler';

  @override
  String get noPastEvents => 'Geçmiş etkinlik bulunamadı';

  @override
  String get eventCategorySports => 'Spor';

  @override
  String get eventCategoryCulture => 'Kültür ve Sanat';

  @override
  String get eventCategoryEducational => 'Eğitim';

  @override
  String get eventCategorySocial => 'Sosyal';

  @override
  String get eventCategoryReligious => 'Dini';

  @override
  String get eventCategoryOther => 'Diğer';

  @override
  String get downloadingLanguageModel => 'Dil paketi indiriliyor...';

  @override
  String get languageModelDownloaded => 'Dil paketi başarıyla indirildi.';

  @override
  String get reportSafetyConcern => 'Güvenlik Sorunu Bildir';

  @override
  String get reportSafetyConcernSubtitle =>
      'Herhangi bir güvenlik sorunu veya ihlalini bildirmek için bize ulaşın';
}
