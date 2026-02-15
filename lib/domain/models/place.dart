import 'categories.dart';

class PlaceDocument {
  const PlaceDocument({
    required this.title,
    required this.filePath,
  });

  final String title;
  final String filePath; // asset path

  factory PlaceDocument.fromJson(Map<String, dynamic> json) {
    String s(String key) => (json[key] as String?) ?? '';
    return PlaceDocument(
      title: s('title'),
      filePath: s('file_path'),
    );
  }
}

class PlaceSection {
  final String title;
  final String content;

  const PlaceSection({required this.title, required this.content});

  factory PlaceSection.fromJson(Map<String, dynamic> json) {
    return PlaceSection(
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'title': title, 'content': content};
}

class Place {
  const Place({
    required this.id,
    required this.category,
    required this.nameTr,
    required this.descriptionAr,
    required this.lat,
    required this.lng,
    required this.imageAsset,
    this.address,
    required this.isPopular,
    required this.documents,
    this.pdfUrl,
    this.docUrl,
    this.mapsLink,
    this.order,
    this.establishment,
    this.knownFor,
    this.type,
    this.entryFeeAr,
    this.entryFeeTr,
    this.barbecueAr,
    this.barbecueTr,
    this.historyAr,
    this.historyTr,
    this.sections,
  });

  final String id;
  final PlaceCategory category;
  final String nameTr;
  final String descriptionAr;
  final double lat;
  final double lng;
  final String imageAsset; // Can be asset path or image_url/logo_url from Firestore
  final String? address;
  final bool isPopular;
  final List<PlaceDocument> documents; // for university (DOCX)
  final String? pdfUrl; // For PDF-only items (guides, documents)
  final String? docUrl; // For Word documents (document_url)
  final String? mapsLink; // Direct maps link from Firestore
  final int? order; // For custom ordering
  final int? establishment;
  final String? knownFor;
  final String? type;
  final String? entryFeeAr;
  final String? entryFeeTr;
  final String? barbecueAr;
  final String? barbecueTr;
  final String? historyAr;
  final String? historyTr;
  final List<PlaceSection>? sections;

  factory Place.fromJson(Map<String, dynamic> json) {
    // Helper to get string value, checking multiple key variants
    String s(String key) => (json[key] as String?) ?? '';
    double d(String key) => ((json[key] as num?) ?? 0).toDouble();
    
    final docs = (json['documents'] as List<dynamic>?)
            ?.map((e) => PlaceDocument.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList() ??
        const <PlaceDocument>[];

    final sections = (json['sections'] as List<dynamic>?)
            ?.map((e) => PlaceSection.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList();
    
    final rawCategory = s('category');
    
    // IMAGES: Check ALL possible keys (snake_case, camelCase, variants)
    String image = s('image_url');
    if (image.isEmpty) image = s('imageUrl');     // camelCase variant
    if (image.isEmpty) image = s('logo_url');     // University logos
    if (image.isEmpty) image = s('logoUrl');      // camelCase variant
    if (image.isEmpty) image = s('image_asset');  // Legacy asset path
    
    // TITLE: Check multiple key variants
    String title = s('display_name');
    if (title.isEmpty) title = s('name');
    if (title.isEmpty) title = s('name_tr');
    
    // PDF: Check multiple key variants
    String pdfUrl = s('pdf_url');
    if (pdfUrl.isEmpty) pdfUrl = s('pdfUrl');     // camelCase variant
    if (pdfUrl.isEmpty) pdfUrl = s('file_url');   // Alternative key
    if (pdfUrl.isEmpty) pdfUrl = s('fileUrl');    // camelCase variant
    
    // DOC: Check multiple key variants
    String docUrl = s('document_url');
    if (docUrl.isEmpty) docUrl = s('documentUrl'); // camelCase variant
    
    // MAPS: Check multiple key variants
    String mapsLink = s('maps_link');
    if (mapsLink.isEmpty) mapsLink = s('mapsLink'); // camelCase variant
    
    return Place(
      id: s('id'),
      category: rawCategory.isEmpty
          ? PlaceCategory.other
          : PlaceCategoryX.fromJsonValue(rawCategory),
      nameTr: title,
      descriptionAr: s('description_ar').isEmpty ? s('description') : s('description_ar'),
      lat: d('lat'),
      lng: d('lng'),
      address: s('address'),
      imageAsset: image,
      isPopular: (json['is_popular'] as bool?) ?? false,
      documents: docs,
      pdfUrl: pdfUrl.isEmpty ? null : pdfUrl,
      docUrl: docUrl.isEmpty ? null : docUrl, // Backwards compatibility for some DB entries
      mapsLink: mapsLink.isEmpty ? null : mapsLink,
      order: (json['order'] as num?)?.toInt(),
      establishment: (json['establishment'] as num?)?.toInt() ?? (json['year_est'] as num?)?.toInt(),
      knownFor: s('known_for').isEmpty ? s('knownFor') : s('known_for'),
      type: s('type'),
      entryFeeAr: s('entry_fee_ar').isEmpty ? s('entryFeeAr') : s('entry_fee_ar'),
      entryFeeTr: s('entry_fee_tr').isEmpty ? s('entryFeeTr') : s('entry_fee_tr'),
      barbecueAr: s('barbecue_ar').isEmpty ? s('barbecueAr') : s('barbecue_ar'),
      barbecueTr: s('barbecue_tr').isEmpty ? s('barbecueTr') : s('barbecue_tr'),
      historyAr: s('history_ar').isEmpty ? s('historyAr') : s('history_ar'),
      historyTr: s('history_tr').isEmpty ? s('historyTr') : s('history_tr'),
      sections: sections,
    );
  }

  Place copyWith({
    String? id,
    PlaceCategory? category,
    String? nameTr,
    String? descriptionAr,
    double? lat,
    double? lng,
    String? imageAsset,
    String? address,
    bool? isPopular,
    List<PlaceDocument>? documents,
    String? pdfUrl,
    String? docUrl,
    String? mapsLink,
    int? order,
    int? establishment,
    String? knownFor,
    String? type,
    String? entryFeeAr,
    String? entryFeeTr,
    String? barbecueAr,
    String? barbecueTr,
    String? historyAr,
    String? historyTr,
    List<PlaceSection>? sections,
  }) {
    return Place(
      id: id ?? this.id,
      category: category ?? this.category,
      nameTr: nameTr ?? this.nameTr,
      descriptionAr: descriptionAr ?? this.descriptionAr,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      imageAsset: imageAsset ?? this.imageAsset,
      address: address ?? this.address,
      isPopular: isPopular ?? this.isPopular,
      documents: documents ?? this.documents,
      pdfUrl: pdfUrl ?? this.pdfUrl,
      docUrl: docUrl ?? this.docUrl,
      mapsLink: mapsLink ?? this.mapsLink,
      order: order ?? this.order,
      establishment: establishment ?? this.establishment,
      knownFor: knownFor ?? this.knownFor,
      type: type ?? this.type,
      entryFeeAr: entryFeeAr ?? this.entryFeeAr,
      entryFeeTr: entryFeeTr ?? this.entryFeeTr,
      barbecueAr: barbecueAr ?? this.barbecueAr,
      barbecueTr: barbecueTr ?? this.barbecueTr,
      historyAr: historyAr ?? this.historyAr,
      historyTr: historyTr ?? this.historyTr,
      sections: sections ?? this.sections,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category.jsonValue,
      'name_tr': nameTr,
      'description_ar': descriptionAr,
      'lat': lat,
      'lng': lng,
      'address': address,
      'image_url': imageAsset,
      'is_popular': isPopular,
      'documents': documents.map((e) => e.toJson()).toList(),
      'pdf_url': pdfUrl,
      'document_url': docUrl,
      'maps_link': mapsLink,
      'order': order,
      'establishment': establishment,
      'known_for': knownFor,
      'type': type,
      'entry_fee_ar': entryFeeAr,
      'entry_fee_tr': entryFeeTr,
      'barbecue_ar': barbecueAr,
      'barbecue_tr': barbecueTr,
      'history_ar': historyAr,
      'history_tr': historyTr,
      'sections': sections?.map((e) => e.toJson()).toList(),
    };
  }
}

extension on PlaceDocument {
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'file_path': filePath,
    };
  }
}



