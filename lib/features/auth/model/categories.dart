class Type {
  final String value;
  final String label;
  final String id;

  Type({required this.value, required this.label, required this.id});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      value: json['value'],
      label: json['label'],
      id: json['_id'],
    );
  }
}

class Category {
  final String id;
  final String value;
  final String label;
  final String? imageUrl; // Make imageUrl nullable
  List<Type>? types;

  Category({
    required this.id,
    required this.value,
    required this.label,
    this.imageUrl,
    this.types,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    var list =
        json['types'] as List? ?? []; // Handle null 'types' field gracefully
    List<Type> typeList = list.map((i) => Type.fromJson(i)).toList();

    return Category(
      id: json['_id'],
      value: json['value'],
      label: json['label'],
      imageUrl: json['image'], // Nullable field now
      types: typeList,
    );
  }
}
