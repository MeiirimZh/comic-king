class Character {
  final String name;
  final String imageUrl;
  final String? description;

  Character({
    required this.name,
    required this.imageUrl,
    this.description,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      name: json['name'] ?? 'Без имени',
      imageUrl: json['image'] != null
          ? json['image']['small_url'] ?? ''
          : '',
      description: json['description'],
    );
  }
}