import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final snackBarProvider = StateNotifierProvider<SnackBarNotifier, SnackBarState>(
  (_) => SnackBarNotifier(),
);

@immutable
class SnackBarState extends Equatable {
  const SnackBarState({
    required SnackBar? snackBar,
  }) : _snackBar = snackBar;

  final SnackBar? _snackBar;

  SnackBar? get snackBar => _snackBar;

  @override
  List<Object?> get props => [_snackBar];
}

class SnackBarNotifier extends StateNotifier<SnackBarState> {
  SnackBarNotifier() : super(const SnackBarState(snackBar: null));

  Future<void> addSnackBar(SnackBar snackBar) async {
    state = SnackBarState(snackBar: snackBar);
    removeSnackBar();
  }

  Future<void> removeSnackBar() async {
    state = const SnackBarState(snackBar: null);
  }
}
