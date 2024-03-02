import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/drop_down_button_type.dart';
import 'package:frufav/model/fruits_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class FruitsListState extends Equatable {
  const FruitsListState({
    required this.fruitsInfoList,
    required this.favoriteFruitsInfoList,
    required this.lastSortedInfoListType,
  });

  factory FruitsListState.init() => const FruitsListState(
        fruitsInfoList: [],
        favoriteFruitsInfoList: [],
        lastSortedInfoListType: DropDownButtonType.all,
      );

  final List<FruitsInfo> favoriteFruitsInfoList;
  final List<FruitsInfo> fruitsInfoList;
  final DropDownButtonType lastSortedInfoListType;

  bool checkFavoriteFruitsInfo(FruitsInfo fruitsInfo) =>
      favoriteFruitsInfoList.any((f) => f.fruitsName == fruitsInfo.fruitsName);

  List<FruitsInfo> getFruitsInfoList() =>
      identical(lastSortedInfoListType, DropDownButtonType.all)
          ? fruitsInfoList
          : favoriteFruitsInfoList;

  FruitsListState copyWith({
    List<FruitsInfo>? fruitsInfoList,
    List<FruitsInfo>? favoriteFruitsInfoList,
    DropDownButtonType? lastSortedInfoListType,
  }) =>
      FruitsListState(
        fruitsInfoList: fruitsInfoList ?? this.fruitsInfoList,
        favoriteFruitsInfoList:
            favoriteFruitsInfoList ?? this.favoriteFruitsInfoList,
        lastSortedInfoListType:
            lastSortedInfoListType ?? this.lastSortedInfoListType,
      );

  @override
  List<Object?> get props => [
        fruitsInfoList,
        favoriteFruitsInfoList,
        lastSortedInfoListType,
      ];
}

class FruitsListNotifier extends StateNotifier<FruitsListState> {
  FruitsListNotifier() : super(FruitsListState.init()) {
    _getAllFruitsInfo();
  }

  late final SharedPreferences _prefs;

  Future<void> _getAllFruitsInfo() async {
    const path = 'assets/data/data.json';
    final body = await rootBundle.loadString(path);
    final jsonResponse = json.decode(body) as Map<String, dynamic>;
    final fruitsRaw = jsonResponse['fruitsInfoList'] as List? ?? <dynamic>[];

    if (fruitsRaw.isEmpty) return;

    final fruitsInfoList =
        fruitsRaw.map((f) => FruitsInfo.fromJson(f)).toList();
    _prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      fruitsInfoList: fruitsInfoList,
      favoriteFruitsInfoList: _prefs
          .getStringList("favFruitsInfoList")
          ?.getFavoriteFruitsInfoList(fruitsInfoList),
      lastSortedInfoListType:
          _prefs.getInt("lastSortedInfoListType").lastSortedInfoListType,
    );
  }

  Future<void> updateLastSortedInfoList(DropDownButtonType type) async {
    state = state.copyWith(lastSortedInfoListType: type);
    _saveLastSortedInfoList();
  }

  Future<void> addFavoriteFruitsInfo(FruitsInfo fruitsInfo) async {
    state = state.copyWith(
      favoriteFruitsInfoList: [...state.favoriteFruitsInfoList, fruitsInfo],
    );
    _saveFavoriteFruitsInfoList();
  }

  Future<void> removeFavoriteFruitsInfo(FruitsInfo fruitsInfo) async {
    state = state.copyWith(
      favoriteFruitsInfoList: state.favoriteFruitsInfoList..remove(fruitsInfo),
    );
    _saveFavoriteFruitsInfoList();
  }

  Future<void> _saveFavoriteFruitsInfoList() async {
    _prefs.setStringList(
      "favFruitsInfoList",
      state.favoriteFruitsInfoList.map((f) => f.fruitsName!).toList(),
    );
  }

  Future<void> _saveLastSortedInfoList() async {
    _prefs.setInt("lastSortedInfoListType", state.lastSortedInfoListType.index);
  }
}

extension on List<String> {
  List<FruitsInfo>? getFavoriteFruitsInfoList(List<FruitsInfo> info) =>
      map((n) => info.firstWhere((ff) => ff.fruitsName == n)).toList();
}

extension on int? {
  DropDownButtonType get lastSortedInfoListType => this != null
      ? DropDownButtonType.values.elementAtOrNull(this!)!
      : DropDownButtonType.all;
}
