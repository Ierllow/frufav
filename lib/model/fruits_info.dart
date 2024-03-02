import 'package:flutter/foundation.dart';

@immutable
class FruitsInfo {
  const FruitsInfo({
    required this.fruitsName,
    required this.thumbnailUrl,
    required this.overview,
    required this.history,
    required this.select,
    required this.selectImageUrl,
    required this.save,
    required this.saveImageUrl,
  });

  final String? fruitsName;

  final String? thumbnailUrl;

  final String? overview;

  final String? history;

  final String? select;

  final String? selectImageUrl;

  final String? save;

  final String? saveImageUrl;

  factory FruitsInfo.fromJson(Map<String, dynamic> map) => FruitsInfo(
        fruitsName:
            map['fruitsName'] is String ? map['fruitsName'] as String : null,
        thumbnailUrl: map['thumbnailUrl'] is String
            ? map['thumbnailUrl'] as String
            : null,
        overview: map['overview'] is String ? map['overview'] as String : null,
        history: map['history'] is String ? map['history'] as String : null,
        selectImageUrl: map['selectImageUrl'] is String
            ? map['selectImageUrl'] as String
            : null,
        select: map['select'] is String ? map['select'] as String : null,
        saveImageUrl: map['saveImageUrl'] is String
            ? map['saveImageUrl'] as String
            : null,
        save: map['save'] is String ? map['save'] as String : null,
      );

  FruitsInfo copyWith({
    String? fruitsName,
    String? description,
    String? thumbnailUrl,
    String? overview,
    String? history,
    String? select,
    String? selectImageUrl,
    String? save,
    String? saveImageUrl,
  }) =>
      FruitsInfo(
        fruitsName: fruitsName ?? this.fruitsName,
        thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
        overview: overview ?? this.overview,
        history: history ?? this.overview,
        select: select ?? this.select,
        selectImageUrl: selectImageUrl ?? this.selectImageUrl,
        save: save ?? this.save,
        saveImageUrl: saveImageUrl ?? this.saveImageUrl,
      );
}
