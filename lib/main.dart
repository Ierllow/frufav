import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frufav/riverpod/fruits_go_router_provider.dart';
import 'package:frufav/riverpod/snack_bar_notifier.dart';

void main() {
  runApp(const ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'frufav',
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        body: Consumer(
          builder: (context, ref, __) {
            ref.listen(
              snackBarProvider,
              (previous, next) {
                final sameSnackBar = previous?.snackBar == next.snackBar;
                final nextSnackBar = next.snackBar;
                if (!sameSnackBar && nextSnackBar != null) {
                  ScaffoldMessenger.of(context).showSnackBar(nextSnackBar);
                }
              },
            );
            final goRouter = ref.watch(fruitsGoRouterProvider);
            return MaterialApp.router(
              routeInformationProvider: goRouter.routeInformationProvider,
              routeInformationParser: goRouter.routeInformationParser,
              routerDelegate: goRouter.routerDelegate,
            );
          },
        ),
      ),
    );
  }
}
