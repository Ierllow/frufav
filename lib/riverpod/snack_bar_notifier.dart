import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final snackBarNotifierProvider =
    StateNotifierProvider<SnackBarNotifier, SnackBarState>(
        (_) => SnackBarNotifier());

class SnackBarState extends Equatable {
  const SnackBarState({
    required List<SnackBar> snackBarList,
  }) : _snackBarList = snackBarList;

  factory SnackBarState.init() => const SnackBarState(snackBarList: []);

  final List<SnackBar>? _snackBarList;

  SnackBar? get snackBar => _snackBarList?.lastOrNull;

  @override
  List<Object?> get props => [_snackBarList];

  SnackBarState copyWith({
    List<SnackBar>? snackBarList,
  }) =>
      SnackBarState(snackBarList: snackBarList ?? _snackBarList!);
}

class SnackBarNotifier extends StateNotifier<SnackBarState> {
  SnackBarNotifier() : super(SnackBarState.init());

  Future<void> add(SnackBar snackBar) async {
    state = state.copyWith(snackBarList: [...state._snackBarList!, snackBar]);
    remove(snackBar);
  }

  Future<void> remove(SnackBar snackBar) async {
    state = state.copyWith(
        snackBarList: state._snackBarList!..removeWhere((s) => s == snackBar));
  }
}

void snackBarListener(BuildContext context, WidgetRef ref) => ref.listen(
      snackBarNotifierProvider,
      (previous, next) {
        if (previous == next) return;
        if (next.snackBar != null) {
          ScaffoldMessenger.of(context).showSnackBar(next.snackBar!);
        }
      },
    );
