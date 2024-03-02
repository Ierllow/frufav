import 'package:collection/collection.dart';
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
            map.entries.firstWhereOrNull((m) => m.key == 'fruitsName')?.value,
        thumbnailUrl:
            map.entries.firstWhereOrNull((m) => m.key == 'thumbnailUrl')?.value,
        overview:
            map.entries.firstWhereOrNull((m) => m.key == 'overview')?.value,
        history: map.entries.firstWhereOrNull((m) => m.key == 'history')?.value,
        selectImageUrl: map.entries
            .firstWhereOrNull((m) => m.key == 'selectImageUrl')
            ?.value,
        select: map.entries.firstWhereOrNull((m) => m.key == 'select')?.value,
        saveImageUrl:
            map.entries.firstWhereOrNull((m) => m.key == 'saveImageUrl')?.value,
        save: map.entries.firstWhereOrNull((m) => m.key == 'save')?.value,
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
