class FruitsInfo {
  FruitsInfo({
    required this.fruitsName,
    required this.description,
    required this.thumbnailUrl,
  });

  final String? fruitsName;

  final String? description;

  final String? thumbnailUrl;

  factory FruitsInfo.fromJson(Map<String, dynamic> map) => FruitsInfo(
        fruitsName:
            map['fruitsName'] is String ? map['fruitsName'] as String : null,
        description:
            map['description'] is String ? map['description'] as String : null,
        thumbnailUrl: map['thumbnailUrl'] is String
            ? map['thumbnailUrl'] as String
            : null,
      );

  FruitsInfo copyWith({
    String? fruitsName,
    String? description,
    String? thumbnailUrl,
  }) =>
      FruitsInfo(
        fruitsName: fruitsName ?? this.fruitsName,
        description: description ?? this.description,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      );
}
