import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final snackBarNotifierProvider =
    StateNotifierProvider<SnackBarNotifier, SnackBarState>(
        (_) => SnackBarNotifier());

class SnackBarState extends Equatable {
  const SnackBarState({
    required SnackBar? snackBar,
  }) : _snackBar = snackBar;

  factory SnackBarState.init() => const SnackBarState(snackBar: null);

  final SnackBar? _snackBar;

  SnackBar? get snackBar => _snackBar;

  @override
  List<Object?> get props => [_snackBar];

  SnackBarState copyWith({
    SnackBar? snackBar,
  }) =>
      SnackBarState(snackBar: snackBar ?? _snackBar);
}

class SnackBarNotifier extends StateNotifier<SnackBarState> {
  SnackBarNotifier() : super(SnackBarState.init());

  Future<void> add(SnackBar snackBar) async {
    state = state.copyWith(snackBar: snackBar);
  }
}

void getSnackBarProvider(BuildContext context) => Provider(
      (ref) => ref.listen(
        snackBarNotifierProvider,
        (previous, next) {
          if (next.snackBar != null) {
            ScaffoldMessenger.of(context).showSnackBar(next.snackBar!);
          }
        },
      ),
    );
