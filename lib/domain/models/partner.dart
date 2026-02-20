class Partner {
  const Partner({
    required this.id,
    required this.name,
    required this.logoAsset,
    this.order,
  });

  final String id;
  final String name;
  final String logoAsset; // Can be asset path or logo_url from Firestore
  final int? order; // For custom ordering

  factory Partner.fromJson(Map<String, dynamic> json) {
    String s(String key) => (json[key] as String?) ?? '';
    // Support both logo_asset (legacy) and logo_url (Firestore)
    final logo = s('logo_url').isEmpty ? s('logo_asset') : s('logo_url');
    return Partner(
      id: s('id'),
      name: s('name'),
      logoAsset: logo,
      order: (json['order'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'logo_url': logoAsset, 'order': order};
  }
}
