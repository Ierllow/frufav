import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/model/fruits_info.dart';

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
    state = state.copyWith(
      fruitsInfoList: fruitsRaw.map((f) => FruitsInfo.fromJson(f)).toList(),
    );
  }

  Future<void> addFavoriteFruitsInfo(FruitsInfo fruitsInfo) async {
    state = state.copyWith(
      favoriteFruitsInfoList: [...state.favoriteFruitsInfoList, fruitsInfo],
    );
  }
}

final fruitsListProvider =
    StateNotifierProvider<FruitsListNotifier, FruitsListState>(
        (_) => FruitsListNotifier());

void addFavoriteFruitsListener(
  BuildContext context,
  FruitsListState? previous,
  FruitsListState next,
) {
  if (next.favoriteFruitsInfoList.isEmpty) return;
  final snackBar = SnackBar(
    content: Container(
      alignment: AlignmentDirectional.center,
      child:
          Text('${next.favoriteFruitsInfoList.last.fruitsName}をお気に入りに登録しました。'),
    ),
    duration: const Duration(seconds: 3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    margin: const EdgeInsets.only(left: 23, right: 23, bottom: 23),
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
