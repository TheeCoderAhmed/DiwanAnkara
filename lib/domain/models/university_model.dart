class UniversityModel {
  final String id;
  final String name;
  final String? logoUrl;
  final String? descriptionAr;
  final String? descriptionTr;
  final String? history;
  final String? ranking;
  final Map<String, String>? usefulLinks;
  final Map<String, String>? socialMedia;
  final double? lat;
  final double? lng;
  final List<String>? faculties;
  final List<String>? programs;
  final int? order;
  final String? introductionDocUrl;
  final String? associateDocUrl;
  final String? bachelorDocUrl;
  final int? establishment;
  final String? knownFor;

  const UniversityModel({
    required this.id,
    required this.name,
    this.logoUrl,
    this.descriptionAr,
    this.descriptionTr,
    this.history,
    this.ranking,
    this.usefulLinks,
    this.socialMedia,
    this.lat,
    this.lng,
    this.faculties,
    this.programs,
    this.introductionDocUrl,
    this.associateDocUrl,
    this.bachelorDocUrl,
    this.order,
    this.establishment,
    this.knownFor,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return UniversityModel(
      id: id ?? json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      logoUrl: json['logo_url'] as String?,
      descriptionAr: json['description_ar'] as String?,
      descriptionTr: json['description_tr'] as String?,
      history: json['history'] as String?,
      ranking: json['ranking'] as String?,
      usefulLinks: json['useful_links'] != null 
          ? Map<String, dynamic>.from(json['useful_links'] as Map).map(
              (k, v) => MapEntry(k, v as String),
            )
          : null,
      socialMedia: json['social_media'] != null 
          ? Map<String, dynamic>.from(json['social_media'] as Map).map(
              (k, v) => MapEntry(k, v as String),
            )
          : null,
      lat: (json['lat'] as num?)?.toDouble() ?? (json['location']?['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble() ?? (json['location']?['lng'] as num?)?.toDouble(),
      faculties: (json['faculties'] as List<dynamic>?)?.map((e) => e as String).toList(),
      programs: (json['programs'] as List<dynamic>?)?.map((e) => e as String).toList(),
      introductionDocUrl: json['introduction_url'] as String?,
      associateDocUrl: json['associate_degree_url'] as String?,
      bachelorDocUrl: json['bachelor_degree_url'] as String?,
      order: (json['order'] as num?)?.toInt(),
      establishment: (json['establishment'] as num?)?.toInt(),
      knownFor: json['known_for'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_url': logoUrl,
      'description_ar': descriptionAr,
      'description_tr': descriptionTr,
      'history': history,
      'ranking': ranking,
      'useful_links': usefulLinks,
      'social_media': socialMedia,
      'lat': lat,
      'lng': lng,
      'faculties': faculties,
      'programs': programs,
      'introduction_url': introductionDocUrl,
      'associate_degree_url': associateDocUrl,
      'bachelor_degree_url': bachelorDocUrl,
      'order': order,
      'establishment': establishment,
      'known_for': knownFor,
    };
  }
}
