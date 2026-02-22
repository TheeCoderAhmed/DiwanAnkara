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
  String get resetDate => 'Sıfırla';

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
  String get catActivities => 'الأنشطة والترفيه';

  @override
  String get catRestaurant => 'Restoranlar';

  @override
  String get catMarket => 'Marketler';

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

  @override
  String get socialConnect => 'Sosyal Bağlantılar';

  @override
  String get location => 'Konum';

  @override
  String get globalRank => 'Dünya Sıralaması';

  @override
  String get degrees => 'Dereceler';

  @override
  String get bachelorsAndMore => 'Lisans ve Üstü';

  @override
  String get openInGoogleMaps => 'Google Haritalar\'da Aç';

  @override
  String get navigateNow => 'Şimdi Git';

  @override
  String get noDescriptionAvailable => 'Açıklama mevcut değil.';

  @override
  String get established => 'Kuruluş Yılı';

  @override
  String get knownFor => 'Tanındığı Alanlar';

  @override
  String get hospitalType => 'Hastane Türü';

  @override
  String get medicalAdvice => 'Tıbbi ve Hastane Tavsiyeleri';

  @override
  String get bookingMethod => 'Randevu Yöntemi';

  @override
  String get languageTip => 'Dil İpuçları';

  @override
  String get insuranceInfo => 'Sigorta ve Maliyetler';

  @override
  String get whatToBring => 'Yanınızda Ne Getirmelisiniz?';

  @override
  String get howToBook => 'Nasıl Randevu Alınır?';

  @override
  String get hospitalAdvices => 'Hastane Tavsiyeleri';

  @override
  String get entryFee => 'Giriş Ücreti';

  @override
  String get barbecue => 'Mangal';

  @override
  String get history => 'Tarihçe';

  @override
  String get parkAdvices => 'Park Tavsiyeleri';

  @override
  String get seasonalRules => 'Mevsimsel Kurallar';

  @override
  String get fuelTypes => 'Yakıt Türleri';

  @override
  String get arrivalTime => 'Varış Saati';

  @override
  String get seasonalRulesContent =>
      'Mevsimsel Yasaklar: Genellikle Haziran/Temmuz\'dan 30 Eylül\'e kadar, Ankara Valiliği orman yangınlarını önlemek için mangal ve ateş yakmayı yasaklar.';

  @override
  String get fuelTypesContent =>
      'Yakıt Türleri: Genellikle kendi kömürünüzü getirmeniz beklenir. Izgara ünitelerinin dışında aşırı alev ve duman oluşturan odun veya büyük kütüklerin kullanılması yasaktır.';

  @override
  String get arrivalTimeContent =>
      'Varış Saati: Hafta sonları mangal yerleri çok erken dolar (genellikle 09:00 veya 10:00\'a kadar). Erken gitmezseniz yer bulamayabilirsiniz.';

  @override
  String get place_metu_uni_name =>
      'Middle East Technical University (METU/ODTÜ)';

  @override
  String get place_metu_uni_desc =>
      'Middle East Technical University (METU/ODTÜ)';

  @override
  String get place_hacettepe_uni_name => 'Hacettepe University';

  @override
  String get place_hacettepe_uni_desc => 'Hacettepe University';

  @override
  String get place_ankara_uni_name => 'Ankara University';

  @override
  String get place_ankara_uni_desc => 'Ankara University';

  @override
  String get place_gazi_uni_name => 'Gazi University';

  @override
  String get place_gazi_uni_desc => 'Gazi University';

  @override
  String get place_aybu_uni_name => 'Ankara Yıldırım Beyazıt University (AYBU)';

  @override
  String get place_aybu_uni_desc => 'Ankara Yıldırım Beyazıt University (AYBU)';

  @override
  String get place_haci_bayram_veli_name =>
      'Ankara Hacı Bayram Veli University (AHBVU)';

  @override
  String get place_haci_bayram_veli_desc =>
      'Ankara Hacı Bayram Veli University (AHBVU)';

  @override
  String get place_asbu_uni_name =>
      'Social Sciences University of Ankara (ASBU)';

  @override
  String get place_asbu_uni_desc =>
      'Social Sciences University of Ankara (ASBU)';

  @override
  String get place_mgu_uni_name =>
      'Ankara Music and Fine Arts University (MGU)';

  @override
  String get place_mgu_uni_desc =>
      'Ankara Music and Fine Arts University (MGU)';

  @override
  String get place_bilkent_uni_name => 'Bilkent University';

  @override
  String get place_bilkent_uni_desc => 'Bilkent University';

  @override
  String get place_cankaya_uni_name => 'Çankaya University';

  @override
  String get place_cankaya_uni_desc => 'Çankaya University';

  @override
  String get place_tobb_etu_name =>
      'TOBB University of Economics and Technology';

  @override
  String get place_tobb_etu_desc =>
      'TOBB University of Economics and Technology';

  @override
  String get place_atilim_uni_name => 'Atılım University';

  @override
  String get place_atilim_uni_desc => 'Atılım University';

  @override
  String get place_baskent_uni_name => 'Başkent University';

  @override
  String get place_baskent_uni_desc => 'Başkent University';

  @override
  String get place_tedu_uni_name => 'TED University';

  @override
  String get place_tedu_uni_desc => 'TED University';

  @override
  String get place_ostim_tech_name => 'OSTİM Technical University';

  @override
  String get place_ostim_tech_desc => 'OSTİM Technical University';

  @override
  String get place_lokman_hekim_name => 'Lokman Hekim University';

  @override
  String get place_lokman_hekim_desc => 'Lokman Hekim University';

  @override
  String get place_medipol_ankara_name => 'Ankara Medipol University';

  @override
  String get place_medipol_ankara_desc => 'Ankara Medipol University';

  @override
  String get place_thk_uni_name =>
      'University of Turkish Aeronautical Association (THK University)';

  @override
  String get place_thk_uni_desc =>
      'University of Turkish Aeronautical Association (THK University)';

  @override
  String get place_ufuk_uni_name => 'Ufuk University';

  @override
  String get place_ufuk_uni_desc => 'Ufuk University';

  @override
  String get place_yuksek_ihtisas_name => 'Yüksek İhtisas University';

  @override
  String get place_yuksek_ihtisas_desc => 'Yüksek İhtisas University';

  @override
  String get place_ankara_bilim_name =>
      'Ankara Science University (Ankara Bilim)';

  @override
  String get place_ankara_bilim_desc =>
      'Ankara Science University (Ankara Bilim)';

  @override
  String get place_health_sciences_uni_name =>
      'University of Health Sciences (SBÜ) – Gülhane Campus';

  @override
  String get place_health_sciences_uni_desc =>
      'University of Health Sciences (SBÜ) – Gülhane Campus';

  @override
  String get place_police_academy_name => 'Turkish National Police Academy';

  @override
  String get place_police_academy_desc => 'Turkish National Police Academy';

  @override
  String get place_national_defense_uni_name =>
      'National Defense University – Turkish Military Academy';

  @override
  String get place_national_defense_uni_desc =>
      'National Defense University – Turkish Military Academy';

  @override
  String get place_medical_advice_name => 'Medical Appointment Advice';

  @override
  String get place_medical_advice_desc => 'Medical Appointment Advice';

  @override
  String get place_bilkent_city_hosp_name => 'Ankara Bilkent City Hospital';

  @override
  String get place_bilkent_city_hosp_desc => 'Ankara Bilkent City Hospital';

  @override
  String get place_hacettepe_uni_hosp_name => 'Hacettepe University Hospitals';

  @override
  String get place_hacettepe_uni_hosp_desc => 'Hacettepe University Hospitals';

  @override
  String get place_ankara_uni_hosp_name =>
      'Ankara University Hospitals (İbni Sina & Cebeci)';

  @override
  String get place_ankara_uni_hosp_desc =>
      'Ankara University Hospitals (İbni Sina & Cebeci)';

  @override
  String get place_gazi_uni_hosp_name => 'Gazi University Hospital';

  @override
  String get place_gazi_uni_hosp_desc => 'Gazi University Hospital';

  @override
  String get place_gulhane_hosp_name =>
      'Gülhane Training and Research Hospital (GATA)';

  @override
  String get place_gulhane_hosp_desc =>
      'Gülhane Training and Research Hospital (GATA)';

  @override
  String get place_etlik_city_hosp_name => 'Etlik City Hospital';

  @override
  String get place_etlik_city_hosp_desc => 'Etlik City Hospital';

  @override
  String get place_acibadem_ankara_name => 'Acıbadem Ankara Hospital';

  @override
  String get place_acibadem_ankara_desc => 'Acıbadem Ankara Hospital';

  @override
  String get place_memorial_ankara_name => 'Memorial Ankara Hospital';

  @override
  String get place_memorial_ankara_desc => 'Memorial Ankara Hospital';

  @override
  String get place_medicana_ankara_name => 'Medicana International Ankara';

  @override
  String get place_medicana_ankara_desc => 'Medicana International Ankara';

  @override
  String get place_guven_hosp_name => 'Güven Hospital';

  @override
  String get place_guven_hosp_desc => 'Güven Hospital';

  @override
  String get place_bayindir_hosp_name => 'Bayındır Hospital (Söğütözü)';

  @override
  String get place_bayindir_hosp_desc => 'Bayındır Hospital (Söğütözü)';

  @override
  String get place_tobb_etu_hosp_name => 'TOBB ETÜ Hospital';

  @override
  String get place_tobb_etu_hosp_desc => 'TOBB ETÜ Hospital';

  @override
  String get place_lokman_hekim_ank_name =>
      'Lokman Hekim University Ankara Hospital';

  @override
  String get place_lokman_hekim_ank_desc =>
      'Lokman Hekim University Ankara Hospital';

  @override
  String get place_liv_hosp_ankara_name => 'Liv Hospital Ankara';

  @override
  String get place_liv_hosp_ankara_desc => 'Liv Hospital Ankara';

  @override
  String get place_koru_hosp_ankara_name => 'Koru Ankara Hospital';

  @override
  String get place_koru_hosp_ankara_desc => 'Koru Ankara Hospital';

  @override
  String get place_dunyagoz_ankara_name => 'Dünyagöz Ankara';

  @override
  String get place_dunyagoz_ankara_desc => 'Dünyagöz Ankara';

  @override
  String get place_medical_park_ank_name => 'Medical Park Ankara';

  @override
  String get place_medical_park_ank_desc => 'Medical Park Ankara';

  @override
  String get place_dental_estetik_center_name => 'Dental Estetik Center';

  @override
  String get place_dental_estetik_center_desc => 'Dental Estetik Center';

  @override
  String get place_elos_klinik_name => 'Elos Klinik';

  @override
  String get place_elos_klinik_desc => 'Elos Klinik';

  @override
  String get place_dr_emin_eren_clinic_name => 'Dr. Emin Eren Clinic';

  @override
  String get place_dr_emin_eren_clinic_desc => 'Dr. Emin Eren Clinic';

  @override
  String get place_genclik_parki_new_name => 'Gençlik Parkı';

  @override
  String get place_genclik_parki_new_desc => 'Gençlik Parkı';

  @override
  String get place_kugulu_park_new_name => 'Kuğulu Park';

  @override
  String get place_kugulu_park_new_desc => 'Kuğulu Park';

  @override
  String get place_segmenler_parki_new_name => 'Seğmenler Parkı';

  @override
  String get place_segmenler_parki_new_desc => 'Seğmenler Parkı';

  @override
  String get place_eymir_golu_new_name => 'Eymir Gölü';

  @override
  String get place_eymir_golu_new_desc => 'Eymir Gölü';

  @override
  String get place_goksu_parki_new_name => 'Göksu Parkı';

  @override
  String get place_goksu_parki_new_desc => 'Göksu Parkı';

  @override
  String get place_mogan_parki_new_name => 'Mogan Parkı (Lake Mogan)';

  @override
  String get place_mogan_parki_new_desc => 'Mogan Parkı (Lake Mogan)';

  @override
  String get place_altinpark_new_name => 'Altınpark';

  @override
  String get place_altinpark_new_desc => 'Altınpark';

  @override
  String get place_harikalar_diyari_new_name => 'Harikalar Diyarı (Wonderland)';

  @override
  String get place_harikalar_diyari_new_desc => 'Harikalar Diyarı (Wonderland)';

  @override
  String get place_ataturk_cocuklari_parki_new_name =>
      'Atatürk Çocukları ve Doğal Yaşam Parkı';

  @override
  String get place_ataturk_cocuklari_parki_new_desc =>
      'Atatürk Çocukları ve Doğal Yaşam Parkı';

  @override
  String get place_botanik_parki_new_name => 'Botanik Parkı';

  @override
  String get place_botanik_parki_new_desc => 'Botanik Parkı';

  @override
  String get place_dikmen_vadisi_new_name => 'Dikmen Vadisi';

  @override
  String get place_dikmen_vadisi_new_desc => 'Dikmen Vadisi';

  @override
  String get place_zafer_parki_30_agustos_name => '30 Ağustos Zafer Parkı';

  @override
  String get place_zafer_parki_30_agustos_desc => '30 Ağustos Zafer Parkı';

  @override
  String get place_yildonumu_50_new_name => '50. Yıl Parkı';

  @override
  String get place_yildonumu_50_new_desc => '50. Yıl Parkı';

  @override
  String get place_altinkoy_new_name => 'Altınköy Açık Hava Müzesي';

  @override
  String get place_altinkoy_new_desc => 'Altınköy Açık Hava Müzesي';

  @override
  String get place_kurtulus_parki_new_name => 'Kurtuluş Parkı';

  @override
  String get place_kurtulus_parki_new_desc => 'Kurtuluş Parkı';

  @override
  String get place_soguksu_milli_parki_name => 'Soğuksu Milli Parkı';

  @override
  String get place_soguksu_milli_parki_desc => 'Soğuksu Milli Parkı';

  @override
  String get place_ankara_transport_guide_2026_name =>
      'Ankara Ulaşım Rehberi 2026';

  @override
  String get place_ankara_transport_guide_2026_desc =>
      'Ankara Ulaşım Rehberi 2026';

  @override
  String get place_migration_management_ankara_name =>
      'Ankara İl Göç İdaresi (Migration Management)';

  @override
  String get place_migration_management_ankara_desc =>
      'Ankara İl Göç İdaresi (Migration Management)';

  @override
  String get place_yemen_embassy_ankara_name =>
      'Yemen Büyükelçiliği (Yemeni Embassy)';

  @override
  String get place_yemen_embassy_ankara_desc =>
      'Yemen Büyükelçiliği (Yemeni Embassy)';

  @override
  String get place_yok_ankara_name => 'Yükseköğretim Kurulu (YÖK)';

  @override
  String get place_yok_ankara_desc => 'Yükseköğretim Kurulu (YÖK)';

  @override
  String get place_nufus_mudurlugu_ankara_name =>
      'İl Nüfus ve Vatandaşlık Müdürlüğü';

  @override
  String get place_nufus_mudurlugu_ankara_desc =>
      'İl Nüfus ve Vatandaşlık Müdürlüğü';

  @override
  String get place_sgk_ankara_name => 'Sosyal Güvenlik Kurumu (SGK)';

  @override
  String get place_sgk_ankara_desc => 'Sosyal Güvenlik Kurumu (SGK)';

  @override
  String get place_tax_office_ankara_name => 'Vergi Dairesi (Tax Office)';

  @override
  String get place_tax_office_ankara_desc => 'Vergi Dairesi (Tax Office)';

  @override
  String get place_yemeni_student_gov_checklist_name =>
      'ملخص المعاملات الحكومية للطلاب اليمنيين 2026';

  @override
  String get place_yemeni_student_gov_checklist_desc =>
      'ملخص المعاملات الحكومية للطلاب اليمنيين 2026';

  @override
  String get place_ankamall_full_name => 'ANKAmall';

  @override
  String get place_ankamall_full_desc => 'ANKAmall';

  @override
  String get place_armada_full_name => 'Armada Shopping & Business';

  @override
  String get place_armada_full_desc => 'Armada Shopping & Business';

  @override
  String get place_panora_full_name => 'Panora Shopping Center';

  @override
  String get place_panora_full_desc => 'Panora Shopping Center';

  @override
  String get place_atakule_full_name => 'Atakule';

  @override
  String get place_atakule_full_desc => 'Atakule';

  @override
  String get place_bilkent_center_name => 'Bilkent Center';

  @override
  String get place_bilkent_center_desc => 'Bilkent Center';

  @override
  String get place_kentpark_full_name => 'Kentpark';

  @override
  String get place_kentpark_full_desc => 'Kentpark';

  @override
  String get place_cepa_full_name => 'Cepa';

  @override
  String get place_cepa_full_desc => 'Cepa';

  @override
  String get place_gordion_full_name => 'Gordion';

  @override
  String get place_gordion_full_desc => 'Gordion';

  @override
  String get place_arcadium_name => 'Arcadium';

  @override
  String get place_arcadium_desc => 'Arcadium';

  @override
  String get place_kizilay_avm_name => 'Kızılay AVM';

  @override
  String get place_kizilay_avm_desc => 'Kızılay AVM';

  @override
  String get place_acity_outlet_name => 'ACity Outlet';

  @override
  String get place_acity_outlet_desc => 'ACity Outlet';

  @override
  String get place_forum_ankara_name => 'Forum Ankara Outlet';

  @override
  String get place_forum_ankara_desc => 'Forum Ankara Outlet';

  @override
  String get place_antares_mall_name => 'Antares';

  @override
  String get place_antares_mall_desc => 'Antares';

  @override
  String get place_nata_vega_name => 'Nata Vega';

  @override
  String get place_nata_vega_desc => 'Nata Vega';

  @override
  String get place_anatolium_ankara_name => 'Anatolium';

  @override
  String get place_anatolium_ankara_desc => 'Anatolium';

  @override
  String get place_taurus_mall_name => 'Taurus';

  @override
  String get place_taurus_mall_desc => 'Taurus';

  @override
  String get place_podium_mall_name => 'Podium';

  @override
  String get place_podium_mall_desc => 'Podium';

  @override
  String get place_next_level_full_name => 'Next Level';

  @override
  String get place_next_level_full_desc => 'Next Level';

  @override
  String get place_tepe_prime_name => 'Tepe Prime';

  @override
  String get place_tepe_prime_desc => 'Tepe Prime';

  @override
  String get place_karum_mall_name => 'Karum';

  @override
  String get place_karum_mall_desc => 'Karum';

  @override
  String get place_atlantis_mall_name => 'Atlantis';

  @override
  String get place_atlantis_mall_desc => 'Atlantis';

  @override
  String get place_galleria_mall_name => 'Galleria';

  @override
  String get place_galleria_mall_desc => 'Galleria';

  @override
  String get place_optimum_outlet_name => 'Optimum Outlet';

  @override
  String get place_optimum_outlet_desc => 'Optimum Outlet';

  @override
  String get place_ftz_mall_name => 'FTZ';

  @override
  String get place_ftz_mall_desc => 'FTZ';

  @override
  String get place_365_mall_name => '365 Shopping Mall';

  @override
  String get place_365_mall_desc => '365 Shopping Mall';

  @override
  String get place_one_tower_mall_name => 'One Tower';

  @override
  String get place_one_tower_mall_desc => 'One Tower';

  @override
  String get place_anatolian_civil_museum_name =>
      'Anadolu Medeniyetleri Müzesi';

  @override
  String get place_anatolian_civil_museum_desc =>
      'Anadolu Medeniyetleri Müzesi';

  @override
  String get place_anitkabir_full_name => 'Anıtkabir';

  @override
  String get place_anitkabir_full_desc => 'Anıtkabir';

  @override
  String get place_ethnography_museum_name => 'Ankara Etnografya Müzesi';

  @override
  String get place_ethnography_museum_desc => 'Ankara Etnografya Müzesi';

  @override
  String get place_rahmi_koc_museum_name => 'Rahmi M. Koç Müzesi';

  @override
  String get place_rahmi_koc_museum_desc => 'Rahmi M. Koç Müzesi';

  @override
  String get place_ulucanlar_prison_name => 'Ulucanlar Cezaevi Müzesi';

  @override
  String get place_ulucanlar_prison_desc => 'Ulucanlar Cezaevi Müzesi';

  @override
  String get place_erimtan_museum_name => 'Erimtan Arkeoloji ve Sanat Müzesi';

  @override
  String get place_erimtan_museum_desc => 'Erimtan Arkeoloji ve Sanat Müzesi';

  @override
  String get place_cermodern_name => 'CerModern';

  @override
  String get place_cermodern_desc => 'CerModern';

  @override
  String get place_first_parliament_name => 'Kurtuluş Savaşı Müzesi (I. TBMM)';

  @override
  String get place_first_parliament_desc => 'Kurtuluş Savaşı Müzesi (I. TBMM)';

  @override
  String get place_republic_museum_name => 'Cumhuriyet Müzesi (II. TBMM)';

  @override
  String get place_republic_museum_desc => 'Cumhuriyet Müzesi (II. TBMM)';

  @override
  String get place_state_art_sculpture_name => 'Ankara Resim ve Heykel Müzesi';

  @override
  String get place_state_art_sculpture_desc => 'Ankara Resim ve Heykel Müzesi';

  @override
  String get place_gordion_museum_name => 'Gordion Müzesي';

  @override
  String get place_gordion_museum_desc => 'Gordion Müzesي';

  @override
  String get place_roman_baths_name => 'Roma Hamamı';

  @override
  String get place_roman_baths_desc => 'Roma Hamamı';

  @override
  String get place_altinkoy_museum_name => 'Altınköy Açık Hava Müzesi';

  @override
  String get place_altinkoy_museum_desc => 'Altınköy Açık Hava Müzesi';

  @override
  String get place_mta_natural_history_name =>
      'MTA Şehit Cuma Dağ Tabiat Tarihi Müzesi';

  @override
  String get place_mta_natural_history_desc =>
      'MTA Şehit Cuma Dağ Tabiat Tarihi Müzesi';

  @override
  String get place_ankara_vakif_museum_name => 'Ankara Vakıf Eserleri Müzesi';

  @override
  String get place_ankara_vakif_museum_desc => 'Ankara Vakıf Eserleri Müzesi';

  @override
  String get place_july_15_museum_name =>
      '15 Temmuz Şehitler ve Demokrasi Müzesi';

  @override
  String get place_july_15_museum_desc =>
      '15 Temmuz Şehitler ve Demokrasi Müzesi';

  @override
  String get place_haci_bayram_full_name => 'Hacı Bayram Veli Mosque & Tomb';

  @override
  String get place_haci_bayram_full_desc => 'Hacı Bayram Veli Mosque & Tomb';

  @override
  String get place_kocatepe_mosque_full_name => 'Kocatepe Mosque';

  @override
  String get place_kocatepe_mosque_full_desc => 'Kocatepe Mosque';

  @override
  String get place_augustus_temple_name => 'Augustus Tapınağı';

  @override
  String get place_augustus_temple_desc => 'Augustus Tapınağı';

  @override
  String get place_feza_gursey_center_name => 'Feza Gürsey Bilim Merkezi';

  @override
  String get place_feza_gursey_center_desc => 'Feza Gürsey Bilim Merkezi';

  @override
  String get place_metu_science_tech_name => 'ODTÜ Bilim ve Teknoloji Müzesi';

  @override
  String get place_metu_science_tech_desc => 'ODTÜ Bilim ve Teknoloji Müzesi';

  @override
  String get place_meiif_er_soy_lit_name => 'Mehmet Akif Ersoy Edebiyat Müzesi';

  @override
  String get place_meiif_er_soy_lit_desc => 'Mehmet Akif Ersoy Edebiyat Müzesi';

  @override
  String get place_mit_espionage_museum_name => 'MİT İstihbarat Müzesi';

  @override
  String get place_mit_espionage_museum_desc => 'MİT İstihbarat Müzesi';

  @override
  String get place_tcdd_steam_loco_name =>
      ' TCDD Açık Hava Buharlı Lokomotif Müzesi';

  @override
  String get place_tcdd_steam_loco_desc =>
      ' TCDD Açık Hava Buharlı Lokomotif Müzesi';

  @override
  String get place_ataturk_mansion_name => 'Atatürk Müze Köşkü';

  @override
  String get place_ataturk_mansion_desc => 'Atatürk Müze Köşkü';

  @override
  String get place_pembe_kosk_name => 'Pembe Köşk (İsmet İnönü House)';

  @override
  String get place_pembe_kosk_desc => 'Pembe Köşk (İsmet İnönü House)';

  @override
  String get place_isbank_museum_ank_name => 'Türkiye İş Bankası Müzesi';

  @override
  String get place_isbank_museum_ank_desc => 'Türkiye İş Bankası Müzesi';

  @override
  String get place_thk_aeronautical_name => 'Türk Hava Kurumu Müzesi';

  @override
  String get place_thk_aeronautical_desc => 'Türk Hava Kurumu Müzesi';

  @override
  String get place_stamp_museum_ank_name => 'PTT Pul Müzesي';

  @override
  String get place_stamp_museum_ank_desc => 'PTT Pul Müzesي';

  @override
  String get place_gokyay_chess_museum_name => 'Gökyay Vakfı Satranç Müzesi';

  @override
  String get place_gokyay_chess_museum_desc => 'Gökyay Vakfı Satranç Müzesi';

  @override
  String get place_trt_publishing_history_name =>
      'TRT Yayıncılık Tarihi Müzesي';

  @override
  String get place_trt_publishing_history_desc =>
      'TRT Yayıncılık Tarihi Müzesي';

  @override
  String get place_presidential_library_full_name =>
      'Cumhurbaşkanlığı Millet Kütüphanesi';

  @override
  String get place_presidential_library_full_desc =>
      'Cumhurbaşkanlığı Millet Kütüphanesi';

  @override
  String get place_national_library_full_name => 'Millî Kütüphane';

  @override
  String get place_national_library_full_desc => 'Millî Kütüphane';

  @override
  String get place_bilkent_library_full_name =>
      'Bilkent Üniversitesi Kütüphanesi';

  @override
  String get place_bilkent_library_full_desc =>
      'Bilkent Üniversitesi Kütüphanesi';

  @override
  String get place_ttk_library_full_name => 'Türk Tarih Kurumu Kütüphanesi';

  @override
  String get place_ttk_library_full_desc => 'Türk Tarih Kurumu Kütüphanesi';

  @override
  String get place_yok_thesis_center_name => 'YÖK Ulusal Tez Merkezi';

  @override
  String get place_yok_thesis_center_desc => 'YÖK Ulusal Tez Merkezi';

  @override
  String get place_tbmm_library_full_name => 'TBMM Kütüphanesi';

  @override
  String get place_tbmm_library_full_desc => 'TBMM Kütüphanesi';

  @override
  String get place_metu_uni_knownFor =>
      'Mühendislik ve mimarlıkta mükemmeliyet, öncü teknik üniversite, İngilizce eğitim.';

  @override
  String get place_hacettepe_uni_knownFor =>
      'Tıp ve sağlık bilimlerinde öncü, en yüksek ulusal araştırma etkisi.';

  @override
  String get place_ankara_uni_knownFor =>
      'Cumhuriyetin ilk üniversitesi, Hukuk, Siyasal Bilgiler (Mülkiye) ve Tıp alanlarında seçkin.';

  @override
  String get place_gazi_uni_knownFor =>
      'Öğretmen yetiştirme, mühendislik, teknoloji; sanayi ile güçlü entegrasyon.';

  @override
  String get place_aybu_uni_knownFor =>
      'İngilizce eğitim, Tıp ve Mühendislik, yüksek uluslararası öğrenci oranı.';

  @override
  String get place_haci_bayram_veli_knownFor =>
      'Sosyal bilimler, Sanat, Turizm (Gastronomi), Hukuk.';

  @override
  String get place_asbu_uni_knownFor =>
      'Sosyal Bilimlerde uzmanlaşmış, araştırma odaklı; Hukuk, Siyaset Bilimi, İslami İlimler.';

  @override
  String get place_mgu_uni_knownFor =>
      'Müzik ve Güzel Sanatlar alanında ihtisas üniversitesi.';

  @override
  String get place_bilkent_uni_knownFor =>
      'İlk vakıf üniversitesi, dünya standartlarında araştırma, Mühendislik ve Ekonomi.';

  @override
  String get place_cankaya_uni_knownFor =>
      'Yüksek araştırma etkisi, Mühendislik, Mimarlık, Hukuk.';

  @override
  String get place_tobb_etu_knownFor =>
      'Ortak eğitim modeli (zorunlu staj), iş dünyasıyla güçlü ilişkiler.';

  @override
  String get place_atilim_uni_knownFor =>
      'Sivil Havacılık, Mühendislik, Araştırma üretkenliği.';

  @override
  String get place_baskent_uni_knownFor =>
      'İlk özel sağlık üniversitesi, Tıp ve Diş Hekimliği, geniş hastane ağı.';

  @override
  String get place_tedu_uni_knownFor =>
      'Liberal sanatlar modeli, Mimarlık ve Eğitim, yumuşak becerilere odaklanma.';

  @override
  String get place_ostim_tech_knownFor =>
      'Sanayi üniversitesi modeli, uygulamalı eğitim ve girişimcilik.';

  @override
  String get place_lokman_hekim_knownFor =>
      'Sağlık alanında uzmanlaşmış; Tıp, Eczacılık, Spor Bilimleri.';

  @override
  String get place_medipol_ankara_knownFor =>
      'Sağlık bilimleri, modern tesisler, Tıp ve Diş Hekimliği.';

  @override
  String get place_thk_uni_knownFor =>
      'Havacılık ve Uzay alanında ihtisas, pilotluk eğitimi.';

  @override
  String get place_ufuk_uni_knownFor => 'Tıp, Hukuk, Eğitim.';

  @override
  String get place_yuksek_ihtisas_knownFor =>
      'Sağlık Bilimlerinde ihtisas, Tıp ve Hemşirelik.';

  @override
  String get place_ankara_bilim_knownFor =>
      'Yazılım Mühendisliği, Tasarım, Sürdürülebilir Kalkınma Hedefleri.';

  @override
  String get place_health_sciences_uni_knownFor =>
      'Tıp eğitimi, eski GATA; Tıp, Diş Hekimliği, Hemşirelik.';

  @override
  String get place_police_academy_knownFor =>
      'Polis memuru eğitimi, güvenlik stratejileri, suç analizi, istihbarat.';

  @override
  String get place_national_defense_uni_knownFor =>
      'Subay eğitimi; Mühendislik, Sosyal Bilimler, Yönetim.';

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
      'Devasa merkez gölü, akşam ışık gösterileri, büyük lunapark ve kültür merkezi.';

  @override
  String get place_genclik_parki_new_entryFee => 'Ücretsiz';

  @override
  String get place_genclik_parki_new_barbecue => 'Yasak';

  @override
  String get place_genclik_parki_new_history =>
      '1943 yılında eski bir bataklık üzerine kurulan park, Cumhuriyet döneminin modern dinlenme alanı sembolüdür.';

  @override
  String get place_kugulu_park_new_knownFor =>
      'Güzel kuğular, tarihi ağaçlar ve ünlü Tunalı Hilmi Caddesi\'nin kalbindeki konumu.';

  @override
  String get place_kugulu_park_new_entryFee => 'Ücretsiz';

  @override
  String get place_kugulu_park_new_barbecue => 'Yasak';

  @override
  String get place_kugulu_park_new_history =>
      'Doğal ve tarihi koruma alanı. Parkın ünlü kuğuları Viyana şehrinden hediye edilmiştir.';

  @override
  String get place_segmenler_parki_new_knownFor =>
      'Açık hava amfitiyatrosu, geniş yeşil alanlar ve Çankaya\'da evcil hayvan dostu mekan.';

  @override
  String get place_segmenler_parki_new_entryFee => 'Ücretsiz';

  @override
  String get place_segmenler_parki_new_barbecue => 'Yasak';

  @override
  String get place_segmenler_parki_new_history =>
      '1980lerin başında açılan parkta geleneksel Seğmen dansçılarına adanmış bir anıt bulunur.';

  @override
  String get place_eymir_golu_new_knownFor =>
      'Bisiklet ve koşu için ideal 11 km\'lik parkur, kuş gözlemi ve tam sükunet.';

  @override
  String get place_eymir_golu_new_entryFee =>
      'Yayalar ve bisikletler için ücretsiz. Araçlar için kısıtlı.';

  @override
  String get place_eymir_golu_new_barbecue =>
      'Kesinlikle Yasak (Ekosistemi korumak için)';

  @override
  String get place_eymir_golu_new_history =>
      'ODTÜ arazisinde yer alır; 1960larda rektör Kemal Kurdaşın çabalarıyla ağaçlandırılmıştır.';

  @override
  String get place_goksu_parki_new_knownFor =>
      'Dağ Kızağı, büyük yapay göl ve mükemmel mangal olanakları.';

  @override
  String get place_goksu_parki_new_entryFee => 'Ücretsiz';

  @override
  String get place_goksu_parki_new_barbecue => 'Serbest (Özel alanlarda)';

  @override
  String get place_goksu_parki_new_history =>
      'Eski bir taş ocağı üzerine kurulmuş ve 2003 yılında hizmete açılmıştır.';

  @override
  String get place_mogan_parki_new_knownFor =>
      'Kuş gözlemi, su üzeri ahşap yürüyüş yolları, deniz feneri ve geniş aile piknikleri.';

  @override
  String get place_mogan_parki_new_entryFee =>
      'Yayalar için ücretsiz; Araçlar ücretli (30-50 TL)';

  @override
  String get place_mogan_parki_new_barbecue =>
      'Serbest (Geniş piknik ve mangal alanları mevcut)';

  @override
  String get place_mogan_parki_new_history =>
      'Gölbaşı ilçesinde doğal bir alüvyal set gölü etrafında geliştirilmiştir.';

  @override
  String get place_altinpark_new_knownFor =>
      'Feza Gürsey Bilim Merkezi, fuar alanları, paten pistleri ve gölde kayıklar.';

  @override
  String get place_altinpark_new_entryFee =>
      'Ücretsiz (Otopark ve bilim merkezi gibi alanlar ücretli olabilir)';

  @override
  String get place_altinpark_new_barbecue => 'Yasak';

  @override
  String get place_altinpark_new_history =>
      '640 bin metrekare alan üzerine kurulu Ankara\'nın en büyük rekreasyon alanlarından biridir.';

  @override
  String get place_harikalar_diyari_new_knownFor =>
      'Masal teması ve dev heykeller (Gulliver gibi), go-kart pistleri ve aile aktiviteleri.';

  @override
  String get place_harikalar_diyari_new_entryFee => 'Ücretsiz';

  @override
  String get place_harikalar_diyari_new_barbecue =>
      'Serbest (Piknik alanları mevcut)';

  @override
  String get place_harikalar_diyari_new_history =>
      'Avrupa\'nın en büyük parklarından biri (1.3 milyon m2), Sincan bölgesinde hizmete açılmıştır.';

  @override
  String get place_ataturk_cocuklari_parki_new_knownFor =>
      'Dijital Hayvanat Bahçesi, Ankara Çayı restorasyonu ve devasa yeşil alanlar (940 bin m2).';

  @override
  String get place_ataturk_cocuklari_parki_new_entryFee => 'Ücretsiz';

  @override
  String get place_ataturk_cocuklari_parki_new_barbecue =>
      'Yasak (Dumansız piknik alanı)';

  @override
  String get place_ataturk_cocuklari_parki_new_history =>
      'Atatürk Orman Çiftliği arazisinde yeni kurulmuş, doğa ve yaşam odaklı devasa bir parktır.';

  @override
  String get place_botanik_parki_new_knownFor =>
      'İngiliz bahçesi tarzı tasarımı, muhteşem Atakule manzarası ve cam bitki serası.';

  @override
  String get place_botanik_parki_new_entryFee => 'Ücretsiz';

  @override
  String get place_botanik_parki_new_barbecue => 'Yasak';

  @override
  String get place_botanik_parki_new_history =>
      '1970 yılında Prof. Dr. Yüksel Öztan tarafından Çankaya vadisinde kurulmuştur.';

  @override
  String get place_dikmen_vadisi_new_knownFor =>
      'Şehirdeki en uzun kesintisiz yürüyüş parkuru, asma köprüler ve baharda Kiraz Çiçekleri (Sakura).';

  @override
  String get place_dikmen_vadisi_new_entryFee => 'Ücretsiz';

  @override
  String get place_dikmen_vadisi_new_barbecue =>
      'Yasak (Yürüyüş ve spor odaklı)';

  @override
  String get place_dikmen_vadisi_new_history =>
      'Gecekondu bölgesinden kentsel dönüşümle modern bir yaşam ve park alanına dönüştürülmüştür.';

  @override
  String get place_zafer_parki_30_agustos_knownFor =>
      'Geniş bisiklet yolları, koşu parkurları ve araçsız tasarım.';

  @override
  String get place_zafer_parki_30_agustos_entryFee => 'Ücretsiz';

  @override
  String get place_zafer_parki_30_agustos_barbecue =>
      'Yasak (Dumansız ve doğal konsept)';

  @override
  String get place_zafer_parki_30_agustos_history =>
      'AŞTİ yanındaki konumuyla şehir içinde modern bir nefes alanı olarak açılmıştır.';

  @override
  String get place_yildonumu_50_new_knownFor =>
      'Panoramik \'Ankara Balkonu\' manzarası, dev bayrak direği ve sessiz yüksek alanlar.';

  @override
  String get place_yildonumu_50_new_entryFee => 'Ücretsiz';

  @override
  String get place_yildonumu_50_new_barbecue => 'Yasak';

  @override
  String get place_yildonumu_50_new_history =>
      'Cumhuriyetin 50. yılı anısına Cebeci sırtlarında inşa edilmiştir.';

  @override
  String get place_altinkoy_new_knownFor =>
      'Restore edilmiş ahşap evler, çalışan yel değirmeni, asma köprü ve geleneksel zanaat atölyeleri.';

  @override
  String get place_altinkoy_new_entryFee => 'Tam: 20 TL, Öğrenci: 10 TL';

  @override
  String get place_altinkoy_new_barbecue =>
      'Yasak (Geleneksel lokantalar mevcut)';

  @override
  String get place_altinkoy_new_history =>
      'Anadolu köy yaşamını canlandırmak için Altındağ Belediyesi tarafından kurulmuştur.';

  @override
  String get place_kurtulus_parki_new_knownFor =>
      'Buz pateni pisti, sık ağaçlar ve metro ile kolay ulaşım.';

  @override
  String get place_kurtulus_parki_new_entryFee => 'Ücretsiz';

  @override
  String get place_kurtulus_parki_new_barbecue => 'Yasak';

  @override
  String get place_kurtulus_parki_new_history =>
      'Kızılay ve Kolej bölgelerine hizmet veren Ankara\'nın en eski parklarından biridir.';

  @override
  String get place_soguksu_milli_parki_knownFor =>
      'Termal kaynaklar, çam ormanları, nadir kuşlar ve kamp olanakları.';

  @override
  String get place_soguksu_milli_parki_entryFee => 'Araç başı yaklaşık 40 TL';

  @override
  String get place_soguksu_milli_parki_barbecue =>
      'Serbest (Kamp ve piknik alanları mevcut)';

  @override
  String get place_soguksu_milli_parki_history =>
      '1959 yılında Kızılcahamam\'da volkanik bir bölgede kurulmuş milli parktır.';

  @override
  String get medicalBookingContent =>
      'Kamu & Üniversite: MHRS uygulamasını kullanın veya 182\'yi arayın. Özel: Hastaneyi doğrudan arayın veya web sitesini kullanın.';

  @override
  String get medicalLanguageContent =>
      'Çoğu kamu hastanesinde sadece Türkçe konuşulur. Bir tercüman getirin veya Google Çeviri kullanın. Özel hastanelerde genellikle uluslararası hasta birimleri bulunur.';

  @override
  String get medicalInsuranceContent =>
      'Kamu: SGK/GSS kapsamındadır. Özel: SGK bir kısmını karşılar, farkı siz ödersiniz. Seyahat sigortası bazı özel hastanelerde kabul edilir.';

  @override
  String get medicalBringContent =>
      'Pasaport/Kimlik, SGK/Sigorta belgeleri ve varsa önceki tıbbi raporlar.';

  @override
  String get onboarding1Title => 'Ankara\'ya Hoş Geldiniz';

  @override
  String get onboarding1Desc =>
      'Şehir için kapsamlı rehberiniz - üniversiteleri, hastaneleri, alışveriş merkezlerini ve daha fazlasını keşfedin';

  @override
  String get onboarding2Title => 'Her Şeyi Bulun';

  @override
  String get onboarding2Desc =>
      'Ankara\'daki tüm önemli yerleri kolayca arayın ve keşfedin';

  @override
  String get onboarding3Title => 'Haberdar Kalın';

  @override
  String get onboarding3Desc =>
      'Etkinlikler ve önemli haberler hakkında bildirimler alın';

  @override
  String get onboardingLanguageTitle => 'Dil Seçin';

  @override
  String get onboardingLanguageDesc =>
      'Lütfen uygulamada kullanmak istediğiniz dili seçin';

  @override
  String get onboardingSkip => 'Geç';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingStart => 'Başlat';

  @override
  String get onboardingThemeTitle => 'Tema Seçin';

  @override
  String get onboardingThemeDesc => 'Size en uygun görünümü seçin';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get themeSystem => 'Sistem Varsayılanı';

  @override
  String get version => 'Sürüm';

  @override
  String get goodMorning => 'Günaydın';

  @override
  String get goodAfternoon => 'İyi günler';

  @override
  String get goodEvening => 'İyi akşamlar';

  @override
  String get goodNight => 'İyi geceler';

  @override
  String get general => 'Genel';

  @override
  String get community => 'Topluluk';

  @override
  String get support => 'Destek';

  @override
  String get eventsTab => 'Etkinlikler';
}
