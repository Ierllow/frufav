import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/riverpod/snack_bar_notifier.dart';
import 'package:frufav/screen/fruits_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    getSnackBarProvider(context);
    return MaterialApp(
      title: 'frufav',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const FruitsListScreen(),
    );
  }
}
