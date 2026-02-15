class Project {
  const Project({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.description,
    this.contactPhone,
    this.order,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String? description;
  final String? contactPhone;
  final int? order;

  factory Project.fromJson(Map<String, dynamic> json) {
    String s(String key) => (json[key] as String?) ?? '';
    
    // Title: Check multiple variants
    String name = s('display_name');
    if (name.isEmpty) name = s('name');
    if (name.isEmpty) name = s('name_tr');
    
    // Image: Check multiple variants (prioritize image_url)
    String imageUrl = s('image_url');
    if (imageUrl.isEmpty) imageUrl = s('imageUrl');
    if (imageUrl.isEmpty) imageUrl = s('logo_url');
    if (imageUrl.isEmpty) imageUrl = s('logoUrl');
    
    return Project(
      id: s('id'),
      name: name,
      imageUrl: imageUrl,
      description: s('description_ar').isEmpty ? s('description') : s('description_ar'),
      contactPhone: s('contact_phone').isEmpty ? (s('phone').isEmpty ? null : s('phone')) : s('contact_phone'),
      order: json['order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'description_ar': description,
      'contact_phone': contactPhone,
      'order': order,
    };
  }
}
