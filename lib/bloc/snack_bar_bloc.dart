import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
abstract class SnackBarEvent {}

class _AddSnackBarEvent extends SnackBarEvent {
  _AddSnackBarEvent({required this.snackBar});

  final SnackBar snackBar;
}

class _RemoveSnackBarEvent extends SnackBarEvent {
  _RemoveSnackBarEvent({required this.snackBar});

  final SnackBar snackBar;
}

@immutable
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

class SnackBarBloc extends Bloc<SnackBarEvent, SnackBarState> {
  SnackBarBloc() : super(SnackBarState.init()) {
    on<_AddSnackBarEvent>(_addSnackBar);
    on<_RemoveSnackBarEvent>(_removeSnackBar);
  }

  Future<void> _addSnackBar(
    _AddSnackBarEvent event,
    Emitter<SnackBarState> emit,
  ) async {
    emit(state
        .copyWith(snackBarList: [...state._snackBarList!, event.snackBar]));
    removeSnackBar(event.snackBar);
  }

  Future<void> _removeSnackBar(
    _RemoveSnackBarEvent event,
    Emitter<SnackBarState> emit,
  ) async {
    emit(
      state.copyWith(
          snackBarList: state._snackBarList!
            ..removeWhere((s) => s == event.snackBar)),
    );
  }

  void addSnackBar(SnackBar snackBar) =>
      add(_AddSnackBarEvent(snackBar: snackBar));
  void removeSnackBar(SnackBar snackBar) =>
      add(_RemoveSnackBarEvent(snackBar: snackBar));
}
