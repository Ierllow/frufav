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
    return MaterialApp(
      title: 'frufav',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Stack(
        children: [
          const FruitsListScreen(),
          Consumer(
            builder: (context, ref, child) {
              ref.listen(
                snackBarProvider,
                (previous, next) {
                  if (previous?.snackBar != next.snackBar &&
                      next.snackBar != null) {
                    ScaffoldMessenger.of(context).showSnackBar(next.snackBar!);
                  }
                },
              );
              return child ?? const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
