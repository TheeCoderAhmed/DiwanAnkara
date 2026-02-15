class UniversityModel {
  final String name;
  final String? logoUrl;
  final String? introductionDocUrl;
  final String? associateDocUrl;
  final String? bachelorDocUrl;
  final int? order; // For custom ordering

  const UniversityModel({
    required this.name,
    this.logoUrl,
    this.introductionDocUrl,
    this.associateDocUrl,
    this.bachelorDocUrl,
    this.order,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      name: json['name'] as String? ?? '',
      logoUrl: json['logo_url'] as String?,
      introductionDocUrl: json['introduction_url'] as String?,  // Fixed: was 'introduction_doc_url'
      associateDocUrl: json['associate_degree_url'] as String?,  // Fixed: was 'associate_doc_url'
      bachelorDocUrl: json['bachelor_degree_url'] as String?,    // Fixed: was 'bachelor_doc_url'
      order: (json['order'] as num?)?.toInt(),
    );
  }
}
