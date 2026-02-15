class OversightCommittee {
  const OversightCommittee({
    required this.name,
    required this.role,
    required this.phone,
    required this.imageUrl,
    required this.year,
    this.order,
  });

  final String name;
  final String role;
  final String phone;
  final String imageUrl;
  final int year;
  final int? order; // For custom ordering

  factory OversightCommittee.fromJson(Map<String, dynamic> json) {
    String s(String key) => (json[key] as String?) ?? '';
    int i(String key) => (json[key] as int?) ?? 0;
    return OversightCommittee(
      name: s('name'),
      role: s('role'),
      phone: s('number').isNotEmpty ? s('number') : s('phone'),
      imageUrl: s('imageUrl').isNotEmpty ? s('imageUrl') : s('image_url'),
      year: i('year'),
      order: (json['order'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'phone': phone,
        'imageUrl': imageUrl,
        'year': year,
        'order': order,
      };
}
