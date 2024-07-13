class Banner {
  final String id;
  final List<String> imageUrl;

  Banner({required this.id, required this.imageUrl});

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['_id'] ?? '',
      imageUrl: List<String>.from(json['imageUrl'] ?? []),
    );
  }
}
