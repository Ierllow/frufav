import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/model/fruits_info.dart';

final fruitsListProvider =
    StateNotifierProvider<FruitsListNotifier, FruitsListState>(
        (_) => FruitsListNotifier());

class FruitsListState extends Equatable {
  const FruitsListState({required this.fruitsInfoList});

  factory FruitsListState.init() => const FruitsListState(fruitsInfoList: []);

  final List<FruitsInfo> fruitsInfoList;

  FruitsListState copyWith({List<FruitsInfo>? fruitsInfoList}) =>
      FruitsListState(fruitsInfoList: fruitsInfoList ?? this.fruitsInfoList);

  @override
  List<Object?> get props => [fruitsInfoList];
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
}
