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

class Place {
  const Place({
    required this.id,
    required this.category,
    required this.nameTr,
    required this.descriptionAr,
    required this.lat,
    required this.lng,
    required this.imageAsset,
    required this.isPopular,
    required this.documents,
    this.pdfUrl,
    this.docUrl,
    this.mapsLink,
    this.order,
  });

  final String id;
  final PlaceCategory category;
  final String nameTr;
  final String descriptionAr;
  final double lat;
  final double lng;
  final String imageAsset; // Can be asset path or image_url/logo_url from Firestore
  final bool isPopular;
  final List<PlaceDocument> documents; // for university (DOCX)
  final String? pdfUrl; // For PDF-only items (guides, documents)
  final String? docUrl; // For Word documents (document_url)
  final String? mapsLink; // Direct maps link from Firestore
  final int? order; // For custom ordering

  factory Place.fromJson(Map<String, dynamic> json) {
    // Helper to get string value, checking multiple key variants
    String s(String key) => (json[key] as String?) ?? '';
    double d(String key) => ((json[key] as num?) ?? 0).toDouble();
    
    final docs = (json['documents'] as List<dynamic>?)
            ?.map((e) => PlaceDocument.fromJson(e as Map<String, dynamic>))
            .toList() ??
        const <PlaceDocument>[];
    
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
      imageAsset: image,
      isPopular: (json['is_popular'] as bool?) ?? false,
      documents: docs,
      pdfUrl: pdfUrl.isEmpty ? null : pdfUrl,
      docUrl: docUrl.isEmpty ? null : docUrl,
      mapsLink: mapsLink.isEmpty ? null : mapsLink,
      order: (json['order'] as num?)?.toInt(),
    );
  }
}



