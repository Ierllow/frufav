import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/model/fruits_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FruitsListState extends Equatable {
  const FruitsListState({
    required this.fruitsInfoList,
    required this.favoriteFruitsInfoList,
  });

  factory FruitsListState.init() => const FruitsListState(
        fruitsInfoList: [],
        favoriteFruitsInfoList: [],
      );

  final List<FruitsInfo> fruitsInfoList;
  final List<FruitsInfo> favoriteFruitsInfoList;

  bool checkFavoriteFruitsInfo(FruitsInfo fruitsInfo) =>
      favoriteFruitsInfoList.any((f) => f.fruitsName == fruitsInfo.fruitsName);

  FruitsListState copyWith({
    List<FruitsInfo>? fruitsInfoList,
    List<FruitsInfo>? favoriteFruitsInfoList,
  }) =>
      FruitsListState(
          fruitsInfoList: fruitsInfoList ?? this.fruitsInfoList,
          favoriteFruitsInfoList:
              favoriteFruitsInfoList ?? this.favoriteFruitsInfoList);

  @override
  List<Object?> get props => [fruitsInfoList, favoriteFruitsInfoList];
}

class FruitsListNotifier extends StateNotifier<FruitsListState> {
  FruitsListNotifier() : super(FruitsListState.init()) {
    getAllFruitsInfo();
  }

  Future<void> getAllFruitsInfo() async {
    const path = 'assets/data/data.json';
    final body = await rootBundle.loadString(path);
    final jsonResponse = json.decode(body) as Map<String, dynamic>;
    final fruitsRaw = jsonResponse['fruitsInfoList'] as List? ?? <dynamic>[];
    if (fruitsRaw.isEmpty) return;
    final fruitsInfoList =
        fruitsRaw.map((f) => FruitsInfo.fromJson(f)).toList();
    final prefs = await SharedPreferences.getInstance();
    var favFruitsInfoList = prefs.getStringList("favFruitsInfoList");
    state = state.copyWith(
      fruitsInfoList: fruitsInfoList,
      favoriteFruitsInfoList: favFruitsInfoList
          ?.map((n) => fruitsInfoList.firstWhere((ff) => ff.fruitsName == n))
          .toList(),
    );
  }

  Future<void> addFavoriteFruitsInfo(FruitsInfo fruitsInfo) async {
    state = state.copyWith(
      favoriteFruitsInfoList: [...state.favoriteFruitsInfoList, fruitsInfo],
    );
    saveFavoriteFruitsInfoList();
  }

  Future<void> removeFavoriteFruitsInfo(FruitsInfo fruitsInfo) async {
    final removedInfo = state.favoriteFruitsInfoList..remove(fruitsInfo);
    state = state.copyWith(favoriteFruitsInfoList: [...removedInfo]);
    saveFavoriteFruitsInfoList();
  }

  Future<void> saveFavoriteFruitsInfoList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      "favFruitsInfoList",
      state.favoriteFruitsInfoList.map((f) => f.fruitsName!).toList(),
    );
  }
}
